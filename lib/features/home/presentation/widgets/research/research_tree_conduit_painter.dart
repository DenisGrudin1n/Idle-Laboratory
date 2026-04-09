import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Curved conduits from two child slot tops to one parent slot bottom (research pyramid).
class ResearchTreeConduitPainter extends CustomPainter {
  ResearchTreeConduitPainter({
    required this.slotRows,
    required this.tubeColor,
    required this.glowColor,
  });

  /// Row 0 = top (1 slot), last row = bottom (16 slots).
  final List<List<Rect>> slotRows;
  final Color tubeColor;
  final Color glowColor;

  static Offset _topCenter(Rect r) => Offset(r.center.dx, r.top);

  static Offset _bottomCenter(Rect r) => Offset(r.center.dx, r.bottom);

  @override
  void paint(Canvas canvas, Size size) {
    if (slotRows.length < 2) return;

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

    for (var t = 0; t < slotRows.length - 1; t++) {
      final parents = slotRows[t];
      final children = slotRows[t + 1];
      for (var i = 0; i < parents.length; i++) {
        final p = parents[i];
        final c0 = children[2 * i];
        final c1 = children[2 * i + 1];
        final parentBottom = _bottomCenter(p);
        final merge = Offset(
          lerpDouble(c0.center.dx, c1.center.dx, 0.5)!,
          lerpDouble(_topCenter(c0).dy, parentBottom.dy, 0.5)!,
        );
        _branch(canvas, glowPaint, _topCenter(c0), merge);
        _branch(canvas, tubePaint, _topCenter(c0), merge);
        _branch(canvas, glowPaint, _topCenter(c1), merge);
        _branch(canvas, tubePaint, _topCenter(c1), merge);
        _trunk(canvas, glowPaint, merge, parentBottom);
        _trunk(canvas, tubePaint, merge, parentBottom);
      }
    }
  }

  void _branch(Canvas canvas, Paint paint, Offset a, Offset b) {
    final path = Path()..moveTo(a.dx, a.dy);
    final midX = lerpDouble(a.dx, b.dx, 0.48)!;
    path.cubicTo(midX, a.dy, midX, b.dy, b.dx, b.dy);
    canvas.drawPath(path, paint);
  }

  void _trunk(Canvas canvas, Paint paint, Offset a, Offset b) {
    final path = Path()..moveTo(a.dx, a.dy);
    final midX = lerpDouble(a.dx, b.dx, 0.52)!;
    path.cubicTo(midX, a.dy, midX, b.dy, b.dx, b.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ResearchTreeConduitPainter oldDelegate) {
    if (oldDelegate.tubeColor != tubeColor || oldDelegate.glowColor != glowColor) return true;
    if (oldDelegate.slotRows.length != slotRows.length) return true;
    for (var t = 0; t < slotRows.length; t++) {
      if (oldDelegate.slotRows[t].length != slotRows[t].length) return true;
      for (var i = 0; i < slotRows[t].length; i++) {
        if (oldDelegate.slotRows[t][i] != slotRows[t][i]) return true;
      }
    }
    return false;
  }
}
