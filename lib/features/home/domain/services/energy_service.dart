import 'dart:async';
import 'package:idle_laboratory/core/constants/game_constants.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class EnergyService {
  EnergyService() {
    _energySubject.add(BigNumber.zero());
    _epsSubject.add(BigNumber.zero());
  }

  final BehaviorSubject<BigNumber> _energySubject = BehaviorSubject<BigNumber>();
  final BehaviorSubject<BigNumber> _epsSubject = BehaviorSubject<BigNumber>();

  Timer? _timer;

  Stream<BigNumber> get energy$ => _energySubject.stream.distinct();
  Stream<BigNumber> get eps$ => _epsSubject.stream.distinct();

  BigNumber get currentEnergy => _energySubject.value;
  BigNumber get currentEPS => _epsSubject.value;

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: GameConstants.energyUpdateIntervalMs),
      (_) => _generateEnergy(),
    );
  }

  void _generateEnergy() {
    final increment = _epsSubject.value.multiplyByDouble(
      GameConstants.energyUpdateIntervalMs * 0.001,
    );
    _energySubject.add(_energySubject.value + increment);
  }

  void updateEPS(BigNumber newEPS) {
    if (_epsSubject.value != newEPS) {
      _epsSubject.add(newEPS);
    }
  }

  void reset() {
    _energySubject.add(BigNumber.zero());
    _epsSubject.add(BigNumber.zero());
  }

  @disposeMethod
  void dispose() {
    _timer?.cancel();
    _energySubject.close();
    _epsSubject.close();
  }
}
