part of 'app_layout_bloc.dart';

@freezed
sealed class AppLayoutState with _$AppLayoutState {
  const factory AppLayoutState.initial({required AppVersionEnum appVersion}) = _Initial;
}
