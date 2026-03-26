import 'dart:math' as math;
import 'package:flutter/material.dart';

extension CellContainerPainter on Canvas {
  void drawCellContainer({
    required double centerX,
    required double topY,
    required double bottomY,
    required double width,
    required LinearGradient bodyGradient,
  }) {
    final left = centerX - width / 2;
    final radius = width * 0.08;

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

    final bodyPaint = Paint()..shader = bodyGradient.createShader(Rect.fromLTWH(left, topY, width, bottomY - topY));
    drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(left, topY, width, bottomY - topY), Radius.circular(radius)),
      bodyPaint,
    );
  }

  void drawCellCap({
    required double centerX,
    required double topY,
    required double width,
    required LinearGradient capGradient,
  }) {
    final capWidth = width * 0.5;
    final capHeight = width * 0.2;
    final left = centerX - capWidth / 2;
    final top = topY - capHeight;

    final capPaint = Paint()..shader = capGradient.createShader(Rect.fromLTWH(left, top, capWidth, capHeight));

    final borderPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final capRRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(left, top, capWidth, capHeight),
      topLeft: Radius.circular(capHeight * 0.45),
      topRight: Radius.circular(capHeight * 0.45),
    );

    drawRRect(capRRect, capPaint);
    drawRRect(capRRect, borderPaint);
  }

  void drawFillDividers({
    required double centerX,
    required double topY,
    required double bottomY,
    required double width,
    required Color dividerColor,
  }) {
    final left = centerX - width / 2;
    final height = bottomY - topY;
    final dividerPaint = Paint()
      ..color = dividerColor.withValues(alpha: 0.3)
      ..strokeWidth = 1.2;

    for (var i = 1; i <= 4; i++) {
      final y = bottomY - (height * (i * 0.2));
      drawLine(Offset(left + 2, y), Offset(left + width - 2, y), dividerPaint);
    }
  }

  void drawGlassOverlay({
    required double centerX,
    required double topY,
    required double bottomY,
    required double width,
  }) {
    final left = centerX - width / 2;
    final height = bottomY - topY;
    final radius = width * 0.08;

    final reflectionPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white.withValues(alpha: 0.18), Colors.white.withValues(alpha: 0.06), Colors.transparent],
        stops: const [0, 0.4, 1],
      ).createShader(Rect.fromLTWH(left, topY, width * 0.28, height));

    drawPath(
      Path()..addRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(left + 2, topY + 2, width * 0.22, height - 4), Radius.circular(radius)),
      ),
      reflectionPaint,
    );

    final bouncePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [Colors.white.withValues(alpha: 0.07), Colors.transparent],
      ).createShader(Rect.fromLTWH(left + width * 0.82, topY, width * 0.18, height));

    drawPath(
      Path()..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left + width * 0.82, topY + 2, width * 0.16, height - 4),
          Radius.circular(radius),
        ),
      ),
      bouncePaint,
    );

    drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(left, topY, width, height), Radius.circular(radius)),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left + 1.5, topY + 1.5, width - 3, height - 3),
        Radius.circular(math.max(0, radius - 1)),
      ),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

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

extension EnergyEffectsPainter on Canvas {
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
        ..color = lightningColor.withValues(alpha: 0.5 + random.nextDouble() * 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8 + random.nextDouble() * 2.5
        ..strokeCap = StrokeCap.round;

      final startY = fillTop + (bottomY - fillTop) * (random.nextDouble() * 0.8);
      final startX = centerX - width / 2 + (width * random.nextDouble());
      final lightning = Path()..moveTo(startX, startY);

      var currentY = startY;
      var currentX = startX;
      final segments = 5 + random.nextInt(8);

      for (var j = 0; j < segments; j++) {
        currentX += (random.nextDouble() - 0.5) * width * 0.6;
        currentY += (random.nextDouble() - 0.3) * 15;
        currentX = currentX.clamp(centerX - width / 2 + 3, centerX + width / 2 - 3);
        currentY = currentY.clamp(fillTop + 5, bottomY - 5);

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
      drawPath(lightning, lightningPaint);
    }
  }

