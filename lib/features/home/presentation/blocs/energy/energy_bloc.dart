import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/bloc/safe_bloc.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:injectable/injectable.dart';

part 'energy_event.dart';
part 'energy_state.dart';
part 'energy_bloc.freezed.dart';

@injectable
class EnergyBloc extends SafeBloc<EnergyEvent, EnergyState> {
  EnergyBloc(this._energyService) : super(EnergyState.initial()) {
    on<_EnergyChanged>(_onEnergyChanged);
    on<_EpsChanged>(_onEpsChanged);
    on<_Start>(_onStart);
    on<_UpdateEPS>(_onUpdateEPS);

    _initialize();
  }

  final EnergyService _energyService;
  StreamSubscription<BigNumber>? _energySubscription;
  StreamSubscription<BigNumber>? _epsSubscription;

  void _initialize() {
    _energySubscription = _energyService.energy$.listen(
      (energy) => add(EnergyEvent.energyChanged(energy)),
    );
    _epsSubscription = _energyService.eps$.listen(
      (eps) => add(EnergyEvent.epsChanged(eps)),
    );
  }

  void _onEnergyChanged(_EnergyChanged event, Emitter<EnergyState> emit) =>
      emit(state.copyWith(currentEnergy: event.energy));

  void _onEpsChanged(_EpsChanged event, Emitter<EnergyState> emit) =>
      emit(state.copyWith(energyPerSecond: event.eps));

  void _onStart(_Start event, Emitter<EnergyState> emit) =>
      _energyService.start();

  void _onUpdateEPS(_UpdateEPS event, Emitter<EnergyState> emit) =>
      _energyService.updateEPS(event.eps);

  @override
  Future<void> close() async {
    await _energySubscription?.cancel();
    await _epsSubscription?.cancel();
    return super.close();
  }
}
