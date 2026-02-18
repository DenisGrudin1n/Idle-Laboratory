import 'package:bloc/bloc.dart';
import 'package:idle_laboratory/features/home/presentation/cubits/settings/settings_state.dart';

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
  SettingsCubit() : super(SettingsState.initial());

  /// Toggles between scientific notation (1.23e15) and suffix notation (1.23Qa).
  void toggleScientificNotation() {
    emit(state.copyWith(isScientificNotation: !state.isScientificNotation));
  }
}
