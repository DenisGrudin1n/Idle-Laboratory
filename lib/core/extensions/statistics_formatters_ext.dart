import 'package:idle_laboratory/core/utils/big_number.dart';

abstract final class StatisticsFormatters {
  static String duration(int totalSeconds) {
    if (totalSeconds < 60) return '${totalSeconds}s';
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    }
    return '${minutes}m ${seconds}s';
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
