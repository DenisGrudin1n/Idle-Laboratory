import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Common math and drawing utility functions for cell painters
class PainterUtils {
  /// Returns a value oscillating between 0.0 and 1.0 based on [value] and [frequency]
  static double pulse(double value, {double frequency = 1.0, double phase = 0.0}) {
    return (math.sin(value * math.pi * 2 * frequency + phase) + 1) / 2;
  }

  /// Calculates a drift offset based on [animationValue] and [index] for smooth, looping movement
  static Offset getDriftOffset({
    required double animationValue,
    required int index,
    required math.Random random,
    double maxDrift = 15.0,
  }) {
    final dx = (random.nextDouble() - 0.5) * maxDrift;
    final dy = (random.nextDouble() - 0.5) * maxDrift;

    return Offset(
      math.sin(animationValue * math.pi * 2 + index) * dx,
      math.cos(animationValue * math.pi * 2 + index * 0.7) * dy,
    );
  }

  /// Helper to iterate through a grid and perform an action for each cell
  static void forGrid({
    required double centerX,
    required double topY,
    required double width,
    required double height,
    required int rows,
    required int cols,
    required void Function(int index, double x, double y, double cellWidth, double cellHeight) action,
  }) {
    final rowHeight = height / rows;
    final colWidth = width / cols;
    final left = centerX - width / 2;

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final idx = r * cols + c;
        final x = left + (c * colWidth) + (colWidth / 2);
        final y = topY + (r * rowHeight) + (rowHeight / 2);
        action(idx, x, y, colWidth, rowHeight);
      }
    }
  }

  /// Returns a random double seeded by [animationValue] for deterministic animations
  static math.Random seededRandom(double animationValue, {int offset = 0}) {
    return math.Random((animationValue * 1000000).toInt() + offset);
  }

  /// Extracts a safe 3-color list for energy fill gradients
  static List<Color> getSafeFillColors(Gradient gradient) => [
        gradient.colors[0].withValues(alpha: 0.7),
        gradient.colors.length > 2 ? gradient.colors[1].withValues(alpha: 0.85) : gradient.colors.last.withValues(alpha: 0.85),
        gradient.colors.last,
      ];

  /// Extracts a safe 3-color list for energy glow gradients (ending with transparent)
  static List<Color> getSafeGlowColors(Gradient gradient) => [
        gradient.colors[0].withValues(alpha: 0.8),
        gradient.colors.length > 1 ? gradient.colors[1].withValues(alpha: 0.5) : gradient.colors.last.withValues(alpha: 0.5),
        Colors.transparent,
      ];
}
