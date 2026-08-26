import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:idle_laboratory/core/debug/widget_rebuild_profiler.dart';

/// Increments [WidgetRebuildProfiler] for [label] on every build (debug only).
class DebugRebuildTracker extends StatelessWidget {
  const DebugRebuildTracker({required this.label, required this.child, super.key});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      WidgetRebuildProfiler.instance.record(label);
    }
    return child;
  }
}
