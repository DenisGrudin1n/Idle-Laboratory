import 'package:idle_laboratory/core/extensions/play_time_scale_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

extension StatisticsFormattersExt on AppLocalizations {
  String statsDuration(int totalSeconds) => formatStatDuration(totalSeconds);

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
