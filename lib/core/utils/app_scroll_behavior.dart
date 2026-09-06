import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const kAppScrollDragDevices = <PointerDeviceKind>{
  PointerDeviceKind.touch,
  PointerDeviceKind.stylus,
  PointerDeviceKind.invertedStylus,
  PointerDeviceKind.mouse,
  PointerDeviceKind.trackpad,
};

/// Mouse / trackpad drag scrolling (e.g. [PageView] on desktop).
class AppMouseDragScrollBehavior extends MaterialScrollBehavior {
  const AppMouseDragScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => kAppScrollDragDevices;
}

/// Lore body scroll — no theme scrollbar duplicate, mouse drag enabled.
class AppLoreScrollBehavior extends MaterialScrollBehavior {
  const AppLoreScrollBehavior();

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) => child;

  @override
  Set<PointerDeviceKind> get dragDevices => kAppScrollDragDevices;
}
