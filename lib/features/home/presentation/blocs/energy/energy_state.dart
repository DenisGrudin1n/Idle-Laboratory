part of 'energy_bloc.dart';

@freezed
abstract class EnergyState with _$EnergyState {
  const factory EnergyState({
    required BigNumber currentEnergy,
    required BigNumber energyPerSecond,
  }) = _EnergyState;

  factory EnergyState.initial() => EnergyState(
    currentEnergy: BigNumber.zero(),
    energyPerSecond: BigNumber.zero(),
  );
}
