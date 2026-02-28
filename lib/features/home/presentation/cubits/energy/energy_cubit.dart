import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/constants/game_constants.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';

part 'energy_cubit.freezed.dart';
part 'energy_state.dart';

/// Thin wrapper around EnergyService for UI state management.
///
/// This cubit subscribes to EnergyService streams and emits states
/// for the UI layer. All business logic is in EnergyService.
class EnergyCubit extends Cubit<EnergyState> {
  EnergyCubit(this._energyService) : super(EnergyState.initial());

  final EnergyService _energyService;

  StreamSubscription<BigNumber>? _energySubscription;
  StreamSubscription<BigNumber>? _epsSubscription;

  /// Starts the cubit by subscribing to energy service streams
  void start() {
    // Cancel existing subscriptions to prevent duplicates
    _energySubscription?.cancel();
    _epsSubscription?.cancel();

    // Subscribe to energy changes
    _energySubscription = _energyService.energy$.listen((BigNumber energy) {
      emit(state.copyWith(currentEnergy: energy));
    });

    // Subscribe to EPS changes
    _epsSubscription = _energyService.eps$.listen((BigNumber eps) {
      emit(state.copyWith(energyPerSecond: eps));
    });

    // Start the energy service
    _energyService.start();
  }

  /// Updates the energy per second rate
  /// (Called by CellsCubit when cells change)
  void updateEnergyPerSecond(BigNumber newEnergyPerSecond) {
    _energyService.updateEPS(newEnergyPerSecond);
  }

  @override
  Future<void> close() {
    _energySubscription?.cancel();
    _epsSubscription?.cancel();
    return super.close();
  }
}
