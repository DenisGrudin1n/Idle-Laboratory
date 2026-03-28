import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Extension on Canvas for basic cell container drawing components
extension CellPainterBaseExt on Canvas {
  /// Draws the main container body and a soft halo around it
  void drawCellContainer({
    required double centerX,
    required double topY,
    required double bottomY,
    required double width,
    required LinearGradient bodyGradient,
  }) {
    final left = centerX - width / 2;
    final radius = width * 0.08;
    final height = bottomY - topY;

    // 1. Halo/Shadow
    final haloPaint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14)
      ..color = Colors.black.withValues(alpha: 0.55);
    drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left - 4, topY - 4, width + 8, height + 8),
        Radius.circular(radius + 4),
      ),
      haloPaint,
    );

    // 2. Body Gradient
    final bodyPaint = Paint()..shader = bodyGradient.createShader(Rect.fromLTWH(left, topY, width, height));
    drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(left, topY, width, height), Radius.circular(radius)),
      bodyPaint,
    );
  }

  /// Draws a cap at the top of the cell container
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

  /// Draws horizontal indicators across the container at fixed fill levels
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

  /// Draws a complex glass-like reflection and border overlay on top of everything
  void drawGlassOverlay({
    required double centerX,
    required double topY,
    required double bottomY,
    required double width,
  }) {
    final left = centerX - width / 2;
    final height = bottomY - topY;
    final radius = width * 0.08;

    // 1. Reflection Gradient
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

    // 2. Outer Dark Border
    drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(left, topY, width, height), Radius.circular(radius)),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // 3. Inner Light Reflection Border
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

  /// Returns a Path that fits the internal area of the cell container
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
