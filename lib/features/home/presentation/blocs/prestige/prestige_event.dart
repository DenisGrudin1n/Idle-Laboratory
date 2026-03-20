part of 'prestige_bloc.dart';

@freezed
class PrestigeEvent with _$PrestigeEvent {
  const factory PrestigeEvent.prestigeStateChanged(PrestigeStateModel prestigeState) = _PrestigeStateChanged;
  const factory PrestigeEvent.start() = _Start;
  const factory PrestigeEvent.prestige() = _Prestige;
  const factory PrestigeEvent.resetPrestige() = _ResetPrestige;
}
