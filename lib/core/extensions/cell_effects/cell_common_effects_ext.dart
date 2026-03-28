import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/utils/painter_utils.dart';

/// Extension on Canvas for common energy-related effects used by multiple cells
extension CellCommonEffectsExt on Canvas {
  /// Draws the solid fill for the energy container
  void drawEnergyBase({
    required double centerX,
    required double fillTop,
    required double width,
    required double fillHeight,
    required List<Color> gradientColors,
  }) => drawRect(
    Rect.fromLTWH(centerX - width / 2 + 2, fillTop, width - 4, fillHeight),
    Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors,
      ).createShader(Rect.fromLTWH(centerX - width / 2, fillTop, width, fillHeight))
      ..style = PaintingStyle.fill,
  );

  /// Draws a soft glowing oval at the current fill level of the energy
  void drawEnergyGlow({
    required double centerX,
    required double fillTop,
    required double width,
    required List<Color> glowColors,
  }) => drawOval(
    Rect.fromCenter(center: Offset(centerX, fillTop + 10), width: width - 4, height: 30),
    Paint()
      ..shader = RadialGradient(
        colors: glowColors,
      ).createShader(Rect.fromCenter(center: Offset(centerX, fillTop + 10), width: width, height: 40))
      ..style = PaintingStyle.fill,
  );

  /// Draws floating particles that rise upward through the energy container
  void drawEnergyParticles({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color particleColor1,
    required Color particleColor2,
    int particleCount = 20,
  }) {
    final random = PainterUtils.seededRandom(animationValue);
    final paint = Paint()..style = PaintingStyle.fill;
    final height = bottomY - fillTop;

    for (var i = 0; i < particleCount; i++) {
      final x = centerX - width / 2 + (width * random.nextDouble());
      // Upward motion with wrapping
      final y = fillTop + height * ((animationValue * 3.0 + i * 0.08) % 1.0);
      
      paint.color = Color.lerp(
        particleColor1,
        particleColor2,
        random.nextDouble(),
      )!.withValues(alpha: 0.6 + random.nextDouble() * 0.3);
      
      drawCircle(Offset(x, y), 0.8 + random.nextDouble() * 2, paint);
    }
  }
}
