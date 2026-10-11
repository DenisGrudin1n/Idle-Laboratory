import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/constants/play_time_units.dart';
import 'package:idle_laboratory/core/enums/play_time_scale.dart';
import 'package:idle_laboratory/core/extensions/play_time_scale_ext.dart';
import 'package:idle_laboratory/core/extensions/statistics_formatters_ext.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  group('PlayTimeScaleExt.forSeconds', () {
    test('maps thresholds', () {
      expect(PlayTimeScaleExt.forSeconds(0), PlayTimeScale.seconds);
      expect(PlayTimeScaleExt.forSeconds(59), PlayTimeScale.seconds);
      expect(PlayTimeScaleExt.forSeconds(60), PlayTimeScale.minutes);
      expect(PlayTimeScaleExt.forSeconds(3599), PlayTimeScale.minutes);
      expect(PlayTimeScaleExt.forSeconds(3600), PlayTimeScale.hours);
      expect(PlayTimeScaleExt.forSeconds(86399), PlayTimeScale.hours);
      expect(PlayTimeScaleExt.forSeconds(86400), PlayTimeScale.days);
      expect(PlayTimeScaleExt.forSeconds(40 * PlayTimeUnits.secondsPerDay), PlayTimeScale.days);
    });

    test('tick intervals follow the smaller displayed unit', () {
      expect(PlayTimeScale.seconds.tickInterval, const Duration(seconds: 1));
      expect(PlayTimeScale.minutes.tickInterval, const Duration(seconds: 1));
      expect(PlayTimeScale.hours.tickInterval, const Duration(minutes: 1));
      expect(PlayTimeScale.days.tickInterval, const Duration(hours: 1));
    });

    test('tickFor keeps a short session moving when lifetime play is already coarse', () {
      expect(
        PlayTimeScaleExt.tickFor(totalPlayTimeSeconds: 2 * PlayTimeUnits.secondsPerDay, sessionSeconds: 30),
        const Duration(seconds: 1),
      );
      expect(
        PlayTimeScaleExt.tickFor(totalPlayTimeSeconds: 3 * PlayTimeUnits.secondsPerDay, sessionSeconds: 5 * 3600),
        const Duration(minutes: 1),
      );
      expect(
        PlayTimeScaleExt.tickFor(totalPlayTimeSeconds: 2 * 3600, sessionSeconds: 2 * 3600),
        const Duration(minutes: 1),
      );
      expect(
        PlayTimeScaleExt.tickFor(
          totalPlayTimeSeconds: 3 * PlayTimeUnits.secondsPerDay,
          sessionSeconds: 2 * PlayTimeUnits.secondsPerDay,
        ),
        const Duration(hours: 1),
      );
    });
  });

  group('formatClockDuration', () {
    test('mm:ss, then hh:mm, then dd:hh', () {
      expect(formatClockDuration(-5), '00:00');
      expect(formatClockDuration(0), '00:00');
      expect(formatClockDuration(5), '00:05');
      expect(formatClockDuration(42), '00:42');
      expect(formatClockDuration(60), '01:00');
      expect(formatClockDuration(90), '01:30');
      expect(formatClockDuration(125), '02:05');
      expect(formatClockDuration(3599), '59:59');

      expect(formatClockDuration(3600), '01h 00m');
      expect(formatClockDuration(3660), '01h 01m');
      expect(formatClockDuration(2 * 3600 + 15 * 60), '02h 15m');
      expect(formatClockDuration(3 * 3600), '03h 00m');
      expect(formatClockDuration(86399), '23h 59m');

      expect(formatClockDuration(86400), '01d 00h');
      expect(formatClockDuration(86400 + 3 * 3600), '01d 03h');
      expect(formatClockDuration(2 * 86400 + 4 * 3600), '02d 04h');
      expect(formatClockDuration(100 * 86400 + 4 * 3600), '100d 04h');
    });
  });

  group('StatisticsFormattersExt.statsDuration', () {
    final l10n = lookupAppLocalizations(const Locale('en'));

    test('uses m/s, h/m, and d/h', () {
      expect(l10n.statsDuration(0), '00m 00s');
      expect(l10n.statsDuration(5), '00m 05s');
      expect(l10n.statsDuration(125), '02m 05s');
      expect(l10n.statsDuration(25 * 60 + 12), '25m 12s');
      expect(l10n.statsDuration(12 * 3600 + 8 * 60), '12h 08m');
      expect(l10n.statsDuration(3600 + 4 * 60), '01h 04m');
      expect(l10n.statsDuration(2 * 86400 + 4 * 3600), '02d 04h');
    });
  });

  group('StatisticsFormattersExt date and percent', () {
    final l10n = lookupAppLocalizations(const Locale('en'));

    setUpAll(() => initializeDateFormatting('en'));

    test('statsDate uses locale format and placeholder for missing value', () {
      expect(l10n.statsDate(null), l10n.statsValueUnavailable);
      expect(l10n.statsDate(DateTime(2026, 10, 9).millisecondsSinceEpoch), '10/9/2026');
    });

    test('statsPercent clamps and keeps one decimal for fractions', () {
      expect(l10n.statsPercent(0, 0), '0%');
      expect(l10n.statsPercent(1, 2), '50%');
      expect(l10n.statsPercent(1, 3), '33.3%');
      expect(l10n.statsPercent(5, 2), '100%');
    });
  });
}
