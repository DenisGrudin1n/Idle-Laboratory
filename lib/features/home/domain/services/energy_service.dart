import 'dart:async';

import 'package:idle_laboratory/core/constants/game_constants.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:rxdart/rxdart.dart';

/// Stream-based energy management service.
///
/// Provides reactive streams for energy and EPS (Energy Per Second).
/// All energy-related calculations flow through these streams.
class EnergyService {
  EnergyService() {
    // Start with initial values
    _energySubject.add(BigNumber.zero());
    _epsSubject.add(BigNumber.zero());
  }

  final BehaviorSubject<BigNumber> _energySubject =
      BehaviorSubject<BigNumber>();
  final BehaviorSubject<BigNumber> _epsSubject = BehaviorSubject<BigNumber>();

  Timer? _timer;

  /// Stream of current energy value.
  /// Emits only when energy changes (distinct values only).
  Stream<BigNumber> get energy$ => _energySubject.stream.distinct();

  /// Stream of energy per second value.
  /// Emits only when EPS changes (distinct values only).
  Stream<BigNumber> get eps$ => _epsSubject.stream.distinct();

  /// Current energy value (synchronous access)
  BigNumber get currentEnergy => _energySubject.value;

  /// Current EPS value (synchronous access)
  BigNumber get currentEPS => _epsSubject.value;

  /// Starts the passive energy generation timer.
  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: GameConstants.energyUpdateIntervalMs),
      (_) => _generateEnergy(),
    );
  }

  /// Generates energy based on current EPS
  void _generateEnergy() {
    final BigNumber increment = _epsSubject.value.multiplyByDouble(
      GameConstants.energyUpdateIntervalMs * 0.001,
    );

    final BigNumber newEnergy = _energySubject.value + increment;
    _energySubject.add(newEnergy);
  }

  /// Updates the energy per second rate.
  /// Called by CellsService when cells change.
  void updateEPS(BigNumber newEPS) {
    if (_epsSubject.value != newEPS) {
      _epsSubject.add(newEPS);
    }
  }

  /// Disposes of all streams and timers
  void dispose() {
    _timer?.cancel();
    _energySubject.close();
    _epsSubject.close();
  }
}
