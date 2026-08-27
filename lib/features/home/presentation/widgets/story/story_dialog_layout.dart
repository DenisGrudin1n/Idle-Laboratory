import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';

/// Shared sizing for story modals (prologue reveal / ending reveal).
///
/// Wide enough for readable lore, but capped on very large desk screens.
abstract final class StoryDialogLayout {
  static BoxConstraints constraints({required Size size, required AppVersionEnum appVersion}) {
    final isLandscape = size.width > size.height;
    final maxHeight = size.height * (isLandscape ? 0.92 : 0.86);
    final maxWidth = switch ((isLandscape, appVersion)) {
      (true, AppVersionEnum.mobile) => size.width * 0.96,
      (true, AppVersionEnum.tablet) => math.min(size.width * 0.8, 920).toDouble(),
      (true, AppVersionEnum.desk) => math.min(size.width * 0.68, 1040).toDouble(),
      (false, AppVersionEnum.mobile) => size.width * 0.94,
      (false, AppVersionEnum.tablet) => size.width * 0.84,
      (false, AppVersionEnum.desk) => math.min(size.width * 0.62, 880).toDouble(),
    };

    return BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight, minHeight: maxHeight * (isLandscape ? 0.7 : 0.52));
  }
}
