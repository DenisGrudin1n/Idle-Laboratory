part of 'energy_bloc.dart';

@freezed
class EnergyEvent with _$EnergyEvent {
  const factory EnergyEvent.energyChanged(BigNumber energy) = _EnergyChanged;
  const factory EnergyEvent.epsChanged(BigNumber eps) = _EpsChanged;
  const factory EnergyEvent.start() = _Start;
  const factory EnergyEvent.updateEPS(BigNumber eps) = _UpdateEPS;
}
