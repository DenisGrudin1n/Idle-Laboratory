import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/debug/widget_rebuild_profiler.dart';

void main() {
  test('WidgetRebuildProfiler records labels and clears on flush window', () {
    debugPrint = (message, {wrapWidth}) {};

    final profiler = WidgetRebuildProfiler.instance
      ..stop()
      ..start()
      ..record('alpha')
      ..record('alpha')
      ..record('beta');

    expect(profiler.snapshot['alpha'], 2);
    expect(profiler.snapshot['beta'], 1);

    profiler.stop();
    expect(profiler.snapshot, isEmpty);
  });
}
