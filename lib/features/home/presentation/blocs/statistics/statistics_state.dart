part of 'statistics_bloc.dart';

@freezed
abstract class StatisticsState with _$StatisticsState {
  const factory StatisticsState({
    required StatisticsModel stats,
    required BigNumber currentEnergy,
    required BigNumber currentEps,
    required int prestigeCount,
    required BigNumber currentPrestigeMultiplier,
    required int totalCellLevels,
    required int totalProductionLevels,
  }) = _StatisticsState;

  factory StatisticsState.initial() => StatisticsState(
        stats: StatisticsModel.initial(),
        currentEnergy: BigNumber.zero(),
        currentEps: BigNumber.zero(),
        prestigeCount: 0,
        currentPrestigeMultiplier: BigNumber.zero(),
        totalCellLevels: 0,
        totalProductionLevels: 0,
      );
}
