import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/bloc/safe_bloc.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/constants/game_errors.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/research_material_l10n_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/core/utils/research_material_tree.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_production_entry/cell_production_entry.dart';
import 'package:idle_laboratory/features/home/domain/services/cells_service.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart';
import 'package:injectable/injectable.dart';

import 'package:rxdart/rxdart.dart';

part 'crafting_event.dart';
part 'crafting_state.dart';
part 'crafting_bloc.freezed.dart';

@injectable
class CraftingBloc extends SafeBloc<CraftingEvent, CraftingState> {
  CraftingBloc(this._cellsService, this._energyService, this._storageService) : super(const CraftingState()) {
    on<_CellSlotChanged>(_onCellSlotChanged);
    on<_Reagent1Changed>(_onReagent1Changed);
    on<_Reagent2Changed>(_onReagent2Changed);
    on<_TargetQuantityChanged>(_onTargetQuantityChanged);
    on<_InputsCleared>((_, emit) => emit(const CraftingState()));
    on<_StartReaction>(_onStartReaction);
    on<_StopReaction>(_onStopReaction);
    on<_Validate>((_, emit) => _validateAndEmit(state, emit));
    on<_Tick>(_onTick);

    _setupServiceListeners();
  }

  final CellsService _cellsService;
  final EnergyService _energyService;
  final StorageService _storageService;

  StreamSubscription<bool>? _serviceSubscription;

  void _setupServiceListeners() {
    _serviceSubscription =
        Rx.combineLatest3<Map<String, CellProductionEntry>, BigNumber, Map<ResearchMaterialId, int>, bool>(
          _cellsService.production$,
          _energyService.energy$,
          _storageService.inventory$,
          (p, e, i) => true,
        ).listen((_) {
          if (!isClosed) add(const CraftingEvent.validate());
        });
  }

  Timer? _craftingTimer;
  static const _tickInterval = Duration(milliseconds: 100);
  static const _craftingDurationSeconds = 5;
  static final _craftingEnergyCost = BigNumber(5, 0);

  void _onCellSlotChanged(_CellSlotChanged event, Emitter<CraftingState> emit) {
    if (state.isCrafting) return;
    final newState = state.copyWith(selectedCellId: event.cellId, reagent1Id: null, reagent2Id: null);
    _validateAndEmit(newState, emit);
  }

  void _onReagent1Changed(_Reagent1Changed event, Emitter<CraftingState> emit) {
    if (state.isCrafting) return;
    final newState = state.copyWith(reagent1Id: event.materialId, selectedCellId: null);
    _validateAndEmit(newState, emit);
  }

  void _onReagent2Changed(_Reagent2Changed event, Emitter<CraftingState> emit) {
    if (state.isCrafting) return;
    final newState = state.copyWith(reagent2Id: event.materialId, selectedCellId: null);
    _validateAndEmit(newState, emit);
  }

  void _onTargetQuantityChanged(_TargetQuantityChanged event, Emitter<CraftingState> emit) {
    if (state.isCrafting) return;
    final newState = state.copyWith(targetQuantity: event.quantity.clamp(1, 999999));
    _validateAndEmit(newState, emit);
  }

  void _validateAndEmit(CraftingState newState, Emitter<CraftingState> emit) {
    final output = _calculateOutput(newState);
    final error = _checkError(newState);
    emit(newState.copyWith(craftingMaterialId: output, error: error));
  }

  ResearchMaterialId? _calculateOutput(CraftingState state) {
    if (state.selectedCellId != null) {
      return state.selectedCellId!.baseResearchMaterial;
    }
    if (state.reagent1Id != null && state.reagent2Id != null) {
      final i1 = state.reagent1Id!.index;
      final i2 = state.reagent2Id!.index;
      final p1 = ResearchMaterialTree.parentIndex(i1);
      final p2 = ResearchMaterialTree.parentIndex(i2);
      if (p1 != null && p1 == p2) {
        return ResearchMaterialId.values[p1];
      }
    }
    return null;
  }

  String? _checkError(CraftingState state) {
    if (state.selectedCellId == null && (state.reagent1Id == null || state.reagent2Id == null)) {
      return null;
    }

    final output = _calculateOutput(state);
    if (output == null) return null;

    final target = BigNumber(state.targetQuantity.toDouble(), 0);

    // Check energy
    final totalEnergyCost = _craftingEnergyCost * target;
    if (_energyService.currentEnergy < totalEnergyCost) {
      return GameErrors.craftingNotEnoughEnergy;
    }

    if (state.selectedCellId != null) {
      final cellId = state.selectedCellId!;
      final cellCostPerUnit = GameBalance.calculateBaseTierResearchCraftCellCost(cellId.order);
      final totalCellCost = cellCostPerUnit * target;
      final currentCellAmount = _cellsService.currentProduction[cellId.id]?.amount ?? BigNumber.zero();
      if (currentCellAmount < totalCellCost) {
        return GameErrors.craftingNotEnoughMaterials;
      }
    } else if (state.reagent1Id != null && state.reagent2Id != null) {
      final r1 = state.reagent1Id!;
      final r2 = state.reagent2Id!;
      final q = state.targetQuantity;

      if (r1 == r2) {
        if (!_storageService.hasMaterial(r1, count: q * 2)) {
          return GameErrors.craftingNotEnoughMaterials;
        }
      } else {
        if (!_storageService.hasMaterial(r1, count: q) || !_storageService.hasMaterial(r2, count: q)) {
          return GameErrors.craftingNotEnoughMaterials;
        }
      }
    }

    return null;
  }

