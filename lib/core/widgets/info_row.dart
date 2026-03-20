import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

/// A reusable widget that displays a label-value pair in a row.
///
/// Used across the app for displaying information in a consistent format,
/// such as energy values, requirements, statistics, etc.
///
/// Example:
/// ```dart
/// InfoRow(
///   label: 'Total Energy',
///   value: '1.5K',
///   valueColor: Colors.green,
/// )
/// ```
class InfoRow extends StatelessWidget {
  const InfoRow({
    required this.label,
    required this.value,
    this.labelColor,
    this.valueColor,
    this.labelFontSize,
    this.valueFontSize,
    this.valueFontWeight,
    this.spacing,
    super.key,
  });

  /// The label text displayed on the left
  final String label;

  /// The value text displayed on the right
  final String value;

  /// Color for the label text. Defaults to theme's primaryText color
  final Color? labelColor;

  /// Color for the value text. Defaults to theme's primaryText color
  final Color? valueColor;

  /// Font size for the label. Defaults to 10.sp
  final double? labelFontSize;

  /// Font size for the value. Defaults to 11.sp
  final double? valueFontSize;

  /// Font weight for the value. Defaults to FontWeight.w600
  final FontWeight? valueFontWeight;

  /// Vertical spacing. If null, no spacing is added
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    final Widget row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: labelColor ?? context.color.primaryText,
            fontSize: labelFontSize ?? 10.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? context.color.primaryText,
            fontSize: valueFontSize ?? 11.sp,
            fontWeight: valueFontWeight ?? FontWeight.w600,
          ),
        ),
      ],
    );

    if (spacing != null) {
      return Column(
        children: <Widget>[
          row,
          SizedBox(height: spacing),
        ],
      );
    }

    return row;
  }
}
