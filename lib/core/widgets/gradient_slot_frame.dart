import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

/// Rounded slot frame
class GradientSlotFrame extends StatelessWidget {
  const GradientSlotFrame({
    required this.child,
    this.emphasized = false,
    this.showBorder = true,
    super.key,
  });

  final Widget child;
  final bool emphasized;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final outerR = 10.r;
    final innerPlate = Color.alphaBlend(color.primary.withValues(alpha: 0.3), color.background);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: innerPlate,
        borderRadius: BorderRadius.circular(outerR),
        border: showBorder ? Border.all(color: color.titleText, width: 1.w) : null,
        boxShadow: showBorder
            ? [
                BoxShadow(
                  color: color.titleText.withValues(alpha: emphasized ? 0.18 : 0.08),
                  blurRadius: emphasized ? 8.r : 3.r,
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
