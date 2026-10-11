import 'dart:async';
import 'dart:developer' as developer;

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

/// Runs a persistence future without awaiting it; failures are logged instead
/// of escaping to the root zone as unhandled async errors.
/// [label] comes from `PersistenceLabels`.
void fireAndForget(Future<void> future, {required String label}) {
  unawaited(
    future.catchError((Object error, StackTrace stackTrace) {
      developer.log('$label failed', name: 'idle_laboratory', error: error, stackTrace: stackTrace);
    }),
  );
}
