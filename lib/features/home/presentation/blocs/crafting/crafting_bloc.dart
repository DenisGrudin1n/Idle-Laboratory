import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/bloc/safe_bloc.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/research_material_l10n_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/core/utils/research_material_tree.dart';
import 'package:idle_laboratory/features/home/domain/services/cells_service.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart';
import 'package:injectable/injectable.dart';

part 'crafting_event.dart';
part 'crafting_state.dart';
part 'crafting_bloc.freezed.dart';

@injectable
class CraftingBloc extends SafeBloc<CraftingEvent, CraftingState> {
  CraftingBloc(
    this._cellsService,
    this._energyService,
    this._storageService,
  ) : super(const CraftingState()) {
    on<_CellSlotChanged>(_onCellSlotChanged);
    on<_Reagent1Changed>(_onReagent1Changed);
    on<_Reagent2Changed>(_onReagent2Changed);
    on<_InputsCleared>((_, emit) => emit(const CraftingState()));
    on<_StartReaction>(_onStartReaction);
    on<_Tick>(_onTick);
  }

  final CellsService _cellsService;
  final EnergyService _energyService;
  final StorageService _storageService;

  Timer? _craftingTimer;
  static const _tickInterval = Duration(milliseconds: 100);
  static const _craftingDurationSeconds = 5;
  static final _craftingEnergyCost = BigNumber(5, 0);

  void _onCellSlotChanged(_CellSlotChanged event, Emitter<CraftingState> emit) {
    if (state.isCrafting) return;
    final newState = state.copyWith(
      selectedCellId: event.cellId,
      reagent1Id: null,
      reagent2Id: null,
    );
    emit(newState.copyWith(craftingMaterialId: _calculateOutput(newState)));
  }

  void _onReagent1Changed(_Reagent1Changed event, Emitter<CraftingState> emit) {
    if (state.isCrafting) return;
    final newState = state.copyWith(
      reagent1Id: event.materialId,
      selectedCellId: null,
    );
    emit(newState.copyWith(craftingMaterialId: _calculateOutput(newState)));
  }

  void _onReagent2Changed(_Reagent2Changed event, Emitter<CraftingState> emit) {
    if (state.isCrafting) return;
    final newState = state.copyWith(
      reagent2Id: event.materialId,
      selectedCellId: null,
    );
    emit(newState.copyWith(craftingMaterialId: _calculateOutput(newState)));
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

  void _onStartReaction(_StartReaction event, Emitter<CraftingState> emit) {
    if (state.isCrafting || state.craftingMaterialId == null) return;

    // Check energy
    if (_energyService.currentEnergy < _craftingEnergyCost) return;

    if (state.selectedCellId != null) {
      // Cell-based crafting
      final cellId = state.selectedCellId!;
      final cellCost = GameBalance.calculateBaseTierResearchCraftCellCost(cellId.order);
      final currentCellAmount = _cellsService.currentProduction[cellId.id]?.amount ?? BigNumber.zero();
      if (currentCellAmount < cellCost) return;

      _energyService.trySpendEnergy(_craftingEnergyCost);
      _cellsService.trySpendCells(cellId, cellCost);
    } else if (state.reagent1Id != null && state.reagent2Id != null) {
      // Material-based merging
      if (!_storageService.hasMaterial(state.reagent1Id!) ||
          !_storageService.hasMaterial(state.reagent2Id!)) return;
      
      // Special case: if same material is used twice, need 2 of them
      if (state.reagent1Id == state.reagent2Id) {
        if (!_storageService.hasMaterial(state.reagent1Id!, count: 2)) return;
      }

      _energyService.trySpendEnergy(_craftingEnergyCost);
      _storageService
        ..trySpendMaterial(state.reagent1Id!)
        ..trySpendMaterial(state.reagent2Id!);
    } else {
      return;
    }

    emit(state.copyWith(
      isCrafting: true,
      craftingProgress: 0,
    ));

    _startTimer();
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
      _craftingTimer?.cancel();
      if (state.craftingMaterialId != null) {
        _storageService.addMaterial(state.craftingMaterialId!);
      }
      emit(state.copyWith(
        isCrafting: false,
        craftingProgress: 0,
        craftingMaterialId: null,
        selectedCellId: null,
        reagent1Id: null,
        reagent2Id: null,
      ));
    } else {
      emit(state.copyWith(craftingProgress: newProgress));
    }
  }

  @override
  Future<void> close() async {
    _craftingTimer?.cancel();
    return super.close();
  }
}
