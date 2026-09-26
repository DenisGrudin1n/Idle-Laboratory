import 'package:flutter/material.dart';
import 'package:idle_laboratory/features/home/domain/services/cells_service.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:idle_laboratory/features/home/domain/services/prestige_service.dart';
import 'package:idle_laboratory/features/home/domain/services/statistics_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppLifecycleService with WidgetsBindingObserver {
  AppLifecycleService(
    this._energyService,
    this._cellsService,
    this._prestigeService,
    this._statisticsService,
  ) {
    WidgetsBinding.instance.addObserver(this);
  }

  final EnergyService _energyService;
  final CellsService _cellsService;
  final PrestigeService _prestigeService;
  final StatisticsService _statisticsService;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Skip inactive: desktop/macOS fires it on focus blips / transitions.
    switch (state) {
      case AppLifecycleState.paused || AppLifecycleState.hidden || AppLifecycleState.detached:
        _statisticsService.pausePlaytime();
        _saveAll();
      case AppLifecycleState.resumed:
        _statisticsService.resumePlaytime();
      case _:
        break;
    }
  }

  void _saveAll() {
    _energyService.saveEnergy();
    _cellsService
      ..saveCells()
      ..saveProduction();
    _prestigeService.saveState();
    _statisticsService.save();
  }

  @disposeMethod
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
