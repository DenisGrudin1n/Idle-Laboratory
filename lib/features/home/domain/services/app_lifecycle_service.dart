import 'package:flutter/material.dart';
import 'package:idle_laboratory/features/home/domain/services/cells_service.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:idle_laboratory/features/home/domain/services/prestige_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppLifecycleService with WidgetsBindingObserver {
  AppLifecycleService(this._energyService, this._cellsService, this._prestigeService) {
    WidgetsBinding.instance.addObserver(this);
  }

  final EnergyService _energyService;
  final CellsService _cellsService;
  final PrestigeService _prestigeService;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _saveAll();
    }
  }

  void _saveAll() {
    _energyService.saveEnergy();
    _cellsService
      ..saveCells()
      ..saveProduction();
    _prestigeService.saveState();
  }

  @disposeMethod
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
