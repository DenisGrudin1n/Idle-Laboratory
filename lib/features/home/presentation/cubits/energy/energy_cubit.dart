import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:idle_laboratory/core/constants/game_constants.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/presentation/cubits/energy/energy_state.dart';

class EnergyCubit extends Cubit<EnergyState> {
  EnergyCubit() : super(EnergyState.initial()) {
    _startEnergyGeneration();
  }

  Timer? _timer;

  void _startEnergyGeneration() {
    _timer = Timer.periodic(
      const Duration(milliseconds: GameConstants.energyUpdateIntervalMs),
      (_) => _generateEnergy(),
    );
  }

  void _generateEnergy() {
    final BigNumber increment = state.energyPerSecond.multiplyByDouble(
      GameConstants.energyUpdateIntervalMs / 1000,
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
