import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/services/cells_service.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';

part 'cells_cubit.freezed.dart';
part 'cells_state.dart';

/// Thin wrapper around CellsService for UI state management.
///
/// This cubit subscribes to CellsService streams and emits states
/// for the UI layer. All business logic is in CellsService.
class CellsCubit extends Cubit<CellsState> {
  CellsCubit(this._cellsService, this._energyService)
    : super(const CellsState()) {
    _initialize();
  }

  final CellsService _cellsService;
  final EnergyService _energyService;

  StreamSubscription<List<CellModel>>? _cellsSubscription;
  StreamSubscription<Map<String, BigNumber>>? _cellEnergiesSubscription;
  StreamSubscription<BigNumber>? _totalEnergySubscription;

  void _initialize() {
    // Subscribe to cells changes
    _cellsSubscription = _cellsService.cells$.listen((List<CellModel> cells) {
      emit(
        state.copyWith(
          cells: cells,
          selectedCellId:
              state.selectedCellId ??
              (cells.isNotEmpty ? cells.first.id : null),
        ),
      );
    });

    // Subscribe to per-cell energies
    _cellEnergiesSubscription = _cellsService.cellEnergies$.listen((
      Map<String, BigNumber> cellEnergies,
    ) {
      emit(state.copyWith(cellEnergies: cellEnergies));
    });

    // Subscribe to total energy changes
    _totalEnergySubscription = _energyService.energy$.listen((
      BigNumber energy,
    ) {
      emit(state.copyWith(totalEnergy: energy));
    });
  }

  /// Selects a cell by ID
  void selectCell(String cellId) {
    emit(state.copyWith(selectedCellId: cellId));
  }

  /// Starts the progression system
  void start() {
    _cellsService.start();
  }

  /// Get fill level (0.0 to 1.0) for cell container visualization
  double getFillLevel(String? cellId) {
    if (cellId == null) {
      return 0.0;
    }
    return _cellsService.getFillLevel(cellId);
  }

  @override
  Future<void> close() {
    _cellsSubscription?.cancel();
    _cellEnergiesSubscription?.cancel();
    _totalEnergySubscription?.cancel();
    return super.close();
  }
}
