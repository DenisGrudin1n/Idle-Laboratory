import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Full-width conduits: from the right edge of input slots to the left edge of the output slot.
class CraftingFullRowConduitPainter extends CustomPainter {
  CraftingFullRowConduitPainter({
    required this.slotSide,
    required this.verticalGap,
    required this.gapBeforeOutput,
    required this.outputSide,
    required this.tubeColor,
    required this.glowColor,
  });

  final double slotSide;
  final double verticalGap;
  final double gapBeforeOutput;
  final double outputSide;
  final Color tubeColor;
  final Color glowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    if (size.width <= 0 || h <= 0) return;

    final attachX = slotSide;
    final endX = (size.width - gapBeforeOutput - outputSide).clamp(attachX + 8, size.width);

    final y1 = slotSide * 0.5;
    final y2 = slotSide + verticalGap + slotSide * 0.5;
    final y3 = 2 * slotSide + 2 * verticalGap + slotSide * 0.5;

    final merge = Offset(
      attachX + (endX - attachX) * 0.52,
      h * 0.5,
    );

    final glowPaint = Paint()
      ..color = glowColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    final tubePaint = Paint()
      ..color = tubeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;

    for (final y in [y1, y2, y3]) {
      _branch(canvas, glowPaint, Offset(attachX, y), merge);
      _branch(canvas, tubePaint, Offset(attachX, y), merge);
    }

    _trunk(canvas, glowPaint, merge, Offset(endX, h * 0.5));
    _trunk(canvas, tubePaint, merge, Offset(endX, h * 0.5));
  }

  void _branch(Canvas canvas, Paint paint, Offset a, Offset b) {
    final path = Path()..moveTo(a.dx, a.dy);
    final midX = lerpDouble(a.dx, b.dx, 0.45)!;
    path.cubicTo(midX, a.dy, midX, b.dy, b.dx, b.dy);
    canvas.drawPath(path, paint);
  }

  void _trunk(Canvas canvas, Paint paint, Offset a, Offset b) {
    final path = Path()..moveTo(a.dx, a.dy);
    final midX = lerpDouble(a.dx, b.dx, 0.55)!;
    path.cubicTo(midX, a.dy, midX, b.dy, b.dx, b.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CraftingFullRowConduitPainter oldDelegate) =>
      oldDelegate.slotSide != slotSide ||
      oldDelegate.verticalGap != verticalGap ||
      oldDelegate.gapBeforeOutput != gapBeforeOutput ||
      oldDelegate.outputSide != outputSide ||
      oldDelegate.tubeColor != tubeColor ||
      oldDelegate.glowColor != glowColor;
}
