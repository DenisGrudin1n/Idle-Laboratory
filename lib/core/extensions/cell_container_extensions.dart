import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Extension for drawing cell container components
extension CellContainerPainter on Canvas {
  /// Draws the cylindrical container with rims
  void drawCellContainer({
    required double centerX,
    required double topY,
    required double bottomY,
    required double width,
    Color containerColor = const Color(0xFF4A5568),
    Color rimColor = const Color(0xFF718096),
  }) {
    final Paint containerPaint = Paint()
      ..color = containerColor
      ..style = PaintingStyle.fill;

    final Paint rimPaint = Paint()
      ..color = rimColor
      ..style = PaintingStyle.fill;

    // Bottom rim
    final Path bottomRim = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(centerX, bottomY),
          width: width * 1.1,
          height: width * 0.15,
        ),
      );
    drawPath(bottomRim, rimPaint);

    // Main container body
    final Path body = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(centerX - width / 2, topY, width, bottomY - topY),
          Radius.circular(width * 0.1),
        ),
      );
    drawPath(body, containerPaint);

    // Top rim
    final Path topRim = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(centerX, topY),
          width: width * 1.1,
          height: width * 0.15,
        ),
      );
    drawPath(topRim, rimPaint);
  }

  /// Draws glass overlay effect on the container
  void drawGlassOverlay({
    required double centerX,
    required double topY,
    required double bottomY,
    required double width,
  }) {
    // Glass reflection effect
    final Paint glassPaint = Paint()
      ..shader =
          LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Colors.white.withValues(alpha: 0.1),
              Colors.white.withValues(alpha: 0.05),
              Colors.transparent,
              Colors.white.withValues(alpha: 0.03),
            ],
            stops: const <double>[0.0, 0.3, 0.7, 1.0],
          ).createShader(
            Rect.fromLTWH(centerX - width / 2, topY, width, bottomY - topY),
          )
      ..style = PaintingStyle.fill;

    final Path glassPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            centerX - width / 2,
            topY,
            width * 0.25,
            bottomY - topY,
          ),
          Radius.circular(width * 0.1),
        ),
      );

    drawPath(glassPath, glassPaint);

    // Container outline
    final Paint outlinePaint = Paint()
      ..color = const Color(0xFF94A3B8).withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Path outline = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(centerX - width / 2, topY, width, bottomY - topY),
          Radius.circular(width * 0.1),
        ),
      );

    drawPath(outline, outlinePaint);
  }

  /// Creates a clip path for the container bounds
  Path getContainerClipPath({
    required double centerX,
    required double topY,
    required double bottomY,
    required double width,
  }) => Path()
    ..addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(centerX - width / 2, topY, width, bottomY - topY),
        Radius.circular(width * 0.1),
      ),
    );
}

/// Extension for energy fill effects
extension EnergyEffectsPainter on Canvas {
  /// Draws base energy fill with gradient
  void drawEnergyBase({
    required double centerX,
    required double fillTop,
    required double width,
    required double fillHeight,
    required List<Color> gradientColors,
  }) {
    final Paint energyPaint = Paint()
      ..shader =
          LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ).createShader(
            Rect.fromLTWH(centerX - width / 2, fillTop, width, fillHeight),
          )
      ..style = PaintingStyle.fill;

    final Rect energyRect = Rect.fromLTWH(
      centerX - width / 2 + 2,
      fillTop,
      width - 4,
      fillHeight,
    );
    drawRect(energyRect, energyPaint);
  }

  /// Draws energy glow effect at the top
  void drawEnergyGlow({
    required double centerX,
    required double fillTop,
    required double width,
    required List<Color> glowColors,
  }) {
    final Paint glowPaint = Paint()
      ..shader = RadialGradient(colors: glowColors).createShader(
        Rect.fromCenter(
          center: Offset(centerX, fillTop + 10),
          width: width,
          height: 40,
        ),
      )
      ..style = PaintingStyle.fill;

    drawOval(
      Rect.fromCenter(
        center: Offset(centerX, fillTop + 10),
        width: width - 4,
        height: 30,
      ),
      glowPaint,
    );
  }

  /// Draws electric lightning effects
  void drawElectricLightning({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color lightningColor,
    int boltCount = 8,
  }) {
    final math.Random random = math.Random((animationValue * 1000000).toInt());

    for (int i = 0; i < boltCount; i++) {
      final Paint lightningPaint = Paint()
        ..color = lightningColor.withValues(
          alpha: 0.5 + random.nextDouble() * 0.4,
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8 + random.nextDouble() * 2.5
        ..strokeCap = StrokeCap.round;

      final double startY =
          fillTop + (bottomY - fillTop) * (random.nextDouble() * 0.8);
      final double startX = centerX - width / 2 + (width * random.nextDouble());

      final Path lightning = Path()..moveTo(startX, startY);

      double currentY = startY;
      double currentX = startX;
      final int segments = 5 + random.nextInt(8);

      for (int j = 0; j < segments; j++) {
        final double horizontalMove = (random.nextDouble() - 0.5) * width * 0.6;
        final double verticalMove = (random.nextDouble() - 0.3) * 15;

        currentX += horizontalMove;
        currentY += verticalMove;

        currentX = currentX.clamp(
          centerX - width / 2 + 3,
          centerX + width / 2 - 3,
        );
        currentY = currentY.clamp(fillTop + 5, bottomY - 5);

        if (j % 2 == 0 && j < segments - 1) {
          final double ctrlX =
              currentX + (random.nextDouble() - 0.5) * width * 0.3;
          final double ctrlY = currentY + (random.nextDouble() - 0.5) * 20;
          final double endX =
              currentX + (random.nextDouble() - 0.5) * width * 0.4;
          final double endY = currentY + (random.nextDouble() - 0.5) * 15;

          lightning.quadraticBezierTo(ctrlX, ctrlY, endX, endY);
          currentX = endX;
          currentY = endY;
        } else {
          lightning.lineTo(currentX, currentY);
        }
      }

      drawPath(lightning, lightningPaint);
    }
  }

  /// Draws energy particles
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
    final math.Random random = math.Random((animationValue * 1000000).toInt());
    final Paint particlePaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < particleCount; i++) {
      final double particleX =
          centerX - width / 2 + (width * random.nextDouble());
      final double particleOffset = (animationValue + i * 0.08) % 1.0;
      final double particleY = fillTop + (bottomY - fillTop) * particleOffset;
      final double particleSize = 0.8 + random.nextDouble() * 2;

      particlePaint.color = Color.lerp(
        particleColor1,
        particleColor2,
        random.nextDouble(),
      )!.withValues(alpha: 0.6 + random.nextDouble() * 0.3);

      drawCircle(Offset(particleX, particleY), particleSize, particlePaint);
    }
  }
}