  Offset getDriftOffset({
    required double animationValue,
    required int index,
    required math.Random random,
    double maxDrift = 15.0,
  }) {
    final driftX = (random.nextDouble() - 0.5) * maxDrift;
    final driftY = (random.nextDouble() - 0.5) * maxDrift;

    return Offset(
      math.sin(animationValue * math.pi * 2 + index) * driftX,
      math.cos(animationValue * math.pi * 2 + index * 0.7) * driftY,
    );
  }

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

    final rowHeight = (bottomY - fillTop) / rows;
    final colWidth = width / cols;

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final cellIdx = r * cols + c;
        final drift = getDriftOffset(animationValue: animationValue, index: cellIdx, random: random);

        final x = (centerX - width / 2) + (c * colWidth) + (random.nextDouble() * colWidth) + drift.dx;
        final y = fillTop + (r * rowHeight) + (random.nextDouble() * rowHeight) + drift.dy;

        final size = 5.0 + random.nextDouble() * 7.0;

        for (var j = 0; j < 6; j++) {
          final angle = (j * 60) * math.pi / 180;
          final endX = x + math.cos(angle) * size;
          final endY = y + math.sin(angle) * size;
          drawLine(Offset(x, y), Offset(endX, endY), paint);
        }
      }
    }
  }

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
    final totalHeight = bottomY - fillTop + 100; // Extra space for spawning out of bounds

    for (var i = 0; i < cloudCount; i++) {
      // 1x Speed: Takes 6 seconds to complete the full cycle
      final offset = i / cloudCount;
      final progress = (animationValue + offset) % 1.0;

      final y = (bottomY + 50) - (totalHeight * progress);
      final opacity = math.sin(progress * math.pi) * 0.45;

      final startXOffset = (random.nextDouble() - 0.5) * width;
      final driftX = math.sin(progress * math.pi * 2 + i) * 15.0;
      final x = centerX + startXOffset + driftX;

      final radius = 25.0 + random.nextDouble() * 35.0;
      final stretch = 1.4 + random.nextDouble() * 1.0;
      final rect = Rect.fromCenter(center: Offset.zero, width: radius * stretch, height: radius);

      final cloudPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            vaporColor.withValues(alpha: opacity),
            vaporColor.withValues(alpha: opacity * 0.6),
            vaporColor.withValues(alpha: opacity * 0.2),
            Colors.transparent,
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ).createShader(rect)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10 + random.nextDouble() * 8);

      save();
      translate(x, y);
      drawOval(rect, cloudPaint);
      restore();
    }
  }

  void drawLightBeams({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color beamColor,
    int beamCount = 12,
  }) {
    final random = math.Random(777);
    final centerY = fillTop + (bottomY - fillTop) / 2;
    final maxLen = math.max(width, bottomY - fillTop) * 1.5;

    // 1. Central High-Intensity Singularity (Quantum Core)
    final pulse = (math.sin(animationValue * math.pi * 4) + 1) / 2;
    final coreGlow = Paint()
      ..shader = RadialGradient(
        colors: [Colors.white, beamColor.withValues(alpha: 0.8), beamColor.withValues(alpha: 0.2), Colors.transparent],
        stops: const [0.0, 0.2, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: 40))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10 + pulse * 10);

    drawCircle(Offset(centerX, centerY), 30 + pulse * 15, coreGlow);

    // 2. Radiating "God Rays" (Light Beams)
    for (var i = 0; i < beamCount; i++) {
      final rotation = (animationValue * math.pi * 0.5) + (i * math.pi * 2 / beamCount);
      final rayWidth = 2.0 + random.nextDouble() * 8.0;
      final rayOpacity = 0.1 + (random.nextDouble() * 0.2);

      // Prismatic edge color (Subtle Violet/Blue shift)
      final prismaticColor = i.isEven ? const Color(0xFFB39DDB) : const Color(0xFF81D4FA);

      final rayPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.transparent,
            prismaticColor.withValues(alpha: rayOpacity * 0.5),
            Colors.white.withValues(alpha: rayOpacity),
            prismaticColor.withValues(alpha: rayOpacity * 0.5),
            Colors.transparent,
          ],
          stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
        ).createShader(Rect.fromLTWH(-rayWidth / 2, 0, rayWidth, maxLen))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

      save();
      translate(centerX, centerY);
      rotate(rotation);

      // Draw the long beam radiating from center
      drawRect(Rect.fromLTWH(-rayWidth / 2, 0, rayWidth, maxLen), rayPaint);
      rotate(math.pi); // Mirror the ray
      drawRect(Rect.fromLTWH(-rayWidth / 2, 0, rayWidth, maxLen), rayPaint);

      restore();
    }

    // 3. High-Frequency "Quantum Sparkles" (Photons)
    final sparkleRandom = math.Random((animationValue * 100).toInt()); // Flickers very fast
    for (var i = 0; i < 15; i++) {
      final sx = centerX - width / 2 + (sparkleRandom.nextDouble() * width);
      final sy = fillTop + (sparkleRandom.nextDouble() * (bottomY - fillTop));
      final size = 0.5 + sparkleRandom.nextDouble() * 1.5;

      drawCircle(
        Offset(sx, sy),
        size,
        Paint()
          ..color = Colors.white
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
      );

      // Horizontal flare line for some sparkles
      if (sparkleRandom.nextDouble() > 0.7) {
        drawLine(
          Offset(sx - 5, sy),
          Offset(sx + 5, sy),
          Paint()
            ..color = Colors.white.withValues(alpha: 0.4)
            ..strokeWidth = 0.5
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
        );
      }
    }
  }

  void drawMolecularBonds({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color atomColor,
    required Color bondColor,
    int rows = 4,
    int cols = 2,
  }) {
    final random = math.Random(101);
    final atoms = <Offset>[];
    final rowHeight = (bottomY - fillTop) / rows;
    final colWidth = width / cols;

    // Grid-based atom placement for even distribution
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final idx = r * cols + c;
        final drift = getDriftOffset(animationValue: animationValue, index: idx, random: random, maxDrift: 20);

        final baseX = (centerX - width / 2) + (c * colWidth) + (colWidth / 2);
        final baseY = fillTop + (r * rowHeight) + (rowHeight / 2);

        // Add a bit of local randomness within the grid cell
        final jitterX = (random.nextDouble() - 0.5) * (colWidth * 0.6);
        final jitterY = (random.nextDouble() - 0.5) * (rowHeight * 0.6);

        atoms.add(Offset(baseX + jitterX + drift.dx, baseY + jitterY + drift.dy));
      }
    }

    final bondPaint = Paint()
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final atomPaint = Paint()..style = PaintingStyle.fill;

    // Draw bonds with distance-based opacity
    for (var i = 0; i < atoms.length; i++) {
      for (var j = i + 1; j < atoms.length; j++) {
        final distance = (atoms[i] - atoms[j]).distance;
        final maxBondDistance = width * 0.55;
        if (distance < maxBondDistance) {
          final opacity = (1.0 - distance / maxBondDistance) * 0.35;
          bondPaint.color = bondColor.withValues(alpha: opacity);
          drawLine(atoms[i], atoms[j], bondPaint);
        }
      }
    }

    // Draw atoms
    for (var i = 0; i < atoms.length; i++) {
      final size = 3.0 + random.nextDouble() * 3.0;
      atomPaint.color = atomColor.withValues(alpha: 0.8);
      drawCircle(atoms[i], size, atomPaint);

      // Secondary glow
      drawCircle(
        atoms[i],
        size * 2.5,
        Paint()
          ..color = atomColor.withValues(alpha: 0.15)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );
    }
  }

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
    final paint = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < particleCount; i++) {
      final x = centerX - width / 2 + (width * random.nextDouble());
      // 3x Speed: Particles take 2 seconds to complete the cycle (on a 6s controller)
      final y = fillTop + (bottomY - fillTop) * ((animationValue * 3.0 + i * 0.08) % 1.0);
      paint.color = Color.lerp(
        particleColor1,
        particleColor2,
        random.nextDouble(),
      )!.withValues(alpha: 0.6 + random.nextDouble() * 0.3);
      drawCircle(Offset(x, y), 0.8 + random.nextDouble() * 2, paint);
    }
  }

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
      // 2x Speed: Lava chunks take 3 seconds to complete the cycle (on a 6s controller)
      final baseY = fillTop + (bottomY - fillTop) * ((animationValue * 2.0 + i * 0.1) % 1.0);
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

      final emberCount = random.nextInt(2) + 1;
      for (var j = 0; j < emberCount; j++) {
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
}
