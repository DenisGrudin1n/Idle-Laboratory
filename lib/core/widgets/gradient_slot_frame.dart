import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

/// Gradient ring + inner fill (crafting / research slots).
class GradientSlotFrame extends StatelessWidget {
  const GradientSlotFrame({
    required this.child,
    this.emphasized = false,
    super.key,
  });

  final Widget child;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final stroke = emphasized ? 2.4.w : 1.4.w;
    final outerR = 10.r;
    final innerR = (outerR - stroke).clamp(2.r, outerR);

    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color.primary.withValues(alpha: emphasized ? 0.95 : 0.72),
        color.accent.withValues(alpha: emphasized ? 0.88 : 0.55),
        color.primary.withValues(alpha: emphasized ? 0.55 : 0.35),
      ],
      stops: const [0.0, 0.55, 1.0],
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(outerR),
        gradient: gradient,
        boxShadow: [
          BoxShadow(
            color: color.primary.withValues(alpha: emphasized ? 0.22 : 0.08),
            blurRadius: emphasized ? 10.r : 4.r,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(stroke),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(innerR),
            color: color.background.withValues(alpha: emphasized ? 0.82 : 0.68),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(innerR),
            child: child,
          ),
        ),
      ),
    );
  }
}
