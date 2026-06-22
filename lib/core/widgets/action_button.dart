import 'package:flutter/material.dart';
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
    final backgroundColor =
        isEnabled ? (enabledColor ?? context.color.primary) : (disabledColor ?? context.color.primaryText.withValues(alpha: 0.3));
    final foregroundColor = isEnabled
        ? (enabledTextColor ?? Colors.white)
        : (disabledTextColor ?? context.color.primaryText.withValues(alpha: 0.5));
    final radius = borderRadius ?? 8.0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          padding: padding ?? const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: backgroundColor,
              width: borderWidth ?? 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: foregroundColor, size: iconSize ?? 14),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  !isEnabled && badgeText != null ? badgeText! : label,
                  style: TextStyle(
                    color: foregroundColor,
                    fontSize: fontSize ?? 10,
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
