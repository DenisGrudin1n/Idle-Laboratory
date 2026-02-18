import 'package:bloc/bloc.dart';
import 'package:idle_laboratory/features/home/presentation/cubits/settings/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());

  void toggleScientificNotation() {
    emit(state.copyWith(isScientificNotation: !state.isScientificNotation));
  }
}
