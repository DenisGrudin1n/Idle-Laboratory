import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/extensions/cell_container_extensions.dart';
import 'package:idle_laboratory/core/theme/cell_visual_theme.dart';

/// Reusable animated cell container widget.
///
/// Renders a 3D cylindrical container with animated energy/lava fill.
/// Visual appearance is fully controlled by [visualTheme].
class AnimatedCellContainer extends StatelessWidget {
  const AnimatedCellContainer({
    required this.fillLevel,
    required this.visualTheme,
    required this.animation,
    super.key,
  });

  /// Fill level from 0.0 to 1.0
  final double fillLevel;

  /// Visual theme defining all colors, gradients, and effect type
  final CellVisualTheme visualTheme;

  /// Animation controller for particle/lightning/chunk effects
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
    final double containerWidth = size.width * 0.7;
    final double containerHeight = size.height * 0.85;
    final double centerX = size.width / 2;
    final double topY = size.height * 0.1;
    final double bottomY = topY + containerHeight;

    // Draw container base using extension
    canvas.drawCellContainer(
      centerX: centerX,
      topY: topY,
      bottomY: bottomY,
      width: containerWidth,
      bodyGradient: visualTheme.cellBodyGradient,
    );

    // Draw energy/lava fill with effects
    _drawFill(canvas, centerX, topY, bottomY, containerWidth);

    // Draw container glass overlay using extension
    canvas.drawGlassOverlay(
      centerX: centerX,
      topY: topY,
      bottomY: bottomY,
      width: containerWidth,
    );
  }

  void _drawFill(
    Canvas canvas,
    double centerX,
    double topY,
    double bottomY,
    double width,
  ) {
    final double containerHeight = bottomY - topY;
    final double fillHeight = containerHeight * fillLevel;
    final double fillTop = bottomY - fillHeight;

    // Save canvas state before clipping
    canvas.save();

    // Clip to container bounds using extension
    final Path clipPath = canvas.getContainerClipPath(
      centerX: centerX,
      topY: topY,
      bottomY: bottomY,
      width: width,
    );
    canvas.clipPath(clipPath);

    // Build the per-draw gradient colors with the required alpha values.
    final List<Color> fillColors = <Color>[
      visualTheme.energyFillGradient.colors[0].withValues(alpha: 0.7),
      visualTheme.energyFillGradient.colors[1].withValues(alpha: 0.85),
      visualTheme.energyFillGradient.colors[2],
    ];

    // Draw base fill using extension
    canvas.drawEnergyBase(
      centerX: centerX,
      fillTop: fillTop,
      width: width,
      fillHeight: fillHeight,
      gradientColors: fillColors,
    );

    // Draw type-specific effects (lightning, lava chunks, etc.)
    if (fillLevel >= 0.15) {
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
      }
    }

    // Draw particles/embers
    canvas.drawEnergyParticles(
      centerX: centerX,
      fillTop: fillTop,
      bottomY: bottomY,
      width: width,
      animationValue: animationValue.value,
      particleColor1: visualTheme.effectSecondaryColor1,
      particleColor2: visualTheme.effectSecondaryColor2,
    );

    // Draw glow at the top
    final List<Color> glowColors = <Color>[
      visualTheme.energyGlowGradient.colors[0].withValues(alpha: 0.8),
      visualTheme.energyGlowGradient.colors[1].withValues(alpha: 0.5),
      Colors.transparent,
    ];
    canvas.drawEnergyGlow(
      centerX: centerX,
      fillTop: fillTop,
      width: width,
      glowColors: glowColors,
    );

    // Restore canvas state to remove clipping
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CellContainerPainter oldDelegate) =>
      oldDelegate.fillLevel != fillLevel ||
      oldDelegate.visualTheme != visualTheme;
}
