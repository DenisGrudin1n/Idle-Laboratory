import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/statistics/statistics_row.dart';

class StatisticsExpandableRow extends StatefulWidget {
  const StatisticsExpandableRow({
    required this.label,
    required this.value,
    required this.children,
    this.isMobile = true,
    this.initiallyExpanded = false,
    super.key,
  });

  final String label;
  final String value;
  final List<StatisticsRow> children;
  final bool isMobile;
  final bool initiallyExpanded;

  @override
  State<StatisticsExpandableRow> createState() => _StatisticsExpandableRowState();
}

class _StatisticsExpandableRowState extends State<StatisticsExpandableRow> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: widget.children.isEmpty ? null : () => setState(() => _expanded = !_expanded),
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: EdgeInsets.only(bottom: widget.isMobile ? 6 : 8),
            child: Row(
              children: [
                if (widget.children.isNotEmpty)
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 180),
                    child: Icon(
                      Icons.expand_more,
                      size: widget.isMobile ? 18 : 22,
                      color: color.primaryText,
                    ),
                  )
                else
                  SizedBox(width: widget.isMobile ? 18 : 22),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      color: color.primaryText,
                      fontSize: widget.isMobile ? 11 : 14,
                    ),
                  ),
                ),
                Text(
                  widget.value,
                  style: TextStyle(
                    color: color.primaryText,
                    fontSize: widget.isMobile ? 11 : 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_expanded)
          ...widget.children.map(
            (child) => StatisticsRow(
              label: child.label,
              value: child.value,
              isMobile: widget.isMobile,
              indent: true,
            ),
          ),
      ],
    );
  }
}