  void _onStartReaction(_StartReaction event, Emitter<CraftingState> emit) {
    if (state.isCrafting || state.craftingMaterialId == null || state.error != null) return;

    // We don't spend anything upfront anymore.
    // We only check if we have enough for at least 1 unit to start.
    if (!_hasEnoughForOneUnit(state)) return;

    emit(state.copyWith(isCrafting: true, craftingProgress: 0));

    _startTimer();
  }

  bool _hasEnoughForOneUnit(CraftingState state) {
    if (state.craftingMaterialId == null) return false;

    // Check energy for 1 unit
    if (_energyService.currentEnergy < _craftingEnergyCost) return false;

    if (state.selectedCellId != null) {
      final cellId = state.selectedCellId!;
      final cellCost = GameBalance.calculateBaseTierResearchCraftCellCost(cellId.order);
      final currentCellAmount = _cellsService.currentProduction[cellId.id]?.amount ?? BigNumber.zero();
      if (currentCellAmount < cellCost) return false;
    } else if (state.reagent1Id != null && state.reagent2Id != null) {
      final r1 = state.reagent1Id!;
      final r2 = state.reagent2Id!;

      if (r1 == r2) {
        if (!_storageService.hasMaterial(r1, count: 2)) return false;
      } else {
        if (!_storageService.hasMaterial(r1) || !_storageService.hasMaterial(r2)) return false;
      }
    }
    return true;
  }

  void _onStopReaction(_StopReaction event, Emitter<CraftingState> emit) {
    _craftingTimer?.cancel();
    emit(state.copyWith(isCrafting: false, craftingProgress: 0));
  }

  void _startTimer() {
    _craftingTimer?.cancel();
    _craftingTimer = Timer.periodic(_tickInterval, (timer) {
      add(CraftingEvent.tick(_tickInterval.inMilliseconds / 1000));
    });
  }

  void _onTick(_Tick event, Emitter<CraftingState> emit) {
    if (!state.isCrafting) {
      _craftingTimer?.cancel();
      return;
    }

    final newProgress = state.craftingProgress + (event.dt / _craftingDurationSeconds);
    if (newProgress >= 1.0) {
      // Check if we still have enough for this 1 unit before finalizing
      if (!_hasEnoughForOneUnit(state)) {
        _craftingTimer?.cancel();
        emit(state.copyWith(isCrafting: false, craftingProgress: 0));
        return;
      }

      // Spend inputs for 1 unit
      _energyService.trySpendEnergy(_craftingEnergyCost);
      if (state.selectedCellId != null) {
        final cellId = state.selectedCellId!;
        final cellCost = GameBalance.calculateBaseTierResearchCraftCellCost(cellId.order);
        _cellsService.trySpendCells(cellId, cellCost);
      } else {
        _storageService
          ..trySpendMaterial(state.reagent1Id!)
          ..trySpendMaterial(state.reagent2Id!);
      }

      // Add output
      if (state.craftingMaterialId != null) {
        _storageService.addMaterial(state.craftingMaterialId!);
      }

      final nextQuantity = state.targetQuantity - 1;
      if (nextQuantity <= 0) {
        _craftingTimer?.cancel();
        emit(
          state.copyWith(
            isCrafting: false,
            craftingProgress: 0,
            craftingMaterialId: null,
            selectedCellId: null,
            reagent1Id: null,
            reagent2Id: null,
            targetQuantity: 1,
          ),
        );
      } else {
        // Check if enough for the NEXT unit
        final nextState = state.copyWith(targetQuantity: nextQuantity);
        if (!_hasEnoughForOneUnit(nextState)) {
          _craftingTimer?.cancel();
          emit(nextState.copyWith(isCrafting: false, craftingProgress: 0));
        } else {
          emit(nextState.copyWith(craftingProgress: 0));
        }
      }
    } else {
      emit(state.copyWith(craftingProgress: newProgress));
    }
  }

  @override
  Future<void> close() async {
    _craftingTimer?.cancel();
    await _serviceSubscription?.cancel();
    return super.close();
  }
}
