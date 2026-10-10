import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/bloc/safe_bloc.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_production_entry/cell_production_entry.dart';
import 'package:idle_laboratory/features/home/domain/models/prestige_state_model/prestige_state_model.dart';
import 'package:idle_laboratory/features/home/domain/models/statistics_model/statistics_model.dart';
import 'package:idle_laboratory/features/home/domain/services/cells_service.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:idle_laboratory/features/home/domain/services/prestige_service.dart';
import 'package:idle_laboratory/features/home/domain/services/statistics_service.dart';
import 'package:injectable/injectable.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';
part 'statistics_bloc.freezed.dart';

@injectable
class StatisticsBloc extends SafeBloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc(
    this._statisticsService,
    this._energyService,
    this._prestigeService,
    this._cellsService,
  ) : super(StatisticsState.initial()) {
    on<_Start>(_onStart);
    on<_SetWatching>(_onSetWatching);
    on<_StatsChanged>(_onStatsChanged);
    on<_EnergyChanged>(_onEnergyChanged);
    on<_EpsChanged>(_onEpsChanged);
    on<_PrestigeChanged>(_onPrestigeChanged);
    on<_CellsChanged>(_onCellsChanged);
    on<_ProductionChanged>(_onProductionChanged);
  }

  final StatisticsService _statisticsService;
  final EnergyService _energyService;
  final PrestigeService _prestigeService;
  final CellsService _cellsService;

  bool _watching = false;

  final List<StreamSubscription<Object?>> _subscriptions = [];

  Future<void> _onStart(_Start event, Emitter<StatisticsState> emit) => _statisticsService.start();

  Future<void> _onSetWatching(_SetWatching event, Emitter<StatisticsState> emit) async {
    if (event.watching) {
      if (_watching) return;
      _watching = true;
      _subscribe();
      emit(_snapshotFromServices());
      return;
    }
    if (!_watching) return;
    _watching = false;
    await _unsubscribe();
  }

  StatisticsState _snapshotFromServices() {
    final cells = _cellsService.currentCells;
    final production = _cellsService.currentProduction;
    final prestige = _prestigeService.currentState;
    return state.copyWith(
      stats: _statisticsService.current,
      currentEnergy: _energyService.currentEnergy,
      currentEps: _energyService.currentEPS,
      prestigeCount: prestige.prestigeCount,
      currentPrestigeMultiplier: prestige.totalMultiplier,
      totalCellLevels: _totalCellLevels(cells),
      totalProductionLevels: _totalProductionLevels(production),
    );
  }

  void _subscribe() {
    _subscriptions.addAll([
      _statisticsService.statistics$.listen((stats) => add(StatisticsEvent.statsChanged(stats))),
      _energyService.energy$.listen((energy) => add(StatisticsEvent.energyChanged(energy))),
      _energyService.eps$.listen((eps) => add(StatisticsEvent.epsChanged(eps))),
      _prestigeService.prestigeState$.listen((prestige) => add(StatisticsEvent.prestigeChanged(prestige))),
      _cellsService.cells$.listen((cells) => add(StatisticsEvent.cellsChanged(cells))),
      _cellsService.production$.listen((production) => add(StatisticsEvent.productionChanged(production))),
    ]);
  }

  /// Detaches subscriptions synchronously before awaiting cancels, so a
  /// concurrent `setWatching(true)` never has its fresh subscriptions cancelled.
  Future<void> _unsubscribe() async {
    final detached = List.of(_subscriptions);
    _subscriptions.clear();
    await Future.wait(detached.map((sub) => sub.cancel()));
  }

  void _onStatsChanged(_StatsChanged event, Emitter<StatisticsState> emit) {
    if (!_watching) return;
    emit(state.copyWith(stats: event.stats));
  }

  void _onEnergyChanged(_EnergyChanged event, Emitter<StatisticsState> emit) {
    if (!_watching) return;
    emit(state.copyWith(currentEnergy: event.energy));
  }

  void _onEpsChanged(_EpsChanged event, Emitter<StatisticsState> emit) {
    if (!_watching) return;
    emit(state.copyWith(currentEps: event.eps));
  }

  void _onPrestigeChanged(_PrestigeChanged event, Emitter<StatisticsState> emit) {
    if (!_watching) return;
    emit(
      state.copyWith(
        prestigeCount: event.prestige.prestigeCount,
        currentPrestigeMultiplier: event.prestige.totalMultiplier,
      ),
    );
  }

  void _onCellsChanged(_CellsChanged event, Emitter<StatisticsState> emit) {
    if (!_watching) return;
    emit(state.copyWith(totalCellLevels: _totalCellLevels(event.cells)));
  }

  void _onProductionChanged(_ProductionChanged event, Emitter<StatisticsState> emit) {
    if (!_watching) return;
    emit(state.copyWith(totalProductionLevels: _totalProductionLevels(event.production)));
  }

  static int _totalCellLevels(List<CellModel> cells) =>
      cells.fold<int>(0, (sum, cell) => sum + (cell.isLocked ? 0 : cell.level));

  static int _totalProductionLevels(Map<String, CellProductionEntry> production) =>
      production.values.fold<int>(0, (sum, entry) => sum + entry.accelerationLevel);

  @override
  Future<void> close() async {
    await _unsubscribe();
    return super.close();
  }
}
