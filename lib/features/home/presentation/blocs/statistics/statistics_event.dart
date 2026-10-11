part of 'statistics_bloc.dart';

@freezed
class StatisticsEvent with _$StatisticsEvent {
  /// Subscribe to live streams only while the Statistics tab is mounted.
  const factory StatisticsEvent.setWatching({required bool watching}) = _SetWatching;

  /// Wall-clock catch-up after hot reload / resume when the tab is already open.
  const factory StatisticsEvent.syncPlaytimeClock() = _SyncPlaytimeClock;

  const factory StatisticsEvent.statsChanged(StatisticsModel stats) = _StatsChanged;
  const factory StatisticsEvent.energyChanged(BigNumber energy) = _EnergyChanged;
  const factory StatisticsEvent.epsChanged(BigNumber eps) = _EpsChanged;
  const factory StatisticsEvent.prestigeChanged(PrestigeStateModel prestige) = _PrestigeChanged;
  const factory StatisticsEvent.totalCellLevelsChanged(int total) = _TotalCellLevelsChanged;
  const factory StatisticsEvent.totalProductionLevelsChanged(int total) = _TotalProductionLevelsChanged;
}
