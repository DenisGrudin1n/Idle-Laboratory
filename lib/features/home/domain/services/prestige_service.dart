import 'dart:async';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/exceptions/game_exceptions.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/repositories/prestige_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/prestige_state_model/prestige_state_model.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class PrestigeService {
  PrestigeService(this._energyService, this._prestigeRepository) {
    _initializeState();
  }

  final EnergyService _energyService;
  final PrestigeRepository _prestigeRepository;
  final BehaviorSubject<PrestigeStateModel> _prestigeStateSubject = BehaviorSubject<PrestigeStateModel>.seeded(
    PrestigeStateModel.initial(),
  );
  StreamSubscription<BigNumber>? _energySubscription;

  Stream<PrestigeStateModel> get prestigeState$ => _prestigeStateSubject.stream;
  PrestigeStateModel get currentState => _prestigeStateSubject.value;

  void _initializeState() => _loadState()
      .then(_prestigeStateSubject.add)
      .catchError((_) => _prestigeStateSubject.add(PrestigeStateModel.initial()));

  void start() {
    _energySubscription?.cancel();
    _energySubscription = _energyService.energy$.listen(_onEnergyChanged);
  }

  void _onEnergyChanged(BigNumber totalEnergy) {
    final state = currentState;
    final newMultiplier = GameBalance.calculatePrestigeMultiplier(totalEnergy, state.currentThreshold);
    final newIsUnlocked = newMultiplier >= GameBalance.prestigeMinimumGain;

    if (newMultiplier != state.currentMultiplier || newIsUnlocked != state.isUnlocked) {
      _prestigeStateSubject.add(state.copyWith(currentMultiplier: newMultiplier, isUnlocked: newIsUnlocked));
    }
  }

  Future<void> performPrestige() async {
    if (!currentState.isUnlocked) return;
    final currentEnergy = _energyService.currentEnergy;
    final oldState = currentState;
    final newState = oldState.copyWith(
      totalMultiplier: oldState.totalMultiplier + oldState.currentMultiplier,
      currentThreshold: currentEnergy,
      currentMultiplier: BigNumber.zero(),
      isUnlocked: false,
      prestigeCount: oldState.prestigeCount + 1,
    );
    _prestigeStateSubject.add(newState);
    await saveState(newState);
    _energyService.reset();
  }

  BigNumber getEffectiveMultiplier() => currentState.totalMultiplier;

  Future<PrestigeStateModel> _loadState() async {
    final results = await Future.wait([
      _prestigeRepository.getTotalMultiplier(),
      _prestigeRepository.getCurrentThreshold(),
      _prestigeRepository.getPrestigeCount(),
    ]);

    final totalMultiplier = results[0] as BigNumber?;
    final threshold = results[1] as BigNumber?;
    final count = results[2] as int?;

    return totalMultiplier != null && threshold != null && count != null
        ? PrestigeStateModel(
            totalMultiplier: totalMultiplier,
            currentThreshold: threshold,
            currentMultiplier: BigNumber.zero(),
            isUnlocked: false,
            prestigeCount: count,
          )
        : PrestigeStateModel.initial();
  }

  Future<void> saveState([PrestigeStateModel? state]) => guardAsync(() async {
    final s = state ?? currentState;
    await _prestigeRepository.saveTotalMultiplier(s.totalMultiplier);
    await _prestigeRepository.saveCurrentThreshold(s.currentThreshold);
    await _prestigeRepository.savePrestigeCount(s.prestigeCount);
  });

  Future<void> reset() => guardAsync(() async {
    final initialState = PrestigeStateModel.initial();
    _prestigeStateSubject.add(initialState);
    await saveState(initialState);
  });

  @disposeMethod
  void dispose() {
    _energySubscription?.cancel();
    _prestigeStateSubject.close();
  }
}
