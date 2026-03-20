import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

/// A reusable section header widget with an icon, title, and optional description.
///
/// Used to create consistent section headers across the app with an icon,
/// title, optional description, and optional trailing widget.
///
/// Example:
/// ```dart
/// SectionHeader(
///   icon: Icons.auto_awesome,
///   title: 'Prestige',
///   description: 'Reset for permanent bonuses',
/// )
/// ```
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

  /// The main title text
  final String title;

  /// Optional icon to display before the title
  final IconData? icon;

  /// Optional description text below the title
  final String? description;

  /// Optional widget to display at the end (e.g., info button)
  final Widget? trailing;

  /// Color for the icon. Defaults to theme's primary color
  final Color? iconColor;

  /// Background color for the icon container. Defaults to primary with 0.2 opacity
  final Color? iconBackgroundColor;

  /// Color for the title text. Defaults to theme's titleText color
  final Color? titleColor;

  /// Color for the description text. Defaults to primaryText with 0.7 opacity
  final Color? descriptionColor;

  /// Font size for the title. Defaults to 14.sp
  final double? titleFontSize;

  /// Font size for the description. Defaults to 9.sp
  final double? descriptionFontSize;

  /// Size of the icon. Defaults to 16.sp
  final double? iconSize;

  /// Spacing between icon and content. Defaults to 8.w
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (icon != null) ...<Widget>[
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color:
                  iconBackgroundColor ??
                  context.color.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: iconColor ?? context.color.primary,
              size: iconSize ?? 16.sp,
            ),
          ),
          SizedBox(width: spacing ?? 8.w),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: titleColor ?? context.color.titleText,
                  fontSize: titleFontSize ?? 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (description != null) ...<Widget>[
                SizedBox(height: 1.h),
                Text(
                  description!,
                  style: TextStyle(
                    color:
                        descriptionColor ??
                        context.color.primaryText.withValues(alpha: 0.7),
                    fontSize: descriptionFontSize ?? 9.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...<Widget>[
          SizedBox(width: spacing ?? 8.w),
          trailing!,
        ],
      ],
    );
  }
}
