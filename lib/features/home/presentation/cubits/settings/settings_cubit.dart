import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/features/home/data/repositories/settings_repository.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';

/// Manages UI settings and preferences for the application.
///
/// Currently handles:
/// - Number format display (scientific notation vs suffix notation)
///
/// Future settings may include:
/// - Sound/music preferences
/// - Visual effects toggles
/// - Auto-save preferences
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsRepository) : super(SettingsState.initial()) {
    _loadSettings();
  }

  final SettingsRepository _settingsRepository;

  /// Loads settings from repository on initialization.
  Future<void> _loadSettings() async {
    final bool? useScientific = await _settingsRepository
        .getUseScientificNotation();

    if (useScientific != null) {
      emit(state.copyWith(isScientificNotation: useScientific));
    }
  }

  /// Toggles between scientific notation (1.23e15) and suffix notation (1.23Qa).
  Future<void> toggleScientificNotation() async {
    final bool newValue = !state.isScientificNotation;
    emit(state.copyWith(isScientificNotation: newValue));
    await _settingsRepository.saveUseScientificNotation(newValue);
  }
}
