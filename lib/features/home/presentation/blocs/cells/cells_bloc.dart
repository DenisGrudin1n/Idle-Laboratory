import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/bloc/safe_bloc.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/services/cells_service.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:injectable/injectable.dart';

part 'cells_event.dart';
part 'cells_state.dart';
part 'cells_bloc.freezed.dart';

@injectable
class CellsBloc extends SafeBloc<CellsEvent, CellsState> {
  CellsBloc(this._cellsService, this._energyService) : super(const CellsState()) {
    on<_CellsChanged>(_onCellsChanged);
    on<_CellEnergiesChanged>(_onCellEnergiesChanged);
    on<_TotalEnergyChanged>(_onTotalEnergyChanged);
    on<_SelectCell>(_onSelectCell);
    on<_Start>(_onStart);
    _initialize();
  }

  final CellsService _cellsService;
  final EnergyService _energyService;
  StreamSubscription<List<CellModel>>? _cellsSubscription;
  StreamSubscription<Map<String, BigNumber>>? _cellEnergiesSubscription;
  StreamSubscription<BigNumber>? _totalEnergySubscription;

  void _initialize() {
    _cellsSubscription = _cellsService.cells$.listen((cells) => add(CellsEvent.cellsChanged(cells)));
    _cellEnergiesSubscription = _cellsService.cellEnergies$.listen((cellEnergies) => add(CellsEvent.cellEnergiesChanged(cellEnergies)));
    _totalEnergySubscription = _energyService.energy$.listen((energy) => add(CellsEvent.totalEnergyChanged(energy)));
  }

  void _onCellsChanged(_CellsChanged event, Emitter<CellsState> emit) => emit(state.copyWith(
        cells: event.cells,
        selectedCellId: state.selectedCellId ?? (event.cells.isNotEmpty ? event.cells.first.id : null),
      ));

  void _onCellEnergiesChanged(_CellEnergiesChanged event, Emitter<CellsState> emit) => emit(state.copyWith(cellEnergies: event.cellEnergies));

  void _onTotalEnergyChanged(_TotalEnergyChanged event, Emitter<CellsState> emit) => emit(state.copyWith(totalEnergy: event.energy));

  void _onSelectCell(_SelectCell event, Emitter<CellsState> emit) => emit(state.copyWith(selectedCellId: event.cellId));

  void _onStart(_Start event, Emitter<CellsState> emit) => _cellsService.start();

  double getFillLevel(String? cellId) => cellId == null ? 0.0 : _cellsService.getFillLevel(cellId);

  @override
  Future<void> close() async {
    await _cellsSubscription?.cancel();
    await _cellEnergiesSubscription?.cancel();
    await _totalEnergySubscription?.cancel();
    return super.close();
  }
}
