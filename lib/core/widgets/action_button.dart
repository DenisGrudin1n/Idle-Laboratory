import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

/// A reusable action button with icon, label, and customizable states.
///
/// Supports enabled/disabled states, custom colors, optional badge text,
/// and flexible styling. Used for prestige buttons, cell unlock buttons, etc.
///
/// Example:
/// ```dart
/// ActionButton(
///   icon: Icons.auto_awesome,
///   label: 'Prestige',
///   onTap: () => performPrestige(),
///   isEnabled: true,
/// )
/// ```
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

  /// Icon to display in the button
  final IconData icon;

  /// Label text for the button
  final String label;

  /// Callback when button is tapped (null if disabled)
  final VoidCallback? onTap;

  /// Whether the button is enabled. Defaults to true
  final bool isEnabled;

  /// Background color when enabled. Defaults to theme's primary color
  final Color? enabledColor;

  /// Background color when disabled. Defaults to primaryText with 0.3 opacity
  final Color? disabledColor;

  /// Text/icon color when enabled. Defaults to white
  final Color? enabledTextColor;

  /// Text/icon color when disabled. Defaults to primaryText with 0.5 opacity
  final Color? disabledTextColor;

  /// Size of the icon. Defaults to 14.sp
  final double? iconSize;

  /// Font size of the label. Defaults to 10.sp
  final double? fontSize;

  /// Padding inside the button. Defaults to 4.w
  final EdgeInsetsGeometry? padding;

  /// Border radius. Defaults to 8.r
  final double? borderRadius;

  /// Border width. Defaults to 1.5.w
  final double? borderWidth;

  /// Optional badge text to display instead of default label when disabled
  final String? badgeText;

  /// Main axis size of the row. Defaults to MainAxisSize.min
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = isEnabled
        ? (enabledColor ?? context.color.primary)
        : (disabledColor ?? context.color.primaryText.withValues(alpha: 0.3));

    final Color foregroundColor = isEnabled
        ? (enabledTextColor ?? Colors.white)
        : (disabledTextColor ??
              context.color.primaryText.withValues(alpha: 0.5));

    final double radius = borderRadius ?? 8.r;

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
            children: <Widget>[
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
