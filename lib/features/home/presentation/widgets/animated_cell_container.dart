import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/extensions/cell_container_extensions.dart';
import 'package:idle_laboratory/core/theme/cell_visual_theme.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

class AnimatedCellContainer extends StatelessWidget {
  const AnimatedCellContainer({required this.fillLevel, required this.visualTheme, required this.animation, super.key});
  final double fillLevel;
  final CellVisualTheme visualTheme;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    return CustomPaint(
      painter: _CellContainerPainter(
        fillLevel: fillLevel,
        visualTheme: visualTheme,
        animationValue: animation,
        dividerColor: color.primaryText,
      ),
    );
  }
}

class _CellContainerPainter extends CustomPainter {
  _CellContainerPainter({
    required this.fillLevel,
    required this.visualTheme,
    required this.animationValue,
    required this.dividerColor,
  }) : super(repaint: animationValue);
  final double fillLevel;
  final CellVisualTheme visualTheme;
  final Animation<double> animationValue;
  final Color dividerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width * 0.7;
    final height = size.height * 0.85;
    final centerX = size.width / 2;
    final topY = size.height * 0.1;
    final bottomY = topY + height;

    // 1. Draw Body & Outline
    canvas.drawCellContainer(
      centerX: centerX,
      topY: topY,
      bottomY: bottomY,
      width: width,
      bodyGradient: visualTheme.cellBodyGradient,
    );

    // 2. Draw Energy Content (Effects & Fill)
    _drawEnergyContent(
      canvas: canvas,
      centerX: centerX,
      topY: topY,
      bottomY: bottomY,
      width: width,
      fillLevel: fillLevel,
      clipPath: canvas.getContainerClipPath(centerX: centerX, topY: topY, bottomY: bottomY, width: width),
    );

    // 3. Draw Cap (Same as body gradient)
    canvas
      ..drawCellCap(centerX: centerX, topY: topY, width: width, capGradient: visualTheme.cellBodyGradient)
      // 4. Draw Dividers (PrimaryText color, on top of effects)
      ..drawFillDividers(centerX: centerX, topY: topY, bottomY: bottomY, width: width, dividerColor: dividerColor)
      // 5. Final Glass Overlay
      ..drawGlassOverlay(centerX: centerX, topY: topY, bottomY: bottomY, width: width);
  }

  void _drawEnergyContent({
    required Canvas canvas,
    required double centerX,
    required double topY,
    required double bottomY,
    required double width,
    required double fillLevel,
    required Path clipPath,
  }) {
    final fillHeight = (bottomY - topY) * fillLevel;
    final fillTop = bottomY - fillHeight;

    canvas
      ..save()
      ..clipPath(clipPath)
      // Energy Base
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

    // Effects
    if (fillLevel >= 0.1) {
      switch (visualTheme.effectType) {
        case CellEffectType.lightning:
          canvas.drawElectricLightning(
            centerX: centerX,
            fillTop: fillTop,
            bottomY: bottomY,
            width: width,
            animationValue: animationValue.value,
            lightningColor: visualTheme.effectPrimaryColor,
          );
        case CellEffectType.lavaChunks:
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
        case CellEffectType.iceCubes:
          canvas.drawIceCrystals(
            centerX: centerX,
            fillTop: fillTop,
            bottomY: bottomY,
            width: width,
            animationValue: animationValue.value,
          );
        case CellEffectType.risingVapor:
          canvas.drawRisingVapor(
            centerX: centerX,
            fillTop: fillTop,
            bottomY: bottomY,
            width: width,
            animationValue: animationValue.value,
            vaporColor: visualTheme.effectPrimaryColor,
          );
      }
    }

    // Particles
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
      // Glow
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
      oldDelegate.visualTheme != visualTheme ||
      oldDelegate.dividerColor != dividerColor;
}
