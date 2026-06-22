import 'package:flutter/material.dart';
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
    const outerR = 10.0;
    final innerPlate = Color.alphaBlend(color.primary.withValues(alpha: 0.3), color.background);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: innerPlate,
        borderRadius: BorderRadius.circular(outerR),
        border: showBorder ? Border.all(color: color.titleText) : null,
        boxShadow: showBorder
            ? [
                BoxShadow(
                  color: color.titleText.withValues(alpha: emphasized ? 0.18 : 0.08),
                  blurRadius: emphasized ? 8 : 3,
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
