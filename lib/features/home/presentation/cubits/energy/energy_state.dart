part of 'energy_cubit.dart';

@freezed
abstract class EnergyState with _$EnergyState {
  const factory EnergyState({
    required BigNumber currentEnergy,
    required BigNumber energyPerSecond,
  }) = _EnergyState;

  factory EnergyState.initial() => EnergyState(
    currentEnergy: GameConstants.initialEnergy,
    energyPerSecond: GameConstants.startingEnergyPerSecond,
  );
}
