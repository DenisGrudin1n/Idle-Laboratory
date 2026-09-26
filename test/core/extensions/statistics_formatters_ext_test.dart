import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/constants/play_time_units.dart';
import 'package:idle_laboratory/core/enums/play_time_scale.dart';
import 'package:idle_laboratory/core/extensions/play_time_scale_ext.dart';
import 'package:idle_laboratory/core/extensions/statistics_formatters_ext.dart';

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

  group('StatisticsFormatters.duration', () {
    test('seconds and minutes and hours phases', () {
      expect(StatisticsFormatters.duration(0), '0s');
      expect(StatisticsFormatters.duration(42), '42s');
      expect(StatisticsFormatters.duration(60), '1m 0s');
      expect(StatisticsFormatters.duration(125), '2m 5s');
      expect(StatisticsFormatters.duration(3600), '1h');
      expect(StatisticsFormatters.duration(7200), '2h');
    });

    test('days compound', () {
      expect(StatisticsFormatters.duration(86400), '1d 0h 0m');
      expect(StatisticsFormatters.duration(90061), '1d 1h 1m');
    });

    test('months and years compound', () {
      expect(
        StatisticsFormatters.duration(PlayTimeUnits.secondsPerMonth + 86400),
        '1mo 1d 0h 0m',
      );
      expect(
        StatisticsFormatters.duration(PlayTimeUnits.secondsPerYear + PlayTimeUnits.secondsPerMonth),
        '1y 1mo 0d 0h 0m',
      );
    });
  });
}
