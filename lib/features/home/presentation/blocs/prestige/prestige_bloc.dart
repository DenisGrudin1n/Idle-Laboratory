import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/bloc/safe_bloc.dart';
import 'package:idle_laboratory/features/home/domain/models/prestige_state_model/prestige_state_model.dart';
import 'package:idle_laboratory/features/home/domain/services/cells_service.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:idle_laboratory/features/home/domain/services/prestige_service.dart';
import 'package:injectable/injectable.dart';

part 'prestige_event.dart';
part 'prestige_state.dart';
part 'prestige_bloc.freezed.dart';

@injectable
class PrestigeBloc extends SafeBloc<PrestigeEvent, PrestigeState> {
  PrestigeBloc(this._prestigeService, this._energyService, this._cellsService) : super(PrestigeState(prestigeState: PrestigeStateModel.initial())) {
    on<_PrestigeStateChanged>(_onPrestigeStateChanged);
    on<_Start>(_onStart);
    on<_Prestige>(_onPrestige);
    on<_ResetPrestige>(_onResetPrestige);
    _initialize();
  }

  final PrestigeService _prestigeService;
  final EnergyService _energyService;
  final CellsService _cellsService;
  StreamSubscription<PrestigeStateModel>? _prestigeSubscription;

  void _initialize() => _prestigeSubscription = _prestigeService.prestigeState$.listen((prestigeState) => add(PrestigeEvent.prestigeStateChanged(prestigeState)));

  void _onPrestigeStateChanged(_PrestigeStateChanged event, Emitter<PrestigeState> emit) => emit(state.copyWith(prestigeState: event.prestigeState));
  void _onStart(_Start event, Emitter<PrestigeState> emit) => _prestigeService.start();

  Future<void> _onPrestige(_Prestige event, Emitter<PrestigeState> emit) async {
    if (state.prestigeState == null || !state.prestigeState!.isUnlocked) return;
    await _prestigeService.performPrestige();
    _energyService.reset();
    _cellsService.reset();
  }

  Future<void> _onResetPrestige(_ResetPrestige event, Emitter<PrestigeState> emit) async {
    await _prestigeService.reset();
    _energyService.reset();
    _cellsService.reset();
  }

  @override
  Future<void> close() async {
    await _prestigeSubscription?.cancel();
    return super.close();
  }
}
