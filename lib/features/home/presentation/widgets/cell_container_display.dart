import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/lib.dart';

class CellContainerDisplay extends StatefulWidget {
  const CellContainerDisplay({super.key});

  @override
  State<CellContainerDisplay> createState() => _CellContainerDisplayState();
}

class _CellContainerDisplayState extends State<CellContainerDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SectionCard(
    child: SizedBox(
      width: 0.2.sw,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Cell container with energy
            Builder(
              builder: (BuildContext context) {
                final double fillLevel = context.select(
                  (CellsCubit cubit) =>
                      cubit.getFillLevel(CellId.basicEnergyCell.id),
                );

                return RepaintBoundary(
                  child: SizedBox(
                    width: 120.w,
                    height: 72.h,
                    child: CustomPaint(
                      painter: _CellContainerPainter(
                        fillLevel: fillLevel,
                        animationValue: _animationController,
                        cellBodyGradient: context.color.cellBodyGradient,
                        cellTopCapGradient: context.color.cellTopCapGradient,
                        cellBottomCapGradient:
                            context.color.cellBottomCapGradient,
                        cellTopRimGradient: context.color.cellTopRimGradient,
                        cellBottomRimGradient:
                            context.color.cellBottomRimGradient,
                        energyFillGradient: context.color.energyFillGradient,
                        energyGlowGradient: context.color.energyGlowGradient,
                        energyLightningColor:
                            context.color.energyLightningColor,
                        energyParticleColor1:
                            context.color.energyParticleColor1,
                        energyParticleColor2:
                            context.color.energyParticleColor2,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class _CellContainerPainter extends CustomPainter {
  _CellContainerPainter({
    required this.fillLevel,
    required this.animationValue,
    required this.cellBodyGradient,
    required this.cellTopCapGradient,
    required this.cellBottomCapGradient,
    required this.cellTopRimGradient,
    required this.cellBottomRimGradient,
    required this.energyFillGradient,
    required this.energyGlowGradient,
    required this.energyLightningColor,
    required this.energyParticleColor1,
    required this.energyParticleColor2,
  }) : super(repaint: animationValue);

  final double fillLevel;
  final Animation<double> animationValue;

  // ── Cell container gradients (from theme) ─────────────────────────────
  final LinearGradient cellBodyGradient;
  final RadialGradient cellTopCapGradient;
  final RadialGradient cellBottomCapGradient;
  final LinearGradient cellTopRimGradient;
  final LinearGradient cellBottomRimGradient;

  // ── Energy effects colors (from theme) ────────────────────────────────
  final LinearGradient energyFillGradient;
  final RadialGradient energyGlowGradient;
  final Color energyLightningColor;
  final Color energyParticleColor1;
  final Color energyParticleColor2;

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
      bodyGradient: cellBodyGradient,
      topCapGradient: cellTopCapGradient,
      bottomCapGradient: cellBottomCapGradient,
      topRimGradient: cellTopRimGradient,
      bottomRimGradient: cellBottomRimGradient,
    );

    // Draw energy fill with electric effect
    _drawEnergyFill(canvas, centerX, topY, bottomY, containerWidth);

    // Draw container glass overlay using extension
    canvas.drawGlassOverlay(
      centerX: centerX,
      topY: topY,
      bottomY: bottomY,
      width: containerWidth,
    );
  }

  void _drawEnergyFill(
    Canvas canvas,
    double centerX,
    double topY,
    double bottomY,
    double width,
  ) {
    final double containerHeight = bottomY - topY;
    final double fillHeight = containerHeight * fillLevel;
    final double fillTop = bottomY - fillHeight;

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
      energyFillGradient.colors[0].withValues(alpha: 0.7),
      energyFillGradient.colors[1].withValues(alpha: 0.85),
      energyFillGradient.colors[2],
    ];

    // Draw base energy fill using extension
    canvas.drawEnergyBase(
      centerX: centerX,
      fillTop: fillTop,
      width: width,
      fillHeight: fillHeight,
      gradientColors: fillColors,
    );

    // Draw electric lightning (only when fill level is above 15%)
    if (fillLevel >= 0.15) {
      canvas.drawElectricLightning(
        centerX: centerX,
        fillTop: fillTop,
        bottomY: bottomY,
        width: width,
        animationValue: animationValue.value,
        lightningColor: energyLightningColor,
      );
    }

    // Draw energy particles
    canvas.drawEnergyParticles(
      centerX: centerX,
      fillTop: fillTop,
      bottomY: bottomY,
      width: width,
      animationValue: animationValue.value,
      particleColor1: energyParticleColor1,
      particleColor2: energyParticleColor2,
    );

    // Draw energy glow
    final List<Color> glowColors = <Color>[
      energyGlowGradient.colors[0].withValues(alpha: 0.8),
      energyGlowGradient.colors[1].withValues(alpha: 0.5),
      Colors.transparent,
    ];
    canvas.drawEnergyGlow(
      centerX: centerX,
      fillTop: fillTop,
      width: width,
      glowColors: glowColors,
    );
  }

  @override
  bool shouldRepaint(covariant _CellContainerPainter oldDelegate) =>
      oldDelegate.fillLevel != fillLevel;
}
