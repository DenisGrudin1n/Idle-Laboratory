import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

/// A reusable badge widget for displaying status, level, or count information.
///
/// Used for locked/unlocked states, level indicators, counts, and other
/// status information throughout the app.
///
/// Example:
/// ```dart
/// StatusBadge(
///   text: 'Level 5',
///   backgroundColor: Colors.blue,
/// )
/// ```
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

  /// The text to display in the badge
  final String text;

  /// Background color of the badge. Defaults to theme's background color
  final Color? backgroundColor;

  /// Text color. Defaults to theme's primaryText color
  final Color? textColor;

  /// Font size. Defaults to 9.sp
  final double? fontSize;

  /// Font weight. Defaults to FontWeight.w500
  final FontWeight? fontWeight;

  /// Padding inside the badge. Defaults to horizontal: 6.w, vertical: 2.h
  final EdgeInsetsGeometry? padding;

  /// Border radius. Defaults to 4.r
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
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
}
