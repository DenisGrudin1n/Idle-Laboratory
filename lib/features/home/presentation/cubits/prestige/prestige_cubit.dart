import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/features/home/domain/models/prestige_state_model/prestige_state_model.dart';
import 'package:idle_laboratory/features/home/domain/services/cells_service.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:idle_laboratory/features/home/domain/services/prestige_service.dart';

part 'prestige_cubit.freezed.dart';
part 'prestige_state.dart';

class PrestigeCubit extends Cubit<PrestigeState> {
  PrestigeCubit(this._prestigeService, this._energyService, this._cellsService)
    : super(PrestigeState(prestigeState: PrestigeStateModel.initial())) {
    _initialize();
  }

  final PrestigeService _prestigeService;
  final EnergyService _energyService;
  final CellsService _cellsService;

  StreamSubscription<PrestigeStateModel>? _prestigeSubscription;

  void _initialize() {
    _prestigeSubscription = _prestigeService.prestigeState$.listen((
      PrestigeStateModel prestigeState,
    ) {
      emit(state.copyWith(prestigeState: prestigeState));
    });
  }

  void start() {
    _prestigeService.start();
  }

  Future<void> prestige() async {
    if (state.prestigeState == null || !state.prestigeState!.isUnlocked) {
      return;
    }

    await _prestigeService.performPrestige();
    _energyService.reset();
    _cellsService.reset();
  }

  Future<void> resetPrestige() async {
    await _prestigeService.reset();
    _energyService.reset();
    _cellsService.reset();
  }

  @override
  Future<void> close() {
    _prestigeSubscription?.cancel();
    return super.close();
  }
}
