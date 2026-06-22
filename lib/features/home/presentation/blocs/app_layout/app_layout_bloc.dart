import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/interfaces/i_app_layout_repository.dart';
import 'package:injectable/injectable.dart';

part 'app_layout_bloc.freezed.dart';
part 'app_layout_event.dart';
part 'app_layout_state.dart';

@singleton
class AppLayoutBloc extends Bloc<AppLayoutEvent, AppLayoutState> {
  AppLayoutBloc({required IAppLayoutRepository appLayoutRepository})
    : _appLayoutRepository = appLayoutRepository,
      super(AppLayoutState.initial(appVersion: appLayoutRepository.getCurrentAppVersion)) {
    on<_AppVersionChanged>(_onAppVersionChanged);

    _init();
  }

  final IAppLayoutRepository _appLayoutRepository;
  StreamSubscription<AppVersionEnum>? _subscription;

  void _init() {
    _subscription = _appLayoutRepository.appVersionStream.listen(
      (appVersion) => add(AppLayoutEvent.appVersionChanged(appVersion)),
    );
  }

  void _onAppVersionChanged(_AppVersionChanged event, Emitter<AppLayoutState> emit) {
    if (event.appVersion != state.appVersion) {
      emit(state.copyWith(appVersion: event.appVersion));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _appLayoutRepository.dispose();
    return super.close();
  }
}
