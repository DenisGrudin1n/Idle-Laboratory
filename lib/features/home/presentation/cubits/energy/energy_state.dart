import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/constants/game_constants.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';

part 'energy_state.freezed.dart';

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
