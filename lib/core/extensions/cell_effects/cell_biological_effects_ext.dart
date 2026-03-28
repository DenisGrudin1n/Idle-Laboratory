import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/utils/painter_utils.dart';

/// Extension on Canvas for biological effects: bacteria colonies, blood cells, and organic networks
extension CellBiologicalEffectsExt on Canvas {
  /// Draws multiple pulsing and rotating bacterial organisms in a grid
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
    final height = bottomY - fillTop;

    PainterUtils.forGrid(
      centerX: centerX,
      topY: fillTop,
      width: width,
      height: height,
      rows: rows,
      cols: cols,
      action: (idx, x, y, cw, ch) {
        final drift = PainterUtils.getDriftOffset(
          animationValue: animationValue,
          index: idx,
          random: random,
          maxDrift: 20,
        );
        final px = x + (random.nextDouble() - 0.5) * cw * 0.5 + drift.dx;
        final py = y + (random.nextDouble() - 0.5) * ch * 0.5 + drift.dy;

        final pulse = PainterUtils.pulse(animationValue, frequency: 1.5, phase: idx.toDouble());
        final size = (8.0 + random.nextDouble() * 10.0) * (0.9 + pulse * 0.2);

        save();
        translate(px, py);
        rotate(animationValue * math.pi * 0.5 + idx);

        final path = Path();
        for (var j = 0; j < 8; j++) {
          final angle = (j * 45) * math.pi / 180;
          final r = size * (0.8 + math.sin(animationValue * math.pi * 2 + j + idx) * 0.2);
          final p = Offset(math.cos(angle) * r, math.sin(angle) * r);
          if (j == 0)
            path.moveTo(p.dx, p.dy);
          else
            path.lineTo(p.dx, p.dy);
        }
        path.close();
        drawPath(
          path,
          Paint()
            ..color = organismColor.withValues(alpha: 0.6 + pulse * 0.2)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
        );
        drawCircle(Offset.zero, size * 0.3, Paint()..color = Colors.black.withValues(alpha: 0.2));
        restore();
      },
    );
  }

  /// Draws red blood cells drifting in the container with a boiling/bubbling background effect
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
    final height = bottomY - fillTop;

    // 1. Boiling Bubbles
    final bRandom = PainterUtils.seededRandom(animationValue / 1000000, offset: 50);
    for (var i = 0; i < 8; i++) {
      final prog = (animationValue * 0.7 + i / 8) % 1.0;
      final opacity = math.sin(prog * math.pi) * 0.3;
      drawCircle(
        Offset((centerX - width / 2) + bRandom.nextDouble() * width, bottomY - ((height + 40) * prog)),
        2.0 + bRandom.nextDouble() * 4.0,
        Paint()
          ..color = Colors.black.withValues(alpha: opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0,
      );
    }

    // 2. Red Blood Cells
    PainterUtils.forGrid(
      centerX: centerX,
      topY: fillTop,
      width: width,
      height: height,
      rows: rows,
      cols: cols,
      action: (idx, x, y, cw, ch) {
        final drift = PainterUtils.getDriftOffset(
          animationValue: animationValue,
          index: idx,
          random: random,
          maxDrift: 20,
        );
        final px = x + (random.nextDouble() - 0.5) * cw * 0.6 + drift.dx;
        final py = y + (random.nextDouble() - 0.5) * ch * 0.6 + drift.dy;
        final tilt = math.sin(animationValue * math.pi + idx) * 0.5;

        save();
        translate(px, py);
        rotate(animationValue * math.pi * 0.8 + idx);
        scale(1, 0.6 + tilt.abs());
        final size = 6.0 + random.nextDouble() * 8.0;
        drawCircle(Offset.zero, size, Paint()..color = cellColor.withValues(alpha: 0.8));
        drawCircle(
          Offset.zero,
          size * 0.5,
          Paint()
            ..color = Colors.black.withValues(alpha: 0.15)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
        );
        restore();
      },
    );
  }

  /// Draws an organic "neural" network and floating bioluminescent spores
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
    final pulse = PainterUtils.pulse(animationValue);

    final networkPaint = Paint()
      ..color = sporeColor.withValues(alpha: 0.1 + pulse * 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5 + pulse * 1.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    final nodes = <Offset>[];
    for (var i = 0; i < nodeCount; i++) {
      final drift = PainterUtils.getDriftOffset(
        animationValue: animationValue * 0.5,
        index: i,
        random: random,
        maxDrift: 30,
      );
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
          final p = Path()
            ..moveTo(nodes[i].dx, nodes[i].dy)
            ..quadraticBezierTo(
              (nodes[i].dx + nodes[j].dx) / 2 + math.sin(animationValue * math.pi + i) * 20,
              (nodes[i].dy + nodes[j].dy) / 2 + math.cos(animationValue * math.pi + j) * 20,
              nodes[j].dx,
              nodes[j].dy,
            );
          drawPath(p, networkPaint);
        }
      }
    }

    for (var i = 0; i < 12; i++) {
      final sRnd = math.Random(i + 100);
      final sPulse = PainterUtils.pulse(animationValue, frequency: 2, phase: i.toDouble());
      final sx = centerX + math.sin(animationValue * math.pi * 2 * (0.3 + sRnd.nextDouble() * 0.4) + i) * width * 0.45;
      final sy =
          fillTop +
          height * 0.5 +
          math.cos(animationValue * math.pi * 2 * (0.2 + sRnd.nextDouble() * 0.3) + i) * height * 0.4;
      drawCircle(
        Offset(sx, sy),
        1.5 + sRnd.nextDouble() * 2.5,
        Paint()
          ..color = sporeColor.withValues(alpha: 0.4 + sPulse * 0.6)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1 + sPulse * 3),
      );
    }
  }
}
