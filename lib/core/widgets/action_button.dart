import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.icon,
    required this.label,
    this.onTap,
    this.isEnabled = true,
    this.enabledColor,
    this.disabledColor,
    this.enabledTextColor,
    this.disabledTextColor,
    this.iconSize,
    this.fontSize,
    this.padding,
    this.borderRadius,
    this.borderWidth,
    this.badgeText,
    this.mainAxisSize = MainAxisSize.min,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isEnabled;
  final Color? enabledColor;
  final Color? disabledColor;
  final Color? enabledTextColor;
  final Color? disabledTextColor;
  final double? iconSize;
  final double? fontSize;
  final double? borderRadius;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;
  final String? badgeText;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isEnabled
        ? (enabledColor ?? context.color.primary)
        : (disabledColor ?? context.color.primaryText.withValues(alpha: 0.3));
    final foregroundColor = isEnabled
        ? (enabledTextColor ?? Colors.white)
        : (disabledTextColor ??
              context.color.primaryText.withValues(alpha: 0.5));
    final radius = borderRadius ?? 8.r;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          padding: padding ?? EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: backgroundColor,
              width: borderWidth ?? 1.5.w,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: mainAxisSize,
            children: [
              Icon(icon, color: foregroundColor, size: iconSize ?? 14.sp),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  !isEnabled && badgeText != null ? badgeText! : label,
                  style: TextStyle(
                    color: foregroundColor,
                    fontSize: fontSize ?? 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
