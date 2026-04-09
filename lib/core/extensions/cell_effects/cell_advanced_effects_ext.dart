import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/utils/painter_utils.dart';

/// Extension on Canvas for advanced effects: light, molecules, radiation, plasma, and dark matter
extension CellAdvancedEffectsExt on Canvas {
  /// Draws rotating light beams and a pulsing central core
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
    final height = bottomY - fillTop;
    final centerY = fillTop + height / 2;
    final maxLen = math.max(width, height) * 1.5;

    final pulse = PainterUtils.pulse(animationValue, frequency: 4);
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

    final sparkleRandom = PainterUtils.seededRandom(animationValue / 1000000);
    for (var i = 0; i < 15; i++) {
      final sx = centerX - width / 2 + (sparkleRandom.nextDouble() * width);
      final sy = fillTop + (sparkleRandom.nextDouble() * height);
      final size = 0.5 + sparkleRandom.nextDouble() * 1.5;

      drawCircle(Offset(sx, sy), size, Paint()..color = Colors.white..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1));
      if (sparkleRandom.nextDouble() > 0.7) {
        drawLine(
          Offset(sx - 5, sy), Offset(sx + 5, sy),
          Paint()..color = Colors.white.withValues(alpha: 0.4)..strokeWidth = 0.5..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
        );
      }
    }
  }

  /// Draws atoms drifting within the container and connecting with proximity bonds
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

    PainterUtils.forGrid(
      centerX: centerX,
      topY: fillTop,
      width: width,
      height: bottomY - fillTop,
      rows: rows,
      cols: cols,
      action: (idx, x, y, cw, ch) {
        final drift = PainterUtils.getDriftOffset(animationValue: animationValue, index: idx, random: random, maxDrift: 20);
        atoms.add(Offset(x + (random.nextDouble() - 0.5) * cw * 0.7 + drift.dx, y + (random.nextDouble() - 0.5) * ch * 0.7 + drift.dy));
      },
    );

    for (var i = 0; i < atoms.length; i++) {
      for (var j = i + 1; j < atoms.length; j++) {
        final distance = (atoms[i] - atoms[j]).distance;
        final maxBondDistance = width * 0.55;
        if (distance < maxBondDistance) {
          final opacity = (1.0 - distance / maxBondDistance) * 0.35;
          drawLine(atoms[i], atoms[j], Paint()..strokeWidth = 1.2..style = PaintingStyle.stroke..color = bondColor.withValues(alpha: opacity));
        }
      }
      final size = 3.0 + random.nextDouble() * 3.0;
      drawCircle(atoms[i], size, Paint()..color = atomColor.withValues(alpha: 0.8));
      drawCircle(atoms[i], size * 2.5, Paint()..color = atomColor.withValues(alpha: 0.15)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4));
    }
  }

  /// Draws complex radiation effects: hazardous haze, unstable core, and high-velocity gamma streaks
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

    // 1. Atmospheric Haze
    for (var i = 0; i < 2; i++) {
      final hazePulse = PainterUtils.pulse(animationValue, phase: i.toDouble());
      final hazePaint = Paint()
        ..shader = RadialGradient(
          colors: [waveColor.withValues(alpha: 0.1 * hazePulse), waveColor.withValues(alpha: 0.05 * hazePulse), Colors.transparent],
        ).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: width * 0.7))
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10 + i * 15);
      drawCircle(Offset(centerX, centerY), width * (0.4 + i * 0.2), hazePaint);
    }

    // 2. Unstable Core
    final coreFlicker = PainterUtils.pulse(animationValue, frequency: 15);
    final corePulse = PainterUtils.pulse(animationValue, frequency: 2);
    final coreRadius = width * 0.15 + (corePulse * 8);

    final corePath = Path();
    for (var i = 0; i < 16; i++) {
      final angle = (i * 22.5) * math.pi / 180;
      final px = centerX + math.cos(angle) * (coreRadius + math.sin(animationValue * 50 + i) * 4.0);
      final py = centerY + math.sin(angle) * (coreRadius + math.sin(animationValue * 50 + i) * 4.0);
      if (i == 0) corePath.moveTo(px, py); else corePath.lineTo(px, py);
    }
    corePath.close();
    drawPath(corePath, Paint()..color = Colors.white.withValues(alpha: 0.7 + coreFlicker * 0.3)..maskFilter = MaskFilter.blur(BlurStyle.normal, 4 + coreFlicker * 4));
    drawCircle(Offset(centerX, centerY), coreRadius * 2.5, Paint()..color = waveColor.withValues(alpha: 0.2 + corePulse * 0.2)..maskFilter = MaskFilter.blur(BlurStyle.normal, 10 + corePulse * 10));

    // 3. Gamma Streaks
    for (var i = 0; i < 10; i++) {
      final sProgress = (animationValue * 5.0 + i / 10) % 1.0;
      final sAngle = (i * 36 + math.sin(animationValue * 3 + i) * 20) * math.pi / 180;
      final opacity = math.pow(1.0 - sProgress, 2).toDouble() * 0.8;
      save();
      translate(centerX, centerY);
      rotate(sAngle);
      drawLine(
        Offset(coreRadius * 0.8, 0), Offset(coreRadius + sProgress * width * 1.5, 0),
        Paint()
          ..shader = LinearGradient(colors: [Colors.white.withValues(alpha: opacity), Colors.transparent]).createShader(Rect.fromLTWH(0, 0, width, 2))
          ..strokeWidth = 1.0 + random.nextDouble()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
      );
      restore();
    }

    // 4. Scintillation
    final staticRandom = PainterUtils.seededRandom(animationValue / 1000000, offset: 45);
    for (var i = 0; i < 20; i++) {
      final sx = centerX + (staticRandom.nextDouble() - 0.5) * width * 1.1;
      final sy = fillTop + staticRandom.nextDouble() * height;
      drawCircle(Offset(sx, sy), 0.5 + staticRandom.nextDouble() * 1.2, Paint()..color = staticRandom.nextBool() ? Colors.white : waveColor..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1));
    }

    // 5. Cherenkov Flash
    final flashProgress = (animationValue * 0.5) % 1.0;
    if (flashProgress > 0.9) {
      final flashOpacity = (flashProgress - 0.9) * 10.0;
      drawCircle(Offset(centerX, centerY), width * (0.3 + (1.0 - flashOpacity) * 0.7), Paint()..color = const Color(0xFF00E5FF).withValues(alpha: 0.15 * flashOpacity)..style = PaintingStyle.stroke..strokeWidth = 4.0..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8));
    }
  }

  /// Draws a complex 3D rotating plasma structure with atmospheric shell and rigid arcing filaments
  void drawPlasmaFilament({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color filamentColor,
  }) {
    final height = bottomY - fillTop;
    final centerY = fillTop + height / 2;

    // 1. Atmosphere
    final atmosphereRect = Rect.fromCircle(center: Offset(centerX, centerY), radius: width * 0.48);
    drawCircle(Offset(centerX, centerY), width * 0.48, Paint()..shader = RadialGradient(colors: [filamentColor.withValues(alpha: 0), filamentColor.withValues(alpha: 0.1), filamentColor.withValues(alpha: 0.3)], stops: const [0.0, 0.7, 1.0]).createShader(atmosphereRect)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10));

    // 2. Core
    final corePulse = PainterUtils.pulse(animationValue, frequency: 2);
    for (var i = 0; i < 3; i++) {
      final r = width * (0.12 - i * 0.03) + (corePulse * 4);
      drawCircle(Offset(centerX, centerY), r, Paint()..shader = RadialGradient(center: const Alignment(-0.2, -0.2), colors: [Colors.white, filamentColor.withValues(alpha: 0.8), filamentColor.withValues(alpha: 0.2)]).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: r))..maskFilter = MaskFilter.blur(BlurStyle.normal, 2 + i * 4));
    }

    // 3. 3D Structure
    const fCount = 20;
    final rotY = math.sin(animationValue * math.pi * 2) * 0.9;
    final rotX = math.cos(animationValue * math.pi * 2) * 0.55;

    for (var i = 0; i < fCount; i++) {
      final phi = math.acos(-1 + (2 * i) / fCount);
      final theta = math.sqrt(fCount * math.pi) * phi;
      final x = math.sin(phi) * math.cos(theta);
      final y = math.sin(phi) * math.sin(theta);
      final z = math.cos(phi);
      // Rotation logic
      final x1 = x * math.cos(rotY) - z * math.sin(rotY);
      final z1 = x * math.sin(rotY) + z * math.cos(rotY);
      final y2 = y * math.cos(rotX) - z1 * math.sin(rotX);
      final z2 = y * math.sin(rotX) + z1 * math.cos(rotX);
      
      final tx = centerX + x1 * width * 0.48;
      final ty = centerY + y2 * height * 0.45;

      _drawPlasmaBranch(start: Offset(centerX, centerY), end: Offset(tx, ty), color: filamentColor, animationValue: animationValue, index: i, zDepth: z2, width: width);

      if (z2 > 0) {
        final cPulse = (math.sin(animationValue * math.pi * 8 + i) + 1) / 2;
        drawCircle(Offset(tx, ty), (2 + cPulse * 3) * z2, Paint()..color = Colors.white.withValues(alpha: 0.8 * z2)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1));
        drawCircle(Offset(tx, ty), (5 + cPulse * 5) * z2, Paint()..color = filamentColor.withValues(alpha: 0.4 * z2)..maskFilter = MaskFilter.blur(BlurStyle.normal, 3 + cPulse * 3));
      }
    }

    // 4. Magnetic Cage
    for (var i = 0; i < 3; i++) {
      save();
      translate(centerX, centerY);
      rotate((animationValue * math.pi * 2) + (i * math.pi / 3));
      drawOval(Rect.fromCenter(center: Offset.zero, width: width * 0.9, height: height * 0.2), Paint()..style = PaintingStyle.stroke..strokeWidth = 1.0..color = filamentColor.withValues(alpha: 0.1)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3));
      restore();
    }
  }

  void _drawPlasmaBranch({required Offset start, required Offset end, required Color color, required double animationValue, required int index, required double zDepth, required double width}) {
    final alpha = (zDepth + 1.2) / 2.2;
    final blur = (1.2 - zDepth) * 1.5;
    final thick = (zDepth + 1.5) / 2.5;
    final path = Path()..moveTo(start.dx, start.dy);
    final jX = math.sin(animationValue * math.pi * 10 + index) * 2.0 * thick;
    final jY = math.cos(animationValue * math.pi * 10 + index * 0.7) * 2.0 * thick;
    final angle = math.atan2(end.dy - start.dy, end.dx - start.dx);
    final curve = width * 0.2 * (index.isEven ? 1.0 : -1.0);
    path.quadraticBezierTo((start.dx + end.dx) / 2 + math.cos(angle + math.pi / 2) * curve, (start.dy + end.dy) / 2 + math.sin(angle + math.pi / 2) * curve, end.dx + jX, end.dy + jY);
    drawPath(path, Paint()..style = PaintingStyle.stroke..strokeCap = StrokeCap.round..color = Colors.white.withValues(alpha: 0.8 * alpha)..strokeWidth = 0.9 * thick..maskFilter = MaskFilter.blur(BlurStyle.normal, blur * 0.1));
    drawPath(path, Paint()..style = PaintingStyle.stroke..strokeCap = StrokeCap.round..color = color.withValues(alpha: 0.4 * alpha)..strokeWidth = 4.0 * thick..maskFilter = MaskFilter.blur(BlurStyle.normal, blur));
  }

  /// Draws a swirling dark matter singularity with orbiting debris and horizon flicker
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
      final prog = (animationValue * 0.8 + i / 12) % 1.0;
      final angle = prog * math.pi * 2 + i;
      final radius = width * (0.6 - prog * 0.5);
      final sOpacity = math.sin(prog * math.pi) * 0.4;
      drawCircle(
        Offset(centerX + math.cos(angle) * radius, centerY + math.sin(angle) * radius * 0.6),
        2.0 + (1.0 - prog) * 4.0,
        Paint()..color = const Color(0xFFE1BEE7).withValues(alpha: sOpacity)..maskFilter = MaskFilter.blur(BlurStyle.normal, 2 + (1.0 - prog) * 4),
      );
    }

    final pulse = PainterUtils.pulse(animationValue);
    drawCircle(Offset(centerX, centerY), width * 0.18, Paint()..color = Colors.white.withValues(alpha: 0.1 + pulse * 0.15)..style = PaintingStyle.stroke..strokeWidth = 2.0..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3));
    drawCircle(Offset(centerX, centerY), width * 0.15, Paint()..color = Colors.black..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2));
    drawCircle(Offset(centerX, centerY), width * 0.12, Paint()..color = const Color(0xFF4A148C).withValues(alpha: 0.3)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5));

    final random = PainterUtils.seededRandom(animationValue / 1000000);
    for (var i = 0; i < 5; i++) {
      drawCircle(Offset(centerX + (random.nextDouble() - 0.5) * width, fillTop + random.nextDouble() * height), 1, Paint()..color = Colors.white.withValues(alpha: 0.6)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1));
    }
  }

  /// Curved arcs suggesting magnetic field lines, slowly rotating.
  void drawMagneticFieldLines({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color fieldColor,
  }) {
    final height = bottomY - fillTop;
    final centerY = fillTop + height / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (var ring = 0; ring < 5; ring++) {
      final w = width * (0.35 + ring * 0.12);
      final h = height * (0.28 + ring * 0.08);
      final rect = Rect.fromCenter(center: Offset(centerX, centerY), width: w, height: h);
      save();
      translate(centerX, centerY);
      rotate(animationValue * math.pi * 2 * 0.25 + ring * 0.4);
      translate(-centerX, -centerY);
      paint
        ..strokeWidth = 1.0 + ring * 0.15
        ..color = fieldColor.withValues(alpha: 0.2 + ring * 0.06);
      drawArc(rect, -math.pi * 0.85, math.pi * 1.7, false, paint);
      restore();
    }
  }

  /// Faceted diamond shards drifting upward.
  void drawCrystallineFacets({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color facetColor,
  }) {
    final random = PainterUtils.seededRandom(animationValue);
    final height = bottomY - fillTop;
    for (var i = 0; i < 14; i++) {
      final x = centerX - width / 2 + width * random.nextDouble();
      final y = fillTop + height * ((animationValue * 0.4 + i * 0.07) % 1.0);
      save();
      translate(x, y);
      rotate(animationValue * math.pi * 2 + i * 0.5);
      final s = 4.0 + random.nextDouble() * 6;
      final path = Path()
        ..moveTo(0, -s)
        ..lineTo(s * 0.65, 0)
        ..lineTo(0, s)
        ..lineTo(-s * 0.65, 0)
        ..close();
      drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = facetColor.withValues(alpha: 0.35 + random.nextDouble() * 0.35),
      );
      drawPath(path, Paint()..color = facetColor.withValues(alpha: 0.12));
      restore();
    }
  }

  /// Double helix with ladder rungs.
  void drawGeneticHelix({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color helixColor,
  }) {
    final height = bottomY - fillTop;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
    const segments = 32;
    final amp = width * 0.18;
    for (var strand = 0; strand < 2; strand++) {
      final path = Path();
      final phase = strand * math.pi + animationValue * math.pi * 2;
      for (var i = 0; i <= segments; i++) {
        final t = i / segments;
        final y = fillTop + height * t;
        final x = centerX + math.sin(t * math.pi * 4 + phase) * amp;
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      paint.color = helixColor.withValues(alpha: 0.45 + strand * 0.15);
      drawPath(path, paint);
    }
    final rungPaint = Paint()
      ..color = helixColor.withValues(alpha: 0.22)
      ..strokeWidth = 0.9;
    for (var i = 0; i < 12; i++) {
      final t = i / 12;
      final y = fillTop + height * t;
      final x1 = centerX + math.sin(t * math.pi * 4 + animationValue * math.pi * 2) * amp;
      final x2 = centerX + math.sin(t * math.pi * 4 + animationValue * math.pi * 2 + math.pi) * amp;
      drawLine(Offset(x1, y), Offset(x2, y), rungPaint);
    }
  }

  /// Pulsing core with expanding hazard rings.
  void drawNuclearCorePulse({
    required double centerX,
    required double fillTop,
    required double bottomY,
    required double width,
    required double animationValue,
    required Color coreColor,
  }) {
    final height = bottomY - fillTop;
    final centerY = fillTop + height / 2;
    final pulse = PainterUtils.pulse(animationValue, frequency: 2);
    for (var i = 0; i < 3; i++) {
      final r = width * (0.12 + i * 0.1) + pulse * 6;
      drawCircle(
        Offset(centerX, centerY),
        r,
        Paint()
          ..color = coreColor.withValues(alpha: 0.25 - i * 0.06)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
    drawCircle(
      Offset(centerX, centerY),
      width * 0.1 + pulse * 4,
      Paint()
        ..shader = RadialGradient(
          colors: [Colors.white, coreColor.withValues(alpha: 0.9), coreColor.withValues(alpha: 0.3)],
        ).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: width * 0.15)),
    );
    for (var i = 0; i < 4; i++) {
      final prog = (animationValue * 1.2 + i * 0.25) % 1.0;
      final ringR = width * (0.15 + prog * 0.55);
      drawCircle(
        Offset(centerX, centerY),
        ringR,
        Paint()
          ..color = coreColor.withValues(alpha: (1 - prog) * 0.35)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      );
    }
  }
}
