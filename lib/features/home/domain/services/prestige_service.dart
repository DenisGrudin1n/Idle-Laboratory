import 'dart:async';

import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/prestige_state_model/prestige_state_model.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrestigeService {
  PrestigeService(this._energyService, this._prefs) {
    _initializeState();
  }

  final EnergyService _energyService;
  final SharedPreferences _prefs;

  final BehaviorSubject<PrestigeStateModel> _prestigeStateSubject =
      BehaviorSubject<PrestigeStateModel>();

  StreamSubscription<BigNumber>? _energySubscription;

  Stream<PrestigeStateModel> get prestigeState$ => _prestigeStateSubject.stream;
  PrestigeStateModel get currentState => _prestigeStateSubject.value;

  void _initializeState() {
    final PrestigeStateModel loadedState = _loadState();
    _prestigeStateSubject.add(loadedState);
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

  PrestigeStateModel _loadState() {
    final String? totalMultiplierJson = _prefs.getString(
      'prestige_total_multiplier',
    );
    final String? thresholdJson = _prefs.getString('prestige_threshold');
    final int? count = _prefs.getInt('prestige_count');

    if (totalMultiplierJson != null && thresholdJson != null && count != null) {
      return PrestigeStateModel(
        totalMultiplier: _parseBigNumber(totalMultiplierJson),
        currentThreshold: _parseBigNumber(thresholdJson),
        currentMultiplier: BigNumber.zero(),
        isUnlocked: false,
        prestigeCount: count,
      );
    }

    return PrestigeStateModel.initial();
  }

  BigNumber _parseBigNumber(String json) {
    final List<String> parts = json.split('e');
    if (parts.length == 2) {
      final double mantissa = double.parse(parts[0]);
      final int exponent = int.parse(parts[1]);
      return BigNumber(mantissa, exponent);
    }
    return BigNumber.fromDouble(double.parse(json));
  }

  String _serializeBigNumber(BigNumber value) {
    return '${value.mantissa}e${value.exponent}';
  }

  Future<void> _saveState(PrestigeStateModel state) async {
    await _prefs.setString(
      'prestige_total_multiplier',
      _serializeBigNumber(state.totalMultiplier),
    );
    await _prefs.setString(
      'prestige_threshold',
      _serializeBigNumber(state.currentThreshold),
    );
    await _prefs.setInt('prestige_count', state.prestigeCount);
  }

  Future<void> reset() async {
    final PrestigeStateModel initialState = PrestigeStateModel.initial();
    _prestigeStateSubject.add(initialState);
    await _saveState(initialState);
  }

  void dispose() {
    _energySubscription?.cancel();
    _prestigeStateSubject.close();
  }
}
