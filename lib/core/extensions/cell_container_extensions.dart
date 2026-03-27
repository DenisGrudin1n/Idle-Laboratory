import 'dart:math' as math;
import 'package:flutter/material.dart';

extension CellContainerExtensions on Canvas {
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
    final height = bottomY - topY;
    final left = centerX - width / 2;
    final paint = Paint()
      ..color = dividerColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (var i = 1; i <= 4; i++) {
      final y = bottomY - (height * (i * 0.2));
      drawLine(Offset(left + 2, y), Offset(left + width - 2, y), paint);
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
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.15),
          Colors.white.withValues(alpha: 0.05),
          Colors.transparent,
          Colors.black.withValues(alpha: 0.05),
        ],
        stops: const [0, 0.3, 0.5, 1],
      ).createShader(Rect.fromLTWH(left, topY, width, height));

    drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(left, topY, width, height), Radius.circular(radius)),
      reflectionPaint,
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
    final totalHeight = bottomY - fillTop + 100;

    for (var i = 0; i < cloudCount; i++) {
      final offset = i / cloudCount;
      final progress = (animationValue + offset) % 1.0;

      final y = (bottomY + 50) - (totalHeight * progress);
      final opacity = math.sin(progress * math.pi) * 0.45;

      final startXOffset = (random.nextDouble() - 0.5) * width;
      final driftX = math.sin(progress * math.pi * 2 + i) * 15.0;
      final x = centerX + startXOffset + driftX;

      final radius = 25.0 + random.nextDouble() * 35.0;
      final stretch = 1.4 + random.nextDouble() * 0.8;
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

    final pulse = (math.sin(animationValue * math.pi * 4) + 1) / 2;
    final coreGlow = Paint()
      ..shader = RadialGradient(
        colors: [Colors.white, beamColor.withValues(alpha: 0.8), beamColor.withValues(alpha: 0.2), Colors.transparent],
        stops: const [0.0, 0.2, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: 40))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10 + pulse * 10);
    drawCircle(Offset(centerX, centerY), 30 + pulse * 15, coreGlow);

    for (var i = 0; i < beamCount; i++) {
      final rotation = (animationValue * math.pi * 0.5) + (i * math.pi * 2 / beamCount);
      final rayWidth = 2.0 + random.nextDouble() * 8.0;
      final rayOpacity = 0.1 + (random.nextDouble() * 0.2);

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
      drawRect(Rect.fromLTWH(-rayWidth / 2, 0, rayWidth, maxLen), rayPaint);
      rotate(math.pi);
      drawRect(Rect.fromLTWH(-rayWidth / 2, 0, rayWidth, maxLen), rayPaint);
      restore();
    }

    final sparkleRandom = math.Random((animationValue * 100).toInt());
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
    int cols = 3,
  }) {
    final random = math.Random(101);
    final atoms = <Offset>[];
    final rowHeight = (bottomY - fillTop) / rows;
    final colWidth = width / cols;

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final idx = r * cols + c;
        final drift = getDriftOffset(animationValue: animationValue, index: idx, random: random, maxDrift: 20);
        final baseX = (centerX - width / 2) + (c * colWidth) + (colWidth / 2);
        final baseY = fillTop + (r * rowHeight) + (rowHeight / 2);
        final jitterX = (random.nextDouble() - 0.5) * (colWidth * 0.7);
        final jitterY = (random.nextDouble() - 0.5) * (rowHeight * 0.7);
        atoms.add(Offset(baseX + jitterX + drift.dx, baseY + jitterY + drift.dy));
      }
    }

    final bondPaint = Paint()
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final atomPaint = Paint()..style = PaintingStyle.fill;

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

    for (var i = 0; i < atoms.length; i++) {
      final size = 3.0 + random.nextDouble() * 3.0;
      atomPaint.color = atomColor.withValues(alpha: 0.8);
      drawCircle(atoms[i], size, atomPaint);
      drawCircle(
        atoms[i],
        size * 2.5,
        Paint()
          ..color = atomColor.withValues(alpha: 0.15)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );
    }
  }

  void drawBacterialColony({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color organismColor,
    int rows = 3,
    int cols = 2,
  }) {
    final random = math.Random(555);
    final rowHeight = (bottomY - fillTop) / rows;
    final colWidth = width / cols;

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final idx = r * cols + c;
        final drift = getDriftOffset(animationValue: animationValue, index: idx, random: random, maxDrift: 20);
        final baseX = (centerX - width / 2) + (c * colWidth) + (colWidth / 2);
        final baseY = fillTop + (r * rowHeight) + (rowHeight / 2);
        final jitterX = (random.nextDouble() - 0.5) * (colWidth * 0.5);
        final jitterY = (random.nextDouble() - 0.5) * (rowHeight * 0.5);
        final x = baseX + jitterX + drift.dx;
        final y = baseY + jitterY + drift.dy;

        final baseSize = 8.0 + random.nextDouble() * 10.0;
        final pulse = (math.sin(animationValue * math.pi * 3 + idx) + 1) / 2;
        final currentSize = baseSize * (0.9 + pulse * 0.2);

        final organismPaint = Paint()
          ..color = organismColor.withValues(alpha: 0.6 + pulse * 0.2)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

        save();
        translate(x, y);
        rotate(animationValue * math.pi * 0.5 + idx);

        final path = Path();
        for (var j = 0; j < 8; j++) {
          final angle = (j * 45) * math.pi / 180;
          final radius = currentSize * (0.8 + math.sin(animationValue * math.pi * 2 + j + idx) * 0.2);
          final px = math.cos(angle) * radius;
          final py = math.sin(angle) * radius;
          if (j == 0)
            path.moveTo(px, py);
          else
            path.lineTo(px, py);
        }
        path.close();
        drawPath(path, organismPaint);

        drawCircle(Offset.zero, currentSize * 0.3, Paint()..color = Colors.black.withValues(alpha: 0.2));
        restore();
      }
    }
  }

  void drawBloodFlow({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color cellColor,
    int rows = 4,
    int cols = 3,
  }) {
    final random = math.Random(999);
    final rowHeight = (bottomY - fillTop) / rows;
    final colWidth = width / cols;

    final bubbleRandom = math.Random((animationValue * 50).toInt());
    for (var i = 0; i < 8; i++) {
      final bProgress = (animationValue * 0.7 + i / 8) % 1.0;
      final bx = (centerX - width / 2) + (bubbleRandom.nextDouble() * width);
      final by = bottomY - ((bottomY - fillTop + 40) * bProgress);
      final bSize = 2.0 + bubbleRandom.nextDouble() * 4.0;
      final bOpacity = math.sin(bProgress * math.pi) * 0.3;
      drawCircle(
        Offset(bx, by),
        bSize,
        Paint()
          ..color = Colors.black.withValues(alpha: bOpacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0,
      );
    }

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final idx = r * cols + c;
        final drift = getDriftOffset(animationValue: animationValue, index: idx, random: random, maxDrift: 20);
        final baseX = (centerX - width / 2) + (c * colWidth) + (colWidth / 2);
        final baseY = fillTop + (r * rowHeight) + (rowHeight / 2);
        final jitterX = (random.nextDouble() - 0.5) * (colWidth * 0.6);
        final jitterY = (random.nextDouble() - 0.5) * (rowHeight * 0.6);
        final x = baseX + jitterX + drift.dx;
        final y = baseY + jitterY + drift.dy;
        final cellSize = 6.0 + random.nextDouble() * 8.0;
        final rotation = animationValue * math.pi * 0.8 + idx;
        final tilt = math.sin(animationValue * math.pi + idx) * 0.5;

        save();
        translate(x, y);
        rotate(rotation);
        scale(1, 0.6 + tilt.abs());
        final paint = Paint()
          ..color = cellColor.withValues(alpha: 0.8)
          ..style = PaintingStyle.fill;
        drawCircle(Offset.zero, cellSize, paint);
        drawCircle(
          Offset.zero,
          cellSize * 0.5,
          Paint()
            ..color = Colors.black.withValues(alpha: 0.15)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
        );
        restore();
      }
    }
  }

  void drawBioOrganic({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color sporeColor,
    int nodeCount = 6,
  }) {
    final random = math.Random(888);
    final height = bottomY - fillTop;
    final pulse = (math.sin(animationValue * math.pi * 2) + 1) / 2;

    final networkPaint = Paint()
      ..color = sporeColor.withValues(alpha: 0.1 + pulse * 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5 + pulse * 1.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    final nodes = <Offset>[];
    for (var i = 0; i < nodeCount; i++) {
      final drift = getDriftOffset(animationValue: animationValue * 0.5, index: i, random: random, maxDrift: 30);
      nodes.add(
        Offset(
          centerX + (random.nextDouble() - 0.5) * width * 0.8 + drift.dx,
          fillTop + random.nextDouble() * height + drift.dy,
        ),
      );
    }

    for (var i = 0; i < nodes.length; i++) {
      for (var j = i + 1; j < nodes.length; j++) {
        final dist = (nodes[i] - nodes[j]).distance;
        if (dist < width * 0.7) {
          final path = Path()
            ..moveTo(nodes[i].dx, nodes[i].dy)
            ..quadraticBezierTo(
              (nodes[i].dx + nodes[j].dx) / 2 + math.sin(animationValue * math.pi + i) * 20,
              (nodes[i].dy + nodes[j].dy) / 2 + math.cos(animationValue * math.pi + j) * 20,
              nodes[j].dx,
              nodes[j].dy,
            );
          drawPath(path, networkPaint);
        }
      }
    }

    for (var i = 0; i < 12; i++) {
      final sporeRandom = math.Random(i + 100);
      final speedX = 0.3 + sporeRandom.nextDouble() * 0.4;
      final speedY = 0.2 + sporeRandom.nextDouble() * 0.3;
      final sx = centerX + math.sin(animationValue * math.pi * 2 * speedX + i) * (width * 0.45);
      final sy = fillTop + (height * 0.5) + math.cos(animationValue * math.pi * 2 * speedY + i) * (height * 0.4);
      final sPulse = (math.sin(animationValue * math.pi * 4 + i) + 1) / 2;
      final sSize = 1.5 + sporeRandom.nextDouble() * 2.5;
      drawCircle(
        Offset(sx, sy),
        sSize,
        Paint()
          ..color = sporeColor.withValues(alpha: 0.4 + sPulse * 0.6)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1 + sPulse * 3),
      );
    }
  }

  void drawRadiationDecay({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color waveColor,
  }) {
    final height = bottomY - fillTop;
    final centerY = fillTop + height / 2;
    final random = math.Random(707);

    for (var i = 0; i < 2; i++) {
      final hazePulse = (math.sin(animationValue * math.pi * 2 + i) + 1) / 2;
      final hazePaint = Paint()
        ..shader = RadialGradient(
          colors: [
            waveColor.withValues(alpha: 0.1 * hazePulse),
            waveColor.withValues(alpha: 0.05 * hazePulse),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: width * 0.7))
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10 + i * 15);
      drawCircle(Offset(centerX, centerY), width * (0.4 + i * 0.2), hazePaint);
    }

    final coreFlicker = (math.sin(animationValue * math.pi * 30) + 1) / 2;
    final corePulse = (math.sin(animationValue * math.pi * 4) + 1) / 2;
    final coreRadius = width * 0.15 + (corePulse * 8);

    final corePath = Path();
    for (var i = 0; i < 16; i++) {
      final angle = (i * 22.5) * math.pi / 180;
      final jitter = math.sin(animationValue * 50 + i) * 4.0;
      final px = centerX + math.cos(angle) * (coreRadius + jitter);
      final py = centerY + math.sin(angle) * (coreRadius + jitter);
      if (i == 0)
        corePath.moveTo(px, py);
      else
        corePath.lineTo(px, py);
    }
    corePath.close();
    drawPath(
      corePath,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.7 + coreFlicker * 0.3)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4 + coreFlicker * 4),
    );
    drawCircle(
      Offset(centerX, centerY),
      coreRadius * 2.5,
      Paint()
        ..color = waveColor.withValues(alpha: 0.2 + corePulse * 0.2)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10 + corePulse * 10),
    );

    for (var i = 0; i < 10; i++) {
      final sOffset = i / 10;
      final sProgress = (animationValue * 5.0 + sOffset) % 1.0;
      final sAngle = (i * 36 + math.sin(animationValue * 3 + i) * 20) * math.pi / 180;
      final startR = coreRadius * 0.8;
      final endR = coreRadius + (sProgress * width * 1.5);
      final opacity = math.pow(1.0 - sProgress, 2).toDouble() * 0.8;
      final streakPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white.withValues(alpha: opacity),
            Colors.transparent,
          ],
        ).createShader(Rect.fromLTWH(0, 0, width, 2))
        ..strokeWidth = 1.0 + random.nextDouble()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);
      save();
      translate(centerX, centerY);
      rotate(sAngle);
      drawLine(Offset(startR, 0), Offset(endR, 0), streakPaint);
      restore();
    }

    final staticRandom = math.Random((animationValue * 45).toInt());
    for (var i = 0; i < 20; i++) {
      final sx = centerX + (staticRandom.nextDouble() - 0.5) * width * 1.1;
      final sy = fillTop + staticRandom.nextDouble() * height;
      final sparkColor = staticRandom.nextBool() ? Colors.white : waveColor;
      final size = 0.5 + staticRandom.nextDouble() * 1.2;
      drawCircle(
        Offset(sx, sy),
        size,
        Paint()
          ..color = sparkColor.withValues(alpha: 0.9)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
      );
    }

    final dischargeCycle = (animationValue * 0.5) % 1.0;
    if (dischargeCycle > 0.9) {
      final flashOpacity = (dischargeCycle - 0.9) * 10.0;
      final flashRadius = width * (0.3 + (1.0 - flashOpacity) * 0.7);
      drawCircle(
        Offset(centerX, centerY),
        flashRadius,
        Paint()
          ..color = const Color(0xFF00E5FF).withValues(alpha: 0.15 * flashOpacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.0
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
      );
    }
  }

  void drawPlasmaFilament({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color filamentColor,
  }) {
    final random = math.Random(505);
    final height = bottomY - fillTop;
    final centerY = fillTop + height / 2;

    // 1. Volumetric Atmosphere (Fresnel Shell)
    final atmosphereRect = Rect.fromCircle(center: Offset(centerX, centerY), radius: width * 0.48);
    drawCircle(
      Offset(centerX, centerY),
      width * 0.48,
      Paint()
        ..shader = RadialGradient(
          colors: [
            filamentColor.withValues(alpha: 0),
            filamentColor.withValues(alpha: 0.1),
            filamentColor.withValues(alpha: 0.3),
          ],
          stops: const [0.0, 0.7, 1.0],
        ).createShader(atmosphereRect)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    // 2. High-Energy Core
    final corePulse = (math.sin(animationValue * math.pi * 4) + 1) / 2;
    for (var i = 0; i < 3; i++) {
      final r = width * (0.12 - i * 0.03) + (corePulse * 4);
      drawCircle(
        Offset(centerX, centerY),
        r,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-0.2, -0.2),
            colors: [Colors.white, filamentColor.withValues(alpha: 0.8), filamentColor.withValues(alpha: 0.2)],
          ).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: r))
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2 + i * 4),
      );
    }

    // 3. 3D Rotating Sphere Filaments (Non-flexible, rigid structure)
    const filamentCount = 20;
    // Oscillatory 3D rotation (Forth and Back)
    final rotY = math.sin(animationValue * math.pi * 2) * 0.9;
    final rotX = math.cos(animationValue * math.pi * 2) * 0.55;

    for (var i = 0; i < filamentCount; i++) {
      // Distribution on sphere surface
      final phi = math.acos(-1 + (2 * i) / filamentCount);
      final theta = math.sqrt(filamentCount * math.pi) * phi;

      // Initial 3D coordinates on unit sphere
      var x = math.sin(phi) * math.cos(theta);
      var y = math.sin(phi) * math.sin(theta);
      var z = math.cos(phi);

      // Rotate Y
      final x1 = x * math.cos(rotY) - z * math.sin(rotY);
      final z1 = x * math.sin(rotY) + z * math.cos(rotY);
      x = x1;
      z = z1;

      // Rotate X
      final y2 = y * math.cos(rotX) - z * math.sin(rotX);
      final z2 = y * math.sin(rotX) + z * math.cos(rotX);
      y = y2;
      z = z2;

      // Project to 2D
      final targetX = centerX + x * (width * 0.48);
      final targetY = centerY + y * (height * 0.45);

      _drawPlasmaBranch(
        start: Offset(centerX, centerY),
        end: Offset(targetX, targetY),
        color: filamentColor,
        animationValue: animationValue,
        index: i,
        depth: 0,
        random: random,
        zDepth: z, // Actual Z-depth for perspective
        width: width,
      );

      // 4. Contact Glow (Front-facing only)
      if (z > 0) {
        final contactPulse = (math.sin(animationValue * math.pi * 8 + i) + 1) / 2;
        final contactOpacity = z.clamp(0.0, 1.0);

        drawCircle(
          Offset(targetX, targetY),
          (2 + contactPulse * 3) * contactOpacity,
          Paint()
            ..color = Colors.white.withValues(alpha: 0.8 * contactOpacity)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
        );
        drawCircle(
          Offset(targetX, targetY),
          (5 + contactPulse * 5) * contactOpacity,
          Paint()
            ..color = filamentColor.withValues(alpha: 0.4 * contactOpacity)
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3 + contactPulse * 3),
        );
      }
    }

    // 5. 3D Magnetic Cage (Fully circled orbits)
    for (var i = 0; i < 3; i++) {
      final orbitAngle = (animationValue * math.pi * 2) + (i * math.pi / 3);

      final cagePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = filamentColor.withValues(alpha: 0.1)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

      save();
      translate(centerX, centerY);
      rotate(orbitAngle);
      drawOval(Rect.fromCenter(center: Offset.zero, width: width * 0.9, height: height * 0.2), cagePaint);
      restore();
    }
  }

  void _drawPlasmaBranch({
    required Offset start,
    required Offset end,
    required Color color,
    required double animationValue,
    required int index,
    required int depth,
    required math.Random random,
    required double zDepth,
    required double width,
  }) {
    if (depth > 2) return;

    // Depth-based scaling (zDepth: -1 to 1)
    final alphaFactor = (zDepth + 1.2) / 2.2;
    final blurFactor = (1.2 - zDepth) * 1.5;
    final thicknessFactor = (zDepth + 1.5) / 2.5;

    final path = Path()..moveTo(start.dx, start.dy);

    // Rigid jitter (non-flexible curve)
    final jitterX = math.sin(animationValue * math.pi * 10 + index) * 2.0 * thicknessFactor;
    final jitterY = math.cos(animationValue * math.pi * 10 + index * 0.7) * 2.0 * thicknessFactor;

    // Calculate a rigid curve (arcing slightly)
    final midX = (start.dx + end.dx) / 2;
    final midY = (start.dy + end.dy) / 2;
    final angle = math.atan2(end.dy - start.dy, end.dx - start.dx);

    // Deterministic curve direction based on index to keep it rigid
    final curveDirection = index.isEven ? 1.0 : -1.0;
    final curveAmount = width * 0.2 * curveDirection;

    final ctrlX = midX + math.cos(angle + math.pi / 2) * curveAmount;
    final ctrlY = midY + math.sin(angle + math.pi / 2) * curveAmount;

    path.quadraticBezierTo(ctrlX, ctrlY, end.dx + jitterX, end.dy + jitterY);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Core
    drawPath(
      path,
      paint
        ..color = Colors.white.withValues(alpha: 0.8 * alphaFactor)
        ..strokeWidth = (0.9 / (depth + 1)) * thicknessFactor
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurFactor * 0.1),
    );
    // Glow
    drawPath(
      path,
      paint
        ..color = color.withValues(alpha: 0.4 * alphaFactor)
        ..strokeWidth = (4.0 / (depth + 1)) * thicknessFactor
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurFactor),
    );
  }

  void drawDarkMatterSingularity({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color singularityColor,
  }) {
    final height = bottomY - fillTop;
    final centerY = fillTop + height / 2;

    for (var i = 0; i < 12; i++) {
      final sOffset = i / 12;
      final sProgress = (animationValue * 0.8 + sOffset) % 1.0;
      final swirlAngle = sProgress * math.pi * 2 + i;
      final swirlRadius = width * (0.6 - sProgress * 0.5);
      final sx = centerX + math.cos(swirlAngle) * swirlRadius;
      final sy = centerY + math.sin(swirlAngle) * swirlRadius * 0.6;
      final sOpacity = math.sin(sProgress * math.pi) * 0.4;
      final sSize = 2.0 + (1.0 - sProgress) * 4.0;
      drawCircle(
        Offset(sx, sy),
        sSize,
        Paint()
          ..color = const Color(0xFFE1BEE7).withValues(alpha: sOpacity)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2 + (1.0 - sProgress) * 4),
      );
    }

    final horizonPulse = (math.sin(animationValue * math.pi * 2) + 1) / 2;
    drawCircle(
      Offset(centerX, centerY),
      width * 0.18,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.1 + horizonPulse * 0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );
    drawCircle(
      Offset(centerX, centerY),
      width * 0.15,
      Paint()
        ..color = Colors.black
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
    );
    drawCircle(
      Offset(centerX, centerY),
      width * 0.12,
      Paint()
        ..color = const Color(0xFF4A148C).withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );

    final fluctRandom = math.Random((animationValue * 100).toInt());
    for (var i = 0; i < 5; i++) {
      final fx = centerX + (fluctRandom.nextDouble() - 0.5) * width;
      final fy = fillTop + fluctRandom.nextDouble() * height;
      drawCircle(
        Offset(fx, fy),
        1,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.6)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
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
