import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({
    required this.title,
    required this.children,
    this.isMobile = true,
    super.key,
  });

  final String title;
  final List<Widget> children;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: context.styles.sectionTitle.copyWith(fontSize: isMobile ? 14 : 18),
        ),
        SizedBox(height: isMobile ? 8 : 12),
        ...children,
      ],
    );
  }
}
