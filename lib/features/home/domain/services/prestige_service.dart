import 'dart:async';
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
  final BehaviorSubject<PrestigeStateModel> _prestigeStateSubject = BehaviorSubject<PrestigeStateModel>.seeded(PrestigeStateModel.initial());
  StreamSubscription<BigNumber>? _energySubscription;

  Stream<PrestigeStateModel> get prestigeState$ => _prestigeStateSubject.stream;
  PrestigeStateModel get currentState => _prestigeStateSubject.value;

  void _initializeState() => _loadState().then(_prestigeStateSubject.add).catchError((_) => _prestigeStateSubject.add(PrestigeStateModel.initial()));

  void start() {
    _energySubscription?.cancel();
    _energySubscription = _energyService.energy$.listen(_onEnergyChanged);
  }

  void _onEnergyChanged(BigNumber totalEnergy) {
    final state = currentState;
    final newMultiplier = _calculateMultiplier(totalEnergy, state.currentThreshold);
    final newIsUnlocked = newMultiplier >= BigNumber(1, 0);

    if (newMultiplier != state.currentMultiplier || newIsUnlocked != state.isUnlocked)
      _prestigeStateSubject.add(state.copyWith(currentMultiplier: newMultiplier, isUnlocked: newIsUnlocked));
  }

  BigNumber _calculateMultiplier(BigNumber energy, BigNumber threshold) =>
      threshold <= BigNumber.zero() ? BigNumber.zero() : BigNumber.fromDouble(energy.ratio(threshold));

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
    await _saveState(newState);
  }

  BigNumber getEffectiveMultiplier() => currentState.totalMultiplier;

  Future<PrestigeStateModel> _loadState() async {
    final totalMultiplier = await _prestigeRepository.getTotalMultiplier();
    final threshold = await _prestigeRepository.getCurrentThreshold();
    final count = await _prestigeRepository.getPrestigeCount();
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

  Future<void> _saveState(PrestigeStateModel state) async {
    try {
      await _prestigeRepository.saveTotalMultiplier(state.totalMultiplier);
      await _prestigeRepository.saveCurrentThreshold(state.currentThreshold);
      await _prestigeRepository.savePrestigeCount(state.prestigeCount);
    } catch (error, stackTrace) {
      throw GameException('Failed to persist prestige state', error.toString(), stackTrace);
    }
  }

  Future<void> reset() async {
    try {
      final initialState = PrestigeStateModel.initial();
      _prestigeStateSubject.add(initialState);
      await _saveState(initialState);
    } catch (error, stackTrace) {
      throw GameException('Failed to reset prestige', error.toString(), stackTrace);
    }
  }

  @disposeMethod
  void dispose() {
    _energySubscription?.cancel();
    _prestigeStateSubject.close();
  }
}
