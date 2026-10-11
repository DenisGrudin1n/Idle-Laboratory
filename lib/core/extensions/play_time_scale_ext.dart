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

String _two(int value) => value.toString().padLeft(2, '0');

String formatStatDuration(int totalSeconds) {
  final s = totalSeconds < 0 ? 0 : totalSeconds;
  return switch (PlayTimeScaleExt.forSeconds(s)) {
    PlayTimeScale.seconds || PlayTimeScale.minutes =>
      '${_two(s ~/ PlayTimeUnits.secondsPerMinute)}m ${_two(s % PlayTimeUnits.secondsPerMinute)}s',
    PlayTimeScale.hours =>
      '${_two(s ~/ PlayTimeUnits.secondsPerHour)}h ${_two((s % PlayTimeUnits.secondsPerHour) ~/ PlayTimeUnits.secondsPerMinute)}m',
    PlayTimeScale.days =>
      '${_two(s ~/ PlayTimeUnits.secondsPerDay)}d ${_two((s % PlayTimeUnits.secondsPerDay) ~/ PlayTimeUnits.secondsPerHour)}h',
  };
}

String formatClockDuration(int totalSeconds) {
  final s = totalSeconds < 0 ? 0 : totalSeconds;
  return switch (PlayTimeScaleExt.forSeconds(s)) {
    PlayTimeScale.seconds ||
    PlayTimeScale.minutes => '${_two(s ~/ PlayTimeUnits.secondsPerMinute)}:${_two(s % PlayTimeUnits.secondsPerMinute)}',
    PlayTimeScale.hours =>
      '${_two(s ~/ PlayTimeUnits.secondsPerHour)}h ${_two((s % PlayTimeUnits.secondsPerHour) ~/ PlayTimeUnits.secondsPerMinute)}m',
    PlayTimeScale.days =>
      '${_two(s ~/ PlayTimeUnits.secondsPerDay)}d ${_two((s % PlayTimeUnits.secondsPerDay) ~/ PlayTimeUnits.secondsPerHour)}h',
  };
}
