class GameException implements Exception {
  const GameException(this.message, [this.details, this.stackTrace]);

  final String message;
  final String? details;
  final StackTrace? stackTrace;

  @override
  String toString() => 'GameException: $message'
      '${details != null ? '\nDetails: $details' : ''}'
      '${stackTrace != null ? '\nStack trace:\n$stackTrace' : ''}';
}
