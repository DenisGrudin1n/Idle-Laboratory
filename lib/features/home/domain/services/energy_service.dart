import 'dart:async';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/constants/game_constants.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/repositories/energy_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class EnergyService {
  EnergyService(this._energyRepository) {
    _initialize();
  }

  final EnergyRepository _energyRepository;
  final BehaviorSubject<BigNumber> _energySubject = BehaviorSubject<BigNumber>();
  final BehaviorSubject<BigNumber> _epsSubject = BehaviorSubject<BigNumber>();
  Timer? _timer;
  Timer? _saveTimer;

  Stream<BigNumber> get energy$ => _energySubject.stream.distinct();
  Stream<BigNumber> get eps$ => _epsSubject.stream.distinct();
  BigNumber get currentEnergy => _energySubject.value;
  BigNumber get currentEPS => _epsSubject.value;

  void _initialize() {
    _energySubject.add(BigNumber.zero());
    _epsSubject.add(BigNumber.zero());
    _loadEnergy();
  }

  Future<void> _loadEnergy() async {
    final savedEnergy = await _energyRepository.getTotalEnergy();
    if (savedEnergy != null) _energySubject.add(savedEnergy);
  }

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: GameConstants.energyUpdateIntervalMs),
      (_) => _generateEnergy(),
    );

    _saveTimer?.cancel();
    _saveTimer = Timer.periodic(
      const Duration(milliseconds: GameBalance.energyAutoSaveDurationMs),
      (_) => saveEnergy(),
    );
  }

  void _generateEnergy() {
    final increment = _epsSubject.value.multiplyByDouble(GameConstants.energyUpdateIntervalMs * 0.001);
    _energySubject.add(_energySubject.value + increment);
  }

  Future<void> saveEnergy() async => _energyRepository.saveTotalEnergy(currentEnergy);

  void updateEPS(BigNumber newEPS) {
    if (_epsSubject.value != newEPS) {
      _epsSubject.add(newEPS);
      // Immediately trigger energy generation update to avoid 100ms lag
      if (_timer == null) start();
    }
  }

  /// Returns false if current energy is less than [amount].
  bool trySpendEnergy(BigNumber amount) {
    if (_energySubject.value < amount) return false;
    _energySubject.add(_energySubject.value - amount);
    return true;
  }

  void reset() {
    _energySubject.add(BigNumber.zero());
    _epsSubject.add(BigNumber.zero());
    saveEnergy();
    start();
  }

  @disposeMethod
  void dispose() {
    _timer?.cancel();
    _saveTimer?.cancel();
    saveEnergy();
    _energySubject.close();
    _epsSubject.close();
  }
}
