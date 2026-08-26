import 'dart:async';

import 'package:flutter/foundation.dart';

/// Counts widget builds by label and prints a ranked summary every [reportInterval].
///
/// Wrap widgets with [DebugRebuildTracker] in debug builds, then scroll or interact
/// and read the console output to see which parts rebuild most.
class WidgetRebuildProfiler {
  WidgetRebuildProfiler._();

  static final WidgetRebuildProfiler instance = WidgetRebuildProfiler._();

  static const Duration reportInterval = Duration(seconds: 1);

  final Map<String, int> _counts = {};
  Timer? _timer;
  bool _enabled = false;

  bool get enabled => _enabled && kDebugMode;

  /// Starts periodic reporting. Safe to call multiple times.
  void start() {
    if (!kDebugMode || _enabled) return;
    _enabled = true;
    _timer?.cancel();
    _timer = Timer.periodic(reportInterval, (_) => _flush());
    debugPrint('[RebuildProfiler] started — reporting every ${reportInterval.inSeconds}s');
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _enabled = false;
    _counts.clear();
  }

  void record(String label) {
    if (!enabled) return;
    _counts[label] = (_counts[label] ?? 0) + 1;
  }

  /// Latest per-label counts for the current reporting window (debug overlay).
  Map<String, int> get snapshot => Map.unmodifiable(_counts);

  void _flush() {
    if (_counts.isEmpty) return;

    final ranked = _counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final buffer = StringBuffer('[RebuildProfiler] last ${reportInterval.inSeconds}s\n');
    for (final entry in ranked.take(20)) {
      buffer.writeln('  ${entry.value.toString().padLeft(5)}  ${entry.key}');
    }
    debugPrint(buffer.toString());
    _counts.clear();
  }
}
