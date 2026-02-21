import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
  SettingsCubit() : super(SettingsState.initial());

  /// Toggles between scientific notation (1.23e15) and suffix notation (1.23Qa).
  void toggleScientificNotation() {
    emit(state.copyWith(isScientificNotation: !state.isScientificNotation));
  }
}
