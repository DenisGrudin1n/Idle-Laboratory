import 'package:idle_laboratory/core/constants/play_time_units.dart';
import 'package:idle_laboratory/core/enums/play_time_scale.dart';
import 'package:idle_laboratory/core/extensions/play_time_scale_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

extension StatisticsFormattersExt on AppLocalizations {
  /// Progressive play-time / duration display:
  /// - under 1m → `Xs`
  /// - under 1h → `Xm Ys`
  /// - under 1d → `Xh`
  /// - under 30d → `Xd Yh Zm`
  /// - under 365d → `Xmo Yd Zh Wm`
  /// - else → `Xy Xmo Yd Zh Wm`
  String statsDuration(int totalSeconds) {
    final s = totalSeconds < 0 ? 0 : totalSeconds;
    final scale = PlayTimeScaleExt.forSeconds(s);

    return switch (scale) {
      PlayTimeScale.seconds => statsDurationSeconds(s),
      PlayTimeScale.minutes =>
        '${statsDurationMinutes(s ~/ PlayTimeUnits.secondsPerMinute)} '
            '${statsDurationSeconds(s % PlayTimeUnits.secondsPerMinute)}',
      PlayTimeScale.hours => statsDurationHours(s ~/ PlayTimeUnits.secondsPerHour),
      // days / months / years share compound formatting; [scale] selects which
      // larger units to include inside [_compoundDuration].
      _ => _compoundDuration(s, scale),
    };
  }

  String _compoundDuration(int totalSeconds, PlayTimeScale scale) {
    var remaining = totalSeconds;
    final parts = <String>[];

    if (scale == PlayTimeScale.years) {
      final years = remaining ~/ PlayTimeUnits.secondsPerYear;
      remaining %= PlayTimeUnits.secondsPerYear;
      if (years > 0) parts.add(statsDurationYears(years));
    }

    if (scale == PlayTimeScale.years || scale == PlayTimeScale.months) {
      final months = remaining ~/ PlayTimeUnits.secondsPerMonth;
      remaining %= PlayTimeUnits.secondsPerMonth;
      if (months > 0 || parts.isNotEmpty) parts.add(statsDurationMonths(months));
    }

    final days = remaining ~/ PlayTimeUnits.secondsPerDay;
    remaining %= PlayTimeUnits.secondsPerDay;
    final hours = remaining ~/ PlayTimeUnits.secondsPerHour;
    remaining %= PlayTimeUnits.secondsPerHour;
    final minutes = remaining ~/ PlayTimeUnits.secondsPerMinute;

    parts
      ..add(statsDurationDays(days))
      ..add(statsDurationHours(hours))
      ..add(statsDurationMinutes(minutes));

    return parts.join(' ');
  }

  String statsDate(int? epochMs) {
    if (epochMs == null) return statsValueUnavailable;
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

extension StatisticsEpochExt on int {
  int get daysSinceEpochMs => DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(this)).inDays;
}
