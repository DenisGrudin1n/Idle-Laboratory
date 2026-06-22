part of 'app_layout_bloc.dart';

@freezed
sealed class AppLayoutEvent with _$AppLayoutEvent {
  const factory AppLayoutEvent.appVersionChanged(AppVersionEnum appVersion) = _AppVersionChanged;
}
