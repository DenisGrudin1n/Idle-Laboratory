import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/widgets/info_row.dart';

class StatisticsRow extends StatelessWidget {
  const StatisticsRow({
    required this.label,
    required this.value,
    this.isMobile = true,
    this.indent = false,
    super.key,
  });

  final String label;
  final String value;
  final bool isMobile;
  final bool indent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indent ? (isMobile ? 16 : 24) : 0, bottom: isMobile ? 6 : 8),
      child: InfoRow(
        label: label,
        value: value,
        labelFontSize: isMobile ? 11 : 14,
        valueFontSize: isMobile ? 11 : 14,
      ),
    );
  }
}
