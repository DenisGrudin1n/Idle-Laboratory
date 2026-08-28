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

  /// Tighter card for single-beat mid-game lore — narrower width so text wraps with more vertical room.
  static BoxConstraints loreBeatConstraints({required Size size, required AppVersionEnum appVersion}) {
    final isLandscape = size.width > size.height;
    final maxWidth = switch ((isLandscape, appVersion)) {
      (true, AppVersionEnum.mobile) => size.width * 0.66,
      (true, AppVersionEnum.tablet) => math.min(size.width * 0.52, 480).toDouble(),
      (true, AppVersionEnum.desk) => math.min(size.width * 0.42, 520).toDouble(),
      (false, AppVersionEnum.mobile) => size.width * 0.66,
      (false, AppVersionEnum.tablet) => math.min(size.width * 0.52, 400).toDouble(),
      (false, AppVersionEnum.desk) => math.min(size.width * 0.36, 380).toDouble(),
    };

    return BoxConstraints(maxWidth: maxWidth);
  }
}
