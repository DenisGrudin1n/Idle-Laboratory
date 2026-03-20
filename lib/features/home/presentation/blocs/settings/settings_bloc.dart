import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/bloc/safe_bloc.dart';
import 'package:idle_laboratory/features/home/data/repositories/settings_repository.dart';
import 'package:injectable/injectable.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.freezed.dart';

@injectable
class SettingsBloc extends SafeBloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._settingsRepository) : super(SettingsState.initial()) {
    on<_ToggleScientificNotation>(_onToggleScientificNotation);
    _loadSettings();
  }

  final SettingsRepository _settingsRepository;

  Future<void> _loadSettings() async {
    final useScientific = await _settingsRepository.getUseScientificNotation();
    if (useScientific != null) emit(state.copyWith(isScientificNotation: useScientific));
  }

  Future<void> _onToggleScientificNotation(_ToggleScientificNotation event, Emitter<SettingsState> emit) async {
    final newValue = !state.isScientificNotation;
    emit(state.copyWith(isScientificNotation: newValue));
    await _settingsRepository.saveUseScientificNotation(newValue);
  }
}
