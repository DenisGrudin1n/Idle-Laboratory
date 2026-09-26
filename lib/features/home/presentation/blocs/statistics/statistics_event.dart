part of 'statistics_bloc.dart';

@freezed
class StatisticsEvent with _$StatisticsEvent {
  const factory StatisticsEvent.start() = _Start;

  /// Subscribe to live streams only while the Statistics tab is mounted.
  const factory StatisticsEvent.setWatching({required bool watching}) = _SetWatching;

  const factory StatisticsEvent.statsChanged(StatisticsModel stats) = _StatsChanged;
  const factory StatisticsEvent.energyChanged(BigNumber energy) = _EnergyChanged;
  const factory StatisticsEvent.epsChanged(BigNumber eps) = _EpsChanged;
  const factory StatisticsEvent.prestigeChanged(PrestigeStateModel prestige) = _PrestigeChanged;
  const factory StatisticsEvent.cellsChanged(List<CellModel> cells) = _CellsChanged;
  const factory StatisticsEvent.productionChanged(Map<String, CellProductionEntry> production) =
      _ProductionChanged;
}
