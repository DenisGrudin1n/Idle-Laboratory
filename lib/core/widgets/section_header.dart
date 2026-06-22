import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.icon,
    this.description,
    this.trailing,
    this.iconColor,
    this.iconBackgroundColor,
    this.titleColor,
    this.descriptionColor,
    this.titleFontSize,
    this.descriptionFontSize,
    this.iconSize,
    this.spacing,
    super.key,
  });

  final String title;
  final IconData? icon;
  final String? description;
  final Widget? trailing;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? titleColor;
  final Color? descriptionColor;
  final double? titleFontSize;
  final double? descriptionFontSize;
  final double? iconSize;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    final effectiveSpacing = spacing ?? 8.0;
    return Row(
      children: [
        if (icon != null) ...[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBackgroundColor ?? context.color.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor ?? context.color.primary,
              size: iconSize ?? 16,
            ),
          ),
          SizedBox(width: effectiveSpacing),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: titleColor ?? context.color.titleText,
                  fontSize: titleFontSize ?? 14,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (description != null) ...[
                const SizedBox(height: 1),
                Text(
                  description!,
                  style: TextStyle(
                    color: descriptionColor ?? context.color.primaryText.withValues(alpha: 0.7),
                    fontSize: descriptionFontSize ?? 9,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[SizedBox(width: effectiveSpacing), trailing!],
      ],
    );
  }
}
