import 'package:idle_laboratory/core/constants/play_time_units.dart';
import 'package:idle_laboratory/core/enums/play_time_scale.dart';

extension PlayTimeScaleExt on PlayTimeScale {
  Duration get tickInterval => switch (this) {
        // Seconds are visible in both seconds-only and minutes+seconds phases.
        PlayTimeScale.seconds || PlayTimeScale.minutes => const Duration(seconds: 1),
        PlayTimeScale.hours => const Duration(hours: 1),
        PlayTimeScale.days || PlayTimeScale.months || PlayTimeScale.years => const Duration(minutes: 1),
      };

  static PlayTimeScale forSeconds(int totalSeconds) {
    final s = totalSeconds < 0 ? 0 : totalSeconds;
    return switch (s) {
      < PlayTimeUnits.secondsPerMinute => PlayTimeScale.seconds,
      < PlayTimeUnits.secondsPerHour => PlayTimeScale.minutes,
      < PlayTimeUnits.secondsPerDay => PlayTimeScale.hours,
      < PlayTimeUnits.secondsPerMonth => PlayTimeScale.days,
      < PlayTimeUnits.secondsPerYear => PlayTimeScale.months,
      _ => PlayTimeScale.years,
    };
  }
}
