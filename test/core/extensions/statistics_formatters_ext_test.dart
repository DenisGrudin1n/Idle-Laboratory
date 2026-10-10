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
      expect(PlayTimeScaleExt.forSeconds(PlayTimeUnits.secondsPerMonth), PlayTimeScale.months);
      expect(PlayTimeScaleExt.forSeconds(PlayTimeUnits.secondsPerYear), PlayTimeScale.years);
    });

    test('tick intervals match scale', () {
      expect(PlayTimeScale.seconds.tickInterval, const Duration(seconds: 1));
      expect(PlayTimeScale.minutes.tickInterval, const Duration(seconds: 1));
      expect(PlayTimeScale.hours.tickInterval, const Duration(hours: 1));
      expect(PlayTimeScale.days.tickInterval, const Duration(minutes: 1));
      expect(PlayTimeScale.months.tickInterval, const Duration(minutes: 1));
      expect(PlayTimeScale.years.tickInterval, const Duration(minutes: 1));
    });
  });

  group('StatisticsFormattersExt.statsDuration', () {
    final l10n = lookupAppLocalizations(const Locale('en'));

    test('seconds and minutes and hours phases', () {
      expect(l10n.statsDuration(0), '0s');
      expect(l10n.statsDuration(42), '42s');
      expect(l10n.statsDuration(60), '1m 0s');
      expect(l10n.statsDuration(125), '2m 5s');
      expect(l10n.statsDuration(3600), '1h');
      expect(l10n.statsDuration(7200), '2h');
    });

    test('days compound', () {
      expect(l10n.statsDuration(86400), '1d 0h 0m');
      expect(l10n.statsDuration(90061), '1d 1h 1m');
    });

    test('months and years compound', () {
      expect(l10n.statsDuration(PlayTimeUnits.secondsPerMonth + 86400), '1mo 1d 0h 0m');
      expect(
        l10n.statsDuration(PlayTimeUnits.secondsPerYear + PlayTimeUnits.secondsPerMonth),
        '1y 1mo 0d 0h 0m',
      );
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
