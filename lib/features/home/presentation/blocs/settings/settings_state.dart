part of 'settings_bloc.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({required bool isScientificNotation}) =
      _SettingsState;

  factory SettingsState.initial() =>
      const SettingsState(isScientificNotation: false);
}
