import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/utils/painter_utils.dart';

/// Extension on Canvas for elemental effects like lightning, heat, ice, and steam
extension CellElementalEffectsExt on Canvas {
  /// Draws multiple crackling lightning bolts with random segments
  void drawElectricLightning({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color lightningColor,
    int boltCount = 8,
  }) {
    final random = PainterUtils.seededRandom(animationValue);
    final height = bottomY - fillTop;

    for (var i = 0; i < boltCount; i++) {
      final paint = Paint()
        ..color = lightningColor.withValues(alpha: 0.5 + random.nextDouble() * 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8 + random.nextDouble() * 2.5
        ..strokeCap = StrokeCap.round;

      final startY = fillTop + height * (random.nextDouble() * 0.8);
      final startX = (centerX - width / 2) + (width * random.nextDouble());
      final lightning = Path()..moveTo(startX, startY);

      var currentY = startY;
      var currentX = startX;
      final segments = 5 + random.nextInt(8);

      for (var j = 0; j < segments; j++) {
        currentX += (random.nextDouble() - 0.5) * width * 0.6;
        currentY += (random.nextDouble() - 0.3) * 15;

        // Safe clamp bounds
        final margin = math.min(3, width / 4);
        currentX = currentX.clamp(centerX - width / 2 + margin, centerX + width / 2 - margin);
        currentY = currentY.clamp(fillTop + margin, bottomY - margin);

        if (j.isEven && j < (segments - 1)) {
          final endX = currentX + (random.nextDouble() - 0.5) * width * 0.4;
          final endY = currentY + (random.nextDouble() - 0.5) * 15;
          lightning.quadraticBezierTo(
            currentX + (random.nextDouble() - 0.5) * width * 0.3,
            currentY + (random.nextDouble() - 0.5) * 20,
            endX,
            endY,
          );
          currentX = endX;
          currentY = endY;
        } else {
          lightning.lineTo(currentX, currentY);
        }
      }
      drawPath(lightning, paint);
    }
  }

  /// Draws floating lava chunks and embers that rise through the container
  void drawLavaChunks({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color chunkColor,
    required Color emberColor1,
    required Color emberColor2,
    int chunkCount = 12,
  }) {
    final random = PainterUtils.seededRandom(animationValue);
    final chunkPaint = Paint()..style = PaintingStyle.fill;
    final emberPaint = Paint()..style = PaintingStyle.fill;
    final height = bottomY - fillTop;

    for (var i = 0; i < chunkCount; i++) {
      final baseX = centerX - width / 2 + (width * random.nextDouble());
      final baseY = fillTop + height * ((animationValue * 2.0 + i * 0.1) % 1.0);

      // Horizontal sinusoidal wobble
      final chunkX = baseX + math.sin((animationValue * 2.0 + i) * math.pi * 2) * (width * 0.08);
      final chunkSize = 3.0 + random.nextDouble() * 4.5;

      chunkPaint.color = chunkColor.withValues(alpha: 0.85 + random.nextDouble() * 0.15);
      save();
      translate(chunkX, baseY);
      rotate(random.nextDouble() * math.pi * 2);
      drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: chunkSize, height: chunkSize * 0.8),
          Radius.circular(chunkSize * 0.3),
        ),
        chunkPaint,
      );
      restore();

      // Embers around chunk
      for (var j = 0; j < random.nextInt(2) + 1; j++) {
        emberPaint.color = Color.lerp(
          emberColor1,
          emberColor2,
          random.nextDouble(),
        )!.withValues(alpha: 0.7 + random.nextDouble() * 0.3);

        drawCircle(
          Offset(chunkX + (random.nextDouble() - 0.5) * chunkSize, baseY + (random.nextDouble() - 0.5) * chunkSize),
          0.6 + random.nextDouble() * 1.2,
          emberPaint,
        );
      }
    }
  }

  /// Draws crystalline structures (snowflakes) that drift slowly within the ice
  void drawIceCrystals({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    int rows = 4,
    int cols = 3,
  }) {
    final random = math.Random(42);
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    PainterUtils.forGrid(
      centerX: centerX,
      topY: fillTop,
      width: width,
      height: bottomY - fillTop,
      rows: rows,
      cols: cols,
      action: (idx, x, y, cw, ch) {
        final drift = PainterUtils.getDriftOffset(animationValue: animationValue, index: idx, random: random);
        final px = x + (random.nextDouble() - 0.5) * cw + drift.dx;
        final py = y + (random.nextDouble() - 0.5) * ch + drift.dy;
        final size = 5.0 + random.nextDouble() * 7.0;

        for (var j = 0; j < 6; j++) {
          final angle = (j * 60) * math.pi / 180;
          drawLine(Offset(px, py), Offset(px + math.cos(angle) * size, py + math.sin(angle) * size), paint);
        }
      },
    );
  }

  /// Draws rising steam clouds with smooth opacity transitions and drift
  void drawRisingVapor({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color vaporColor,
    int cloudCount = 8,
  }) {
    final random = math.Random(123);
    final height = bottomY - fillTop + 100;

    for (var i = 0; i < cloudCount; i++) {
      final progress = (animationValue + i / cloudCount) % 1.0;
      final y = (bottomY + 50) - (height * progress);
      final opacity = math.sin(progress * math.pi) * 0.45;

      final driftX = math.sin(progress * math.pi * 2 + i) * 15.0;
      final x = centerX + (random.nextDouble() - 0.5) * width + driftX;

      final radius = 25.0 + random.nextDouble() * 35.0;
      final stretch = 1.4 + random.nextDouble() * 0.8;
      final rect = Rect.fromCenter(center: Offset.zero, width: radius * stretch, height: radius);

      save();
      translate(x, y);
      drawOval(
        rect,
        Paint()
          ..shader = RadialGradient(
            colors: [
              vaporColor.withValues(alpha: opacity),
              vaporColor.withValues(alpha: opacity * 0.6),
              vaporColor.withValues(alpha: opacity * 0.2),
              Colors.transparent,
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ).createShader(rect)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10 + random.nextDouble() * 8),
      );
      restore();
    }
  }
}
