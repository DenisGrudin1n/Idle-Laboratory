import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.padding,
    this.borderRadius,
    super.key,
  });

  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? borderRadius;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => Container(
    padding: padding ?? EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
    decoration: BoxDecoration(
      color: backgroundColor ?? context.color.background,
      borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: textColor ?? context.color.primaryText,
        fontSize: fontSize ?? 9.sp,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    ),
  );
}
