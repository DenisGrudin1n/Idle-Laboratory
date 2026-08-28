import 'package:flutter/material.dart';

abstract final class OverlayConstants {
  /// Matches [TutorialCoachMark.opacityShadow] — dims the scene while keeping it visible.
  static const dimOpacity = 0.9;

  static Color dimBarrier([double opacity = dimOpacity]) => Colors.black.withValues(alpha: opacity);
}
