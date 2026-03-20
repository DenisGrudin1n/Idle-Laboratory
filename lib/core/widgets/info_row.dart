import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

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

  final String label;
  final String value;
  final Color? labelColor;
  final Color? valueColor;
  final double? labelFontSize;
  final double? valueFontSize;
  final double? spacing;
  final FontWeight? valueFontWeight;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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

    return spacing != null
        ? Column(
            children: [
              row,
              SizedBox(height: spacing),
            ],
          )
        : row;
  }
}
