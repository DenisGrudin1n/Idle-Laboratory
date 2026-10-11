import 'package:idle_laboratory/core/constants/play_time_units.dart';
import 'package:idle_laboratory/core/enums/play_time_scale.dart';

extension PlayTimeScaleExt on PlayTimeScale {
  Duration get tickInterval => switch (this) {
    PlayTimeScale.seconds || PlayTimeScale.minutes => const Duration(seconds: 1),
    PlayTimeScale.hours => const Duration(minutes: 1),
    PlayTimeScale.days => const Duration(hours: 1),
  };

  static PlayTimeScale forSeconds(int totalSeconds) {
    final s = totalSeconds < 0 ? 0 : totalSeconds;
    return switch (s) {
      < PlayTimeUnits.secondsPerMinute => PlayTimeScale.seconds,
      < PlayTimeUnits.secondsPerHour => PlayTimeScale.minutes,
      < PlayTimeUnits.secondsPerDay => PlayTimeScale.hours,
      _ => PlayTimeScale.days,
    };
  }

  static Duration tickFor({required int totalPlayTimeSeconds, required int sessionSeconds}) {
    final totalTick = forSeconds(totalPlayTimeSeconds).tickInterval;
    final sessionTick = forSeconds(sessionSeconds).tickInterval;
    return sessionTick < totalTick ? sessionTick : totalTick;
  }
}
