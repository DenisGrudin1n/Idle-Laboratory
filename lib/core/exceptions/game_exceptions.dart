import 'dart:async';

class GameException implements Exception {
  const GameException([this.details, this.stackTrace]);

  final String? details;
  final StackTrace? stackTrace;

  @override
  String toString() => 'GameException'
      '${details != null ? ': $details' : ''}'
      '${stackTrace != null ? '\nStack trace:\n$stackTrace' : ''}';
}

/// Helper for wrapping async repository or service calls with GameException
Future<T> guardAsync<T>(FutureOr<T> Function() call) async {
  try {
    return await call();
  } catch (error, stackTrace) {
    throw GameException(error.toString(), stackTrace);
  }
}
