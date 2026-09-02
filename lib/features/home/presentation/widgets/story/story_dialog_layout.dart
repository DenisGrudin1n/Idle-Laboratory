import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';

/// Responsive spacing for story modals — mobile / tablet / desk tiers.
class StoryDialogMetrics {
  const StoryDialogMetrics({
    required this.borderRadius,
    required this.cardPadding,
    required this.titleBodyGap,
    required this.buttonTopGap,
    required this.contentDotsGap,
  });

  final double borderRadius;
  final double cardPadding;
  final double titleBodyGap;
  final double buttonTopGap;
  final double contentDotsGap;

  factory StoryDialogMetrics.forVersion(AppVersionEnum appVersion) {
    return switch (appVersion) {
      AppVersionEnum.mobile => const StoryDialogMetrics(
        borderRadius: 12,
        cardPadding: 12,
        titleBodyGap: 10,
        buttonTopGap: 20,
        contentDotsGap: 8,
      ),
      AppVersionEnum.tablet => const StoryDialogMetrics(
        borderRadius: 16,
        cardPadding: 16,
        titleBodyGap: 12,
        buttonTopGap: 24,
        contentDotsGap: 10,
      ),
      AppVersionEnum.desk => const StoryDialogMetrics(
        borderRadius: 24,
        cardPadding: 20,
        titleBodyGap: 14,
        buttonTopGap: 28,
        contentDotsGap: 12,
      ),
    };
  }
}

/// Story modal sizing — always wider than tall, ~half the viewport on small screens.
abstract final class StoryDialogLayout {
  static const _maxWidthToHeightRatio = 2.3;
  static const _sizeBoost = 1.05;

  static BoxConstraints constraints({
    required Size size,
    required AppVersionEnum appVersion,
    bool compact = false,
  }) {
    final (widthScale, heightScale) = switch ((appVersion, compact)) {
      (AppVersionEnum.mobile, _) => (0.72, 0.58),
      (AppVersionEnum.tablet, true) => (0.58, 0.46),
      (AppVersionEnum.tablet, false) => (0.76, 0.58),
      (AppVersionEnum.desk, true) => (0.52, 0.46),
      (AppVersionEnum.desk, false) => (0.68, 0.58),
    };
    final widthCap = switch ((appVersion, compact)) {
      (AppVersionEnum.desk, true) => 720.0,
      (AppVersionEnum.desk, false) => 960.0,
      (AppVersionEnum.tablet, true) => 560.0,
      (AppVersionEnum.tablet, false) => 720.0,
      _ => double.infinity,
    };
    var maxWidth = math.min(size.width * widthScale, widthCap);
    final maxHeight = math.min(maxWidth * 0.82, size.height * heightScale);
    if (appVersion == AppVersionEnum.mobile &&
        size.width > size.height &&
        maxWidth > maxHeight * _maxWidthToHeightRatio) {
      maxWidth = maxHeight * _maxWidthToHeightRatio;
    }
    return BoxConstraints(
      maxWidth: maxWidth * _sizeBoost,
      maxHeight: maxHeight * _sizeBoost,
    );
  }
}
