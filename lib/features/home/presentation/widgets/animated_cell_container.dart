import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/extensions/cell_container_extensions.dart';
import 'package:idle_laboratory/core/theme/cell_visual_theme.dart';

class AnimatedCellContainer extends StatelessWidget {
  const AnimatedCellContainer({
    required this.fillLevel,
    required this.visualTheme,
    required this.animation,
    super.key,
  });
  final double fillLevel;
  final CellVisualTheme visualTheme;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _CellContainerPainter(
      fillLevel: fillLevel,
      visualTheme: visualTheme,
      animationValue: animation,
    ),
  );
}

class _CellContainerPainter extends CustomPainter {
  _CellContainerPainter({
    required this.fillLevel,
    required this.visualTheme,
    required this.animationValue,
  }) : super(repaint: animationValue);
  final double fillLevel;
  final CellVisualTheme visualTheme;
  final Animation<double> animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width * 0.7;
    final height = size.height * 0.85;
    final centerX = size.width / 2;
    final topY = size.height * 0.1;
    final bottomY = topY + height;
    canvas.drawCellContainer(
      centerX: centerX,
      topY: topY,
      bottomY: bottomY,
      width: width,
      bodyGradient: visualTheme.cellBodyGradient,
    );
    _drawFill(canvas, centerX, topY, bottomY, width);
    canvas.drawGlassOverlay(
      centerX: centerX,
      topY: topY,
      bottomY: bottomY,
      width: width,
    );
  }

  void _drawFill(
    Canvas canvas,
    double centerX,
    double topY,
    double bottomY,
    double width,
  ) {
    final fillHeight = (bottomY - topY) * fillLevel;
    final fillTop = bottomY - fillHeight;
    canvas
      ..save()
      ..clipPath(
        canvas.getContainerClipPath(
          centerX: centerX,
          topY: topY,
          bottomY: bottomY,
          width: width,
        ),
      )
      ..drawEnergyBase(
        centerX: centerX,
        fillTop: fillTop,
        width: width,
        fillHeight: fillHeight,
        gradientColors: [
          visualTheme.energyFillGradient.colors[0].withValues(alpha: 0.7),
          visualTheme.energyFillGradient.colors[1].withValues(alpha: 0.85),
          visualTheme.energyFillGradient.colors[2],
        ],
      );

    if (fillLevel >= 0.15) {
      if (visualTheme.effectType == CellEffectType.lightning) {
        canvas.drawElectricLightning(
          centerX: centerX,
          fillTop: fillTop,
          bottomY: bottomY,
          width: width,
          animationValue: animationValue.value,
          lightningColor: visualTheme.effectPrimaryColor,
        );
      } else {
        canvas.drawLavaChunks(
          centerX: centerX,
          fillTop: fillTop,
          bottomY: bottomY,
          width: width,
          animationValue: animationValue.value,
          chunkColor: visualTheme.effectPrimaryColor,
          emberColor1: visualTheme.effectSecondaryColor1,
          emberColor2: visualTheme.effectSecondaryColor2,
        );
      }
    }

    canvas
      ..drawEnergyParticles(
        centerX: centerX,
        fillTop: fillTop,
        bottomY: bottomY,
        width: width,
        animationValue: animationValue.value,
        particleColor1: visualTheme.effectSecondaryColor1,
        particleColor2: visualTheme.effectSecondaryColor2,
      )
      ..drawEnergyGlow(
        centerX: centerX,
        fillTop: fillTop,
        width: width,
        glowColors: [
          visualTheme.energyGlowGradient.colors[0].withValues(alpha: 0.8),
          visualTheme.energyGlowGradient.colors[1].withValues(alpha: 0.5),
          Colors.transparent,
        ],
      )
      ..restore();
  }

  @override
  bool shouldRepaint(_CellContainerPainter oldDelegate) =>
      oldDelegate.fillLevel != fillLevel ||
      oldDelegate.visualTheme != visualTheme;
}
