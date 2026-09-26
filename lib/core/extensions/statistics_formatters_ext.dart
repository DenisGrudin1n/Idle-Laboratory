import 'package:idle_laboratory/core/constants/play_time_units.dart';
import 'package:idle_laboratory/core/enums/play_time_scale.dart';
import 'package:idle_laboratory/core/extensions/play_time_scale_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';

abstract final class StatisticsFormatters {
  /// Progressive play-time / duration display:
  /// - under 1m → `Xs`
  /// - under 1h → `Xm Ys`
  /// - under 1d → `Xh`
  /// - under 30d → `Xd Yh Zm`
  /// - under 365d → `Xmo Yd Zh Wm`
  /// - else → `Xy Xmo Yd Zh Wm`
  static String duration(int totalSeconds) {
    final s = totalSeconds < 0 ? 0 : totalSeconds;
    final scale = PlayTimeScaleExt.forSeconds(s);

    return switch (scale) {
      PlayTimeScale.seconds => '${s}s',
      PlayTimeScale.minutes =>
        '${s ~/ PlayTimeUnits.secondsPerMinute}m ${s % PlayTimeUnits.secondsPerMinute}s',
      PlayTimeScale.hours => '${s ~/ PlayTimeUnits.secondsPerHour}h',
      // days / months / years share compound formatting; [scale] selects which
      // larger units to include inside [_compoundDuration].
      _ => _compoundDuration(s, scale),
    };
  }

  static String _compoundDuration(int totalSeconds, PlayTimeScale scale) {
    var remaining = totalSeconds;
    final parts = <String>[];

    if (scale == PlayTimeScale.years) {
      final years = remaining ~/ PlayTimeUnits.secondsPerYear;
      remaining %= PlayTimeUnits.secondsPerYear;
      if (years > 0) parts.add('${years}y');
    }

    if (scale == PlayTimeScale.years || scale == PlayTimeScale.months) {
      final months = remaining ~/ PlayTimeUnits.secondsPerMonth;
      remaining %= PlayTimeUnits.secondsPerMonth;
      if (months > 0 || parts.isNotEmpty) parts.add('${months}mo');
    }

    final days = remaining ~/ PlayTimeUnits.secondsPerDay;
    remaining %= PlayTimeUnits.secondsPerDay;
    final hours = remaining ~/ PlayTimeUnits.secondsPerHour;
    remaining %= PlayTimeUnits.secondsPerHour;
    final minutes = remaining ~/ PlayTimeUnits.secondsPerMinute;

    parts
      ..add('${days}d')
      ..add('${hours}h')
      ..add('${minutes}m');

    return parts.join(' ');
  }

  static String bigNumber(BigNumber value, {required bool useScientific}) =>
      value.format(compact: true, useScientific: useScientific);

  static String dateFromEpochMs(int? epochMs) {
    if (epochMs == null) return '—';
    final date = DateTime.fromMillisecondsSinceEpoch(epochMs);
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  static int daysSince(int? epochMs) {
    if (epochMs == null) return 0;
    final first = DateTime.fromMillisecondsSinceEpoch(epochMs);
    return DateTime.now().difference(first).inDays;
  }

  static String percent(int part, int whole) {
    if (whole <= 0) return '0%';
    final value = (part * 100 / whole).clamp(0, 100);
    return '${value.toStringAsFixed(value == value.roundToDouble() ? 0 : 1)}%';
  }
}
