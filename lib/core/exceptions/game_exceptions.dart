class GameException implements Exception {
  const GameException(this.message, [this.details, this.stackTrace]);

  final String message;
  final String? details;
  final StackTrace? stackTrace;

  @override
  String toString() {
    final buffer = StringBuffer('GameException: $message');
    if (details != null) {
      buffer.write('\nDetails: $details');
    }
    if (stackTrace != null) {
      buffer.write('\nStack trace:\n$stackTrace');
    }
    return buffer.toString();
  }
}
