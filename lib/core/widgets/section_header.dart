import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final s = spacing ?? 8.w;
    return Row(
      children: [
        if (icon != null) ...[
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
          SizedBox(width: s),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: titleColor ?? context.color.titleText,
                  fontSize: titleFontSize ?? 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (description != null) ...[
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
        if (trailing != null) ...[SizedBox(width: s), trailing!],
      ],
    );
  }
}
