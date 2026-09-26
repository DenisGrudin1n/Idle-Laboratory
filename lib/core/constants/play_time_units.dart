/// Fixed second lengths for play-time breakdown (not calendar months/years).
abstract final class PlayTimeUnits {
  static const secondsPerMinute = 60;
  static const secondsPerHour = 3600;
  static const secondsPerDay = 86400;
  static const secondsPerMonth = 2592000; // 30 days
  static const secondsPerYear = 31536000; // 365 days
}
