import 'package:idle_laboratory/core/constants/play_time_units.dart';
import 'package:idle_laboratory/core/enums/play_time_scale.dart';
import 'package:idle_laboratory/core/extensions/play_time_scale_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

String _two(int value) => value.toString().padLeft(2, '0');

extension StatisticsFormattersExt on AppLocalizations {
  String statsDuration(int totalSeconds) => formatStatDuration(totalSeconds);

  String formatStatDuration(int totalSeconds) {
    final s = totalSeconds < 0 ? 0 : totalSeconds;
    return switch (PlayTimeScaleExt.forSeconds(s)) {
      PlayTimeScale.seconds || PlayTimeScale.minutes => durationStatMinutesSeconds(
        _two(s ~/ PlayTimeUnits.secondsPerMinute),
        _two(s % PlayTimeUnits.secondsPerMinute),
      ),
      PlayTimeScale.hours => durationStatHoursMinutes(
        _two(s ~/ PlayTimeUnits.secondsPerHour),
        _two((s % PlayTimeUnits.secondsPerHour) ~/ PlayTimeUnits.secondsPerMinute),
      ),
      PlayTimeScale.days => durationStatDaysHours(
        _two(s ~/ PlayTimeUnits.secondsPerDay),
        _two((s % PlayTimeUnits.secondsPerDay) ~/ PlayTimeUnits.secondsPerHour),
      ),
    };
  }

  String formatClockDuration(int totalSeconds) {
    final s = totalSeconds < 0 ? 0 : totalSeconds;
    return switch (PlayTimeScaleExt.forSeconds(s)) {
      PlayTimeScale.seconds || PlayTimeScale.minutes => durationClockMinutesSeconds(
        _two(s ~/ PlayTimeUnits.secondsPerMinute),
        _two(s % PlayTimeUnits.secondsPerMinute),
      ),
      PlayTimeScale.hours => durationClockHoursMinutes(
        _two(s ~/ PlayTimeUnits.secondsPerHour),
        _two((s % PlayTimeUnits.secondsPerHour) ~/ PlayTimeUnits.secondsPerMinute),
      ),
      PlayTimeScale.days => durationClockDaysHours(
        _two(s ~/ PlayTimeUnits.secondsPerDay),
        _two((s % PlayTimeUnits.secondsPerDay) ~/ PlayTimeUnits.secondsPerHour),
      ),
    };
  }

  String statsDate(int? epochMs) {
    if (epochMs == null) return valueUnavailable;
    return DateFormat.yMd(localeName).format(DateTime.fromMillisecondsSinceEpoch(epochMs));
  }

  String statsPercent(int part, int whole) {
    final ratio = whole <= 0 ? 0.0 : (part / whole).clamp(0.0, 1.0);
    final percent = ratio * 100;
    final digits = percent == percent.roundToDouble() ? 0 : 1;
    return NumberFormat.decimalPercentPattern(locale: localeName, decimalDigits: digits).format(ratio);
  }
}

extension StatisticsBigNumberExt on BigNumber {
  String statValue({required bool useScientific}) => format(compact: true, useScientific: useScientific);
}
