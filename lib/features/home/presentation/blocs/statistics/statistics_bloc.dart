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
    on<_StatsChanged>(_onStatsChanged);
    on<_EnergyChanged>(_onEnergyChanged);
    on<_EpsChanged>(_onEpsChanged);
    on<_PrestigeChanged>(_onPrestigeChanged);
    on<_CellsChanged>(_onCellsChanged);
    on<_ProductionChanged>(_onProductionChanged);
    _subscribe();
  }

  final StatisticsService _statisticsService;
  final EnergyService _energyService;
  final PrestigeService _prestigeService;
  final CellsService _cellsService;

  StreamSubscription<StatisticsModel>? _statsSub;
  StreamSubscription<BigNumber>? _energySub;
  StreamSubscription<BigNumber>? _epsSub;
  StreamSubscription<PrestigeStateModel>? _prestigeSub;
  StreamSubscription<List<CellModel>>? _cellsSub;
  StreamSubscription<Map<String, CellProductionEntry>>? _productionSub;

  void _subscribe() {
    _statsSub = _statisticsService.statistics$.listen((stats) => add(StatisticsEvent.statsChanged(stats)));
    _energySub = _energyService.energy$.listen((energy) => add(StatisticsEvent.energyChanged(energy)));
    _epsSub = _energyService.eps$.listen((eps) => add(StatisticsEvent.epsChanged(eps)));
    _prestigeSub = _prestigeService.prestigeState$.listen(
      (prestige) => add(StatisticsEvent.prestigeChanged(prestige)),
    );
    _cellsSub = _cellsService.cells$.listen((cells) => add(StatisticsEvent.cellsChanged(cells)));
    _productionSub = _cellsService.production$.listen(
      (production) => add(StatisticsEvent.productionChanged(production)),
    );
  }

  void _onStart(_Start event, Emitter<StatisticsState> emit) => _statisticsService.start();

  void _onStatsChanged(_StatsChanged event, Emitter<StatisticsState> emit) =>
      emit(state.copyWith(stats: event.stats));

  void _onEnergyChanged(_EnergyChanged event, Emitter<StatisticsState> emit) =>
      emit(state.copyWith(currentEnergy: event.energy));

  void _onEpsChanged(_EpsChanged event, Emitter<StatisticsState> emit) =>
      emit(state.copyWith(currentEps: event.eps));

  void _onPrestigeChanged(_PrestigeChanged event, Emitter<StatisticsState> emit) => emit(
        state.copyWith(
          prestigeCount: event.prestige.prestigeCount,
          currentPrestigeMultiplier: event.prestige.totalMultiplier,
        ),
      );

  void _onCellsChanged(_CellsChanged event, Emitter<StatisticsState> emit) {
    final total = event.cells.fold<int>(0, (sum, cell) => sum + (cell.isLocked ? 0 : cell.level));
    emit(state.copyWith(totalCellLevels: total));
  }

  void _onProductionChanged(_ProductionChanged event, Emitter<StatisticsState> emit) {
    final total = event.production.values.fold<int>(0, (sum, entry) => sum + entry.accelerationLevel);
    emit(state.copyWith(totalProductionLevels: total));
  }

  @override
  Future<void> close() async {
    await _statsSub?.cancel();
    await _energySub?.cancel();
    await _epsSub?.cancel();
    await _prestigeSub?.cancel();
    await _cellsSub?.cancel();
    await _productionSub?.cancel();
    return super.close();
  }
}
