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
  Widget build(BuildContext context) => Container(
    width: 0.2.sw,
    height: double.infinity,
    decoration: BoxDecoration(
      color: context.color.drawerBackground,
      borderRadius: BorderRadius.circular(8.r),
    ),
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
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

class _CellContainerPainter extends CustomPainter {
  _CellContainerPainter({required this.fillLevel, required this.animationValue})
    : super(repaint: animationValue);

  final double fillLevel;
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

    // Draw base energy fill using extension
    canvas.drawEnergyBase(
      centerX: centerX,
      fillTop: fillTop,
      width: width,
      fillHeight: fillHeight,
      gradientColors: <Color>[
        const Color(0xFF2C9FD9).withValues(alpha: 0.7),
        const Color(0xFF0F73AE).withValues(alpha: 0.85),
        const Color(0xFF0A5580),
      ],
    );

    // Draw electric lightning using extension (only when fill level is above 15%)
    if (fillLevel >= 0.15) {
      canvas.drawElectricLightning(
        centerX: centerX,
        fillTop: fillTop,
        bottomY: bottomY,
        width: width,
        animationValue: animationValue.value,
        lightningColor: const Color(0xFF5CB3E0),
      );
    }

    // Draw energy particles using extension
    canvas.drawEnergyParticles(
      centerX: centerX,
      fillTop: fillTop,
      bottomY: bottomY,
      width: width,
      animationValue: animationValue.value,
      particleColor1: const Color(0xFF6DC4E8),
      particleColor2: const Color(0xFF2E99CF),
    );

    // Draw energy glow using extension
    canvas.drawEnergyGlow(
      centerX: centerX,
      fillTop: fillTop,
      width: width,
      glowColors: <Color>[
        const Color(0xFF4DB8E8).withValues(alpha: 0.8),
        const Color(0xFF0F73AE).withValues(alpha: 0.5),
        Colors.transparent,
      ],
    );
  }

  @override
  bool shouldRepaint(covariant _CellContainerPainter oldDelegate) =>
      oldDelegate.fillLevel != fillLevel;
}
