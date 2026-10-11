import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/utils/app_scroll_behavior.dart';

/// Shared app scrollbar — thin thumb, content inset so it does not overlay.
///
/// Pass the same [ScrollController] to the child scrollable.
class AppScrollbar extends StatelessWidget {
  const AppScrollbar({
    required this.controller,
    required this.child,
    this.thumbVisibility = true,
    this.interactive = true,
    this.scrollbarOrientation = ScrollbarOrientation.right,
    this.contentInset = contentInsetDefault,
    this.padContent = true,
    super.key,
  });

  /// Space reserved beside content for the thumb (not the thumb width itself).
  static const double contentInsetDefault = 14;

  final ScrollController controller;
  final Widget child;
  final bool thumbVisibility;
  final bool interactive;
  final ScrollbarOrientation scrollbarOrientation;
  final double contentInset;
  final bool padContent;

  @override
  Widget build(BuildContext context) {
    final paddedChild = padContent
        ? Padding(
            padding: EdgeInsets.only(
              left: scrollbarOrientation == ScrollbarOrientation.left ? contentInset : 0,
              right: scrollbarOrientation == ScrollbarOrientation.right ? contentInset : 0,
            ),
            child: child,
          )
        : child;

    return ScrollConfiguration(
      behavior: const AppLoreScrollBehavior(),
      child: Scrollbar(
        controller: controller,
        interactive: interactive,
        thumbVisibility: thumbVisibility,
        scrollbarOrientation: scrollbarOrientation,
        child: paddedChild,
      ),
    );
  }
}
