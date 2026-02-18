import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:idle_laboratory/core/constants/game_constants.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/presentation/cubits/energy/energy_state.dart';

/// Manages the energy generation system for the idle game.
///
/// This cubit handles:
/// - Passive energy generation over time
/// - Energy per second (EU/s) tracking
/// - Timer-based updates at configurable intervals
///
/// The timer starts when [start] is called explicitly to avoid
/// resource leaks if the cubit is created but not immediately used.
class EnergyCubit extends Cubit<EnergyState> {
  EnergyCubit() : super(EnergyState.initial());

  Timer? _timer;

  /// Starts the passive energy generation timer.
  /// Should be called when the cubit is ready to begin generating energy.
  void start() {
    _startEnergyGeneration();
  }

  void _startEnergyGeneration() {
    _timer?.cancel(); // Cancel existing timer if any
    _timer = Timer.periodic(
      const Duration(milliseconds: GameConstants.energyUpdateIntervalMs),
      (_) => _generateEnergy(),
    );
  }

  void _generateEnergy() {
    final BigNumber increment = state.energyPerSecond.multiplyByDouble(
      GameConstants.energyUpdateIntervalMs * 0.001,
    );

    final BigNumber newEnergy = state.currentEnergy + increment;

    emit(state.copyWith(currentEnergy: newEnergy));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
