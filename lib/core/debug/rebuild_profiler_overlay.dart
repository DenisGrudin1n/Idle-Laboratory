import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/debug/widget_rebuild_profiler.dart';

/// Floating debug panel showing top rebuild offenders for the current second.
class RebuildProfilerOverlay extends StatefulWidget {
  const RebuildProfilerOverlay({required this.child, super.key});

  final Widget child;

  @override
  State<RebuildProfilerOverlay> createState() => _RebuildProfilerOverlayState();
}

class _RebuildProfilerOverlayState extends State<RebuildProfilerOverlay> {
  Timer? _refreshTimer;
  Map<String, int> _counts = const {};

  @override
  void initState() {
    super.initState();
    if (!kDebugMode) return;
    WidgetRebuildProfiler.instance.start();
    _refreshTimer = Timer.periodic(const Duration(milliseconds: 250), (_) {
      if (!mounted) return;
      setState(() => _counts = WidgetRebuildProfiler.instance.snapshot);
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    WidgetRebuildProfiler.instance.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return widget.child;

    final ranked = _counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final top = ranked.take(8).toList();

    return Stack(
      children: [
        widget.child,
        Positioned(
          left: 8,
          bottom: 8,
          child: IgnorePointer(
            child: Material(
              color: Colors.black.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: DefaultTextStyle(
                  style: const TextStyle(color: Colors.white70, fontSize: 10, fontFamily: 'monospace'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Rebuilds / sec', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      if (top.isEmpty) const Text('  (none yet)'),
                      for (final entry in top)
                        Text('${entry.value.toString().padLeft(4)}  ${entry.key}'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
