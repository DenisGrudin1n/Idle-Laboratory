import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/utils/app_scroll_behavior.dart';

/// Lore description — fixed size, scrolls when it does not fit.
class LoreBodyText extends StatefulWidget {
  const LoreBodyText({
    required this.text,
    this.fontSize = 14,
    this.centered = false,
    this.scrollbarOnRight = true,
    super.key,
  });

  final String text;
  final double fontSize;
  final bool centered;
  final bool scrollbarOnRight;

  @override
  State<LoreBodyText> createState() => _LoreBodyTextState();
}

class _LoreBodyTextState extends State<LoreBodyText> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.color.primaryText.withValues(alpha: 0.92);
    final sidePad = EdgeInsets.only(left: widget.scrollbarOnRight ? 0 : 14, right: widget.scrollbarOnRight ? 14 : 0);

    return ScrollConfiguration(
      behavior: const AppLoreScrollBehavior(),
      child: Scrollbar(
        controller: _controller,
        interactive: true,
        thumbVisibility: true,
        scrollbarOrientation: widget.scrollbarOnRight ? ScrollbarOrientation.right : ScrollbarOrientation.left,
        child: Padding(
          padding: sidePad,
          child: SingleChildScrollView(
            controller: _controller,
            child: Text(
              widget.text,
              style: TextStyle(fontSize: widget.fontSize, height: 1.45, color: color),
              textAlign: widget.centered ? TextAlign.center : TextAlign.start,
            ),
          ),
        ),
      ),
    );
  }
}
