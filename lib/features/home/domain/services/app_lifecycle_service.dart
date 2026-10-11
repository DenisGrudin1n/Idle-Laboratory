import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/constants/persistence_labels.dart';
import 'package:idle_laboratory/core/exceptions/game_exceptions.dart';
import 'package:idle_laboratory/features/home/domain/services/cells_service.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:idle_laboratory/features/home/domain/services/prestige_service.dart';
import 'package:idle_laboratory/features/home/domain/services/statistics_service.dart';
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppLifecycleService with WidgetsBindingObserver {
  AppLifecycleService(
    this._energyService,
    this._cellsService,
    this._prestigeService,
    this._statisticsService,
    this._storageService,
  ) {
    WidgetsBinding.instance.addObserver(this);
    fireAndForget(_statisticsService.start(), label: PersistenceLabels.statisticsSessionStart);
  }

  final EnergyService _energyService;
  final CellsService _cellsService;
  final PrestigeService _prestigeService;
  final StatisticsService _statisticsService;
  final StorageService _storageService;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        // Focus blips on desktop/macOS — keep playtime running.
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        // Process is still alive (minimized / covered). Persist, but do not end
        // the playtime segment — wall-clock catch-up covers suspended timers.
        fireAndForget(_saveAll(), label: PersistenceLabels.lifecycleFlush);
      case AppLifecycleState.resumed:
        _statisticsService.syncPlaytimeClock();
      case AppLifecycleState.detached:
        _statisticsService.pausePlaytime();
        fireAndForget(_saveAll(), label: PersistenceLabels.lifecycleFlush);
    }
  }

  Future<void> _saveAll() async {
    await Future.wait([
      _energyService.saveEnergy(),
      _cellsService.saveCells(),
      _cellsService.saveProduction(),
      _storageService.saveInventory(),
      _prestigeService.saveState(),
      _statisticsService.save(),
    ]);
  }

  @disposeMethod
  void dispose() {
    _statisticsService.pausePlaytime();
    fireAndForget(_saveAll(), label: PersistenceLabels.lifecycleFlush);
    WidgetsBinding.instance.removeObserver(this);
  }
}
