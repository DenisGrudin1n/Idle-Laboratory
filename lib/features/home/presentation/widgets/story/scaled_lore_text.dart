import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

/// Picks the largest lore font that fits; scrolls only when still too tall.
class ScaledLoreText extends StatelessWidget {
  const ScaledLoreText({
    required this.text,
    this.centered = false,
    this.minSize = 11,
    this.maxSize = 16.5,
    super.key,
  });

  final String text;
  final bool centered;
  final double minSize;
  final double maxSize;

  @override
  Widget build(BuildContext context) {
    final baseColor = context.color.primaryText.withValues(alpha: 0.92);

    return LayoutBuilder(
      builder: (context, constraints) {
        var fontSize = minSize;
        var textHeight = double.infinity;

        for (var size = maxSize; size >= minSize; size -= 0.5) {
          final painter = TextPainter(
            text: TextSpan(
              text: text,
              style: TextStyle(fontSize: size, height: 1.45, color: baseColor),
            ),
            textAlign: centered ? TextAlign.center : TextAlign.start,
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: constraints.maxWidth);

          if (painter.height <= constraints.maxHeight) {
            fontSize = size;
            textHeight = painter.height;
            break;
          }

          if (size == minSize) {
            fontSize = minSize;
            textHeight = painter.height;
          }
        }

        final child = Text(
          text,
          style: TextStyle(fontSize: fontSize, height: 1.45, color: baseColor),
          textAlign: centered ? TextAlign.center : TextAlign.start,
        );

        final needsScroll = textHeight > constraints.maxHeight + 0.5;

        return Align(
          alignment: centered ? Alignment.center : Alignment.centerLeft,
          child: needsScroll ? SingleChildScrollView(child: child) : child,
        );
      },
    );
  }
}
