import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/lib.dart';

/// A card that wraps home screen sections.
///
/// Provides a consistent look across all 4 panels (navigation drawer,
/// top bar, cells list, cell container) with:
///  - A dark outer border to separate from the background
///  - Rounded corners for a softer appearance
///  - A gradient background for subtle depth
///
class SectionCard extends StatelessWidget {
  const SectionCard({
    required this.child,
    this.borderRadius,
    this.padding,
    super.key,
  });

  final Widget child;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = borderRadius ?? BorderRadius.circular(10.r);

    return ClipRRect(
      borderRadius: radius,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: context.color.sectionBorder, width: 3.r),
          gradient: context.color.sectionGradient,
        ),
        child: child,
      ),
    );
  }
}
