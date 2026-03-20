import 'dart:async';

import 'package:idle_laboratory/core/exceptions/game_exceptions.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/repositories/prestige_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/prestige_state_model/prestige_state_model.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:rxdart/rxdart.dart';

class PrestigeService {
  PrestigeService(this._energyService, this._prestigeRepository) {
    _initializeState();
  }

  final EnergyService _energyService;
  final PrestigeRepository _prestigeRepository;

  final BehaviorSubject<PrestigeStateModel> _prestigeStateSubject =
      BehaviorSubject<PrestigeStateModel>.seeded(PrestigeStateModel.initial());

  StreamSubscription<BigNumber>? _energySubscription;

  Stream<PrestigeStateModel> get prestigeState$ => _prestigeStateSubject.stream;
  PrestigeStateModel get currentState => _prestigeStateSubject.value;

  void _initializeState() {
    _loadState()
        .then((PrestigeStateModel loadedState) {
          _prestigeStateSubject.add(loadedState);
        })
        .catchError((Object error) {
          _prestigeStateSubject.add(PrestigeStateModel.initial());
        });
  }

  void start() {
    _energySubscription?.cancel();
    _energySubscription = _energyService.energy$.listen(_onEnergyChanged);
  }

  void _onEnergyChanged(BigNumber totalEnergy) {
    final PrestigeStateModel state = currentState;
    final BigNumber newMultiplier = _calculateMultiplier(
      totalEnergy,
      state.currentThreshold,
    );
    final bool newIsUnlocked = newMultiplier >= BigNumber(1.0, 0);

    if (newMultiplier != state.currentMultiplier ||
        newIsUnlocked != state.isUnlocked) {
      _prestigeStateSubject.add(
        state.copyWith(
          currentMultiplier: newMultiplier,
          isUnlocked: newIsUnlocked,
        ),
      );
    }
  }

  BigNumber _calculateMultiplier(BigNumber energy, BigNumber threshold) {
    if (threshold <= BigNumber.zero()) {
      return BigNumber.zero();
    }
    final double ratio = energy.ratio(threshold);
    return BigNumber.fromDouble(ratio);
  }

  Future<void> performPrestige() async {
    if (!currentState.isUnlocked) {
      return;
    }

    final BigNumber currentEnergy = _energyService.currentEnergy;
    final PrestigeStateModel oldState = currentState;

    final PrestigeStateModel newState = oldState.copyWith(
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
    final BigNumber? totalMultiplier = await _prestigeRepository
        .getTotalMultiplier();
    final BigNumber? threshold = await _prestigeRepository
        .getCurrentThreshold();
    final int? count = await _prestigeRepository.getPrestigeCount();

    if (totalMultiplier != null && threshold != null && count != null) {
      return PrestigeStateModel(
        totalMultiplier: totalMultiplier,
        currentThreshold: threshold,
        currentMultiplier: BigNumber.zero(),
        isUnlocked: false,
        prestigeCount: count,
      );
    }

    return PrestigeStateModel.initial();
  }

  Future<void> _saveState(PrestigeStateModel state) async {
    try {
      await _prestigeRepository.saveTotalMultiplier(state.totalMultiplier);
      await _prestigeRepository.saveCurrentThreshold(state.currentThreshold);
      await _prestigeRepository.savePrestigeCount(state.prestigeCount);
    } catch (error, stackTrace) {
      throw GameException(
        'Failed to persist prestige state',
        error.toString(),
        stackTrace,
      );
    }
  }

  Future<void> reset() async {
    try {
      final PrestigeStateModel initialState = PrestigeStateModel.initial();
      _prestigeStateSubject.add(initialState);
      await _saveState(initialState);
    } catch (error, stackTrace) {
      throw GameException(
        'Failed to reset prestige',
        error.toString(),
        stackTrace,
      );
    }
  }

  void dispose() {
    _energySubscription?.cancel();
    _prestigeStateSubject.close();
  }
}
