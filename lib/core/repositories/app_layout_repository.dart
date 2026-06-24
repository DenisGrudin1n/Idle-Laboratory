import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:idle_laboratory/core/constants/game_constants.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/interfaces/i_app_layout_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IAppLayoutRepository)
class AppLayoutRepository with WidgetsBindingObserver implements IAppLayoutRepository {
  AppLayoutRepository()
    : _widgetsBinding = widgetsBinding ?? WidgetsBinding.instance,
      _appVersionController = StreamController<AppVersionEnum>.broadcast() {
    if (widgetsBinding == null) {
      _widgetsBinding.addObserver(this);
    }
  }

  @visibleForTesting
  static WidgetsBinding? widgetsBinding;

  final WidgetsBinding _widgetsBinding;
  final StreamController<AppVersionEnum> _appVersionController;

  @override
  Stream<AppVersionEnum> get appVersionStream => _appVersionController.stream;

  @override
  void didChangeMetrics() {
    final size = getScreenSize;

    if (size != null) {
      final appVersionEnum = size.appVersionEnum;
      _appVersionController.add(appVersionEnum);
    }
    super.didChangeMetrics();
  }

  @override
  AppVersionEnum get getCurrentAppVersion => getScreenSize?.appVersionEnum ?? AppVersionEnum.mobile;

  @override
  Size? get getScreenSize {
    try {
      final views = _widgetsBinding.platformDispatcher.views;
      final view = views.elementAtOrNull(0);

      if (view != null) {
        return view.physicalSize / view.devicePixelRatio;
      }

      return null;
    } catch (e, stack) {
      _appVersionController.addError(e, stack);
      return null;
    }
  }

  @override
  void dispose() {
    _widgetsBinding.removeObserver(this);
    _appVersionController.close();
  }
}

extension _SizeExtension on Size {
  AppVersionEnum get appVersionEnum {
    if (width > GameConstants.minWidthThresholdDesk) {
      return AppVersionEnum.desk;
    }

    if (shortestSide >= GameConstants.minWidthThresholdTablet) {
      return AppVersionEnum.tablet;
    }

    return AppVersionEnum.mobile;
  }
}
