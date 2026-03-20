import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Extension for drawing cell container components
extension CellContainerPainter on Canvas {
  /// Draws the full 3-D cylindrical container.
  ///
  /// Layer order (back → front):
  ///  1. Outer ambient shadow / glow halo
  ///  2. Cylindrical body (side-lit gradient)
  ///
  /// All gradient parameters are sourced from the app theme to avoid
  /// hardcoded colours. Pass them from [_CellContainerPainter] which has
  /// access to [BuildContext].
  void drawCellContainer({
    required double centerX,
    required double topY,
    required double bottomY,
    required double width,
    required LinearGradient bodyGradient,
  }) {
    final left = centerX - width / 2;
    final radius = width * 0.08; // corner radius of the body rect

    // ── 1. Outer ambient shadow / glow halo ───────────────────────────────
    final haloPaint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14)
      ..color = Colors.black.withValues(alpha: 0.55);
    drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left - 4, topY - 4, width + 8, bottomY - topY + 8),
        Radius.circular(radius + 4),
      ),
      haloPaint,
    );

    // ── 2. Cylindrical body – side-lit gradient ───────────────────────────
    final bodyPaint = Paint()
      ..shader = bodyGradient.createShader(
        Rect.fromLTWH(left, topY, width, bottomY - topY),
      );

    drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, topY, width, bottomY - topY),
        Radius.circular(radius),
      ),
      bodyPaint,
    );
  }

  /// Draws glass overlay effect on the container
  void drawGlassOverlay({
    required double centerX,
    required double topY,
    required double bottomY,
    required double width,
  }) {
    final left = centerX - width / 2;
    final height = bottomY - topY;
    final radius = width * 0.08;

    // ── Left-edge bright reflection strip ─────────────────────────────────
    final reflectionPaint = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          Colors.white.withValues(alpha: 0.18),
          Colors.white.withValues(alpha: 0.06),
          Colors.transparent,
        ],
        stops: const <double>[0, 0.4, 1],
      ).createShader(Rect.fromLTWH(left, topY, width * 0.28, height));

    final reflectionPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left + 2, topY + 2, width * 0.22, height - 4),
          Radius.circular(radius),
        ),
      );
    drawPath(reflectionPath, reflectionPaint);

    // ── Thin right-edge bounce-light strip ────────────────────────────────
    final bouncePaint = Paint()
      ..shader =
          LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: <Color>[
              Colors.white.withValues(alpha: 0.07),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromLTWH(left + width * 0.82, topY, width * 0.18, height),
          );
    final bouncePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            left + width * 0.82,
            topY + 2,
            width * 0.16,
            height - 4,
          ),
          Radius.circular(radius),
        ),
      );
    drawPath(bouncePath, bouncePaint);

    // ── Dark outline to separate the container from the background ─────────
    final outlinePaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, topY, width, height),
        Radius.circular(radius),
      ),
      outlinePaint,
    );

    // ── Inner bright edge line (top inner rim) ─────────────────────────────
    final innerEdgePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left + 1.5, topY + 1.5, width - 3, height - 3),
        Radius.circular(math.max(0, radius - 1)),
      ),
      innerEdgePaint,
    );
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
        Radius.circular(width * 0.08),
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
    final energyPaint = Paint()
      ..shader =
          LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ).createShader(
            Rect.fromLTWH(centerX - width / 2, fillTop, width, fillHeight),
          )
      ..style = PaintingStyle.fill;

    final energyRect = Rect.fromLTWH(
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
    final glowPaint = Paint()
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
    final random = math.Random((animationValue * 1000000).toInt());

    for (var i = 0; i < boltCount; i++) {
      final lightningPaint = Paint()
        ..color = lightningColor.withValues(
          alpha: 0.5 + random.nextDouble() * 0.4,
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8 + random.nextDouble() * 2.5
        ..strokeCap = StrokeCap.round;

      final startY =
          fillTop + (bottomY - fillTop) * (random.nextDouble() * 0.8);
      final startX = centerX - width / 2 + (width * random.nextDouble());

      final lightning = Path()..moveTo(startX, startY);

      var currentY = startY;
      var currentX = startX;
      final segments = 5 + random.nextInt(8);

      for (var j = 0; j < segments; j++) {
        final horizontalMove = (random.nextDouble() - 0.5) * width * 0.6;
        final verticalMove = (random.nextDouble() - 0.3) * 15;

        currentX += horizontalMove;
        currentY += verticalMove;

        currentX = currentX.clamp(
          centerX - width / 2 + 3,
          centerX + width / 2 - 3,
        );
        currentY = currentY.clamp(fillTop + 5, bottomY - 5);

        if (j.isEven && j < (segments - 1)) {
          final ctrlX = currentX + (random.nextDouble() - 0.5) * width * 0.3;
          final ctrlY = currentY + (random.nextDouble() - 0.5) * 20;
          final endX = currentX + (random.nextDouble() - 0.5) * width * 0.4;
          final endY = currentY + (random.nextDouble() - 0.5) * 15;

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
    final random = math.Random((animationValue * 1000000).toInt());
    final particlePaint = Paint()..style = PaintingStyle.fill;

    for (var i = 0; i < particleCount; i++) {
      final particleX = centerX - width / 2 + (width * random.nextDouble());
      final particleOffset = (animationValue + i * 0.08) % 1.0;
      final particleY = fillTop + (bottomY - fillTop) * particleOffset;
      final particleSize = 0.8 + random.nextDouble() * 2;

      particlePaint.color = Color.lerp(
        particleColor1,
        particleColor2,
        random.nextDouble(),
      )!.withValues(alpha: 0.6 + random.nextDouble() * 0.3);

      drawCircle(Offset(particleX, particleY), particleSize, particlePaint);
    }
  }

  /// Draws floating lava chunks (dirt/rock pieces) for heat cell
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
    final random = math.Random((animationValue * 1000000).toInt());
    final chunkPaint = Paint()..style = PaintingStyle.fill;
    final emberPaint = Paint()..style = PaintingStyle.fill;

    for (var i = 0; i < chunkCount; i++) {
      final baseX = centerX - width / 2 + (width * random.nextDouble());
      final offset = (animationValue * 0.5 + i * 0.1) % 1.0;
      final baseY = fillTop + (bottomY - fillTop) * offset;

      // Wobble horizontally for organic movement
      final wobble =
          math.sin((animationValue + i) * math.pi * 2) * (width * 0.08);
      final chunkX = baseX + wobble;
      final chunkY = baseY;

      final chunkSize = 3.0 + random.nextDouble() * 4.5;

      // Draw dark chunk body (irregular shape)
      chunkPaint.color = chunkColor.withValues(
        alpha: 0.85 + random.nextDouble() * 0.15,
      );

      // Irregular chunk shape (rounded rect rotated)
      save();
      translate(chunkX, chunkY);
      rotate(random.nextDouble() * math.pi * 2);
      drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: chunkSize,
            height: chunkSize * 0.8,
          ),
          Radius.circular(chunkSize * 0.3),
        ),
        chunkPaint,
      );
      restore();

      // Draw glowing ember edges (small bright spots on chunk)
      final emberCount = random.nextInt(2) + 1;
      for (var j = 0; j < emberCount; j++) {
        final emberOffsetX = (random.nextDouble() - 0.5) * chunkSize;
        final emberOffsetY = (random.nextDouble() - 0.5) * chunkSize;
        final emberSize = 0.6 + random.nextDouble() * 1.2;

        emberPaint.color = Color.lerp(
          emberColor1,
          emberColor2,
          random.nextDouble(),
        )!.withValues(alpha: 0.7 + random.nextDouble() * 0.3);

        drawCircle(
          Offset(chunkX + emberOffsetX, chunkY + emberOffsetY),
          emberSize,
          emberPaint,
        );
      }
    }
  }
}
