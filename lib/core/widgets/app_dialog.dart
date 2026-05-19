import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';

/// Centered modal shell: dimmed barrier + [SectionCard] panel. Content is supplied by the caller.
class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.child,
    this.maxWidth,
    this.padding,
    this.borderRadius,
    this.insetPadding,
    super.key,
  });

  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final EdgeInsets? insetPadding;

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    double? maxWidth,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    EdgeInsets? insetPadding,
  }) =>
      showDialog<T>(
        context: context,
        barrierColor: Colors.black.withValues(alpha: 0.55),
        builder: (_) => AppDialog(
          maxWidth: maxWidth,
          padding: padding,
          borderRadius: borderRadius,
          insetPadding: insetPadding,
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: insetPadding ?? EdgeInsets.symmetric(horizontal: 28.w, vertical: 28.h),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth ?? 300.w),
          child: SectionCard(
            borderRadius: borderRadius ?? BorderRadius.circular(14.r),
            padding: padding ?? EdgeInsets.all(12.w),
            child: child,
          ),
        ),
      );
}
