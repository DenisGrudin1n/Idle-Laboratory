import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/constants/game_constants.dart';
import 'package:idle_laboratory/core/extensions/cell_model_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/repositories/cell_repository.dart';
import 'package:idle_laboratory/features/home/data/repositories/production_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_production_entry/cell_production_entry.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:idle_laboratory/features/home/domain/services/prestige_service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class CellsService {
  CellsService(this._cellRepository, this._productionRepository, this._energyService, this._prestigeService) {
    _cellsSubject.add(_cellRepository.getDefaultCells());
    _init();
  }

  final CellRepository _cellRepository;
  final ProductionRepository _productionRepository;
  final EnergyService _energyService;
  final PrestigeService _prestigeService;

  final BehaviorSubject<List<CellModel>> _cellsSubject = BehaviorSubject<List<CellModel>>();
  final BehaviorSubject<Map<String, BigNumber>> _cellEnergiesSubject = BehaviorSubject<Map<String, BigNumber>>.seeded(
    {},
  );
  final BehaviorSubject<Map<String, CellProductionEntry>> _productionSubject =
      BehaviorSubject<Map<String, CellProductionEntry>>.seeded({});

  StreamSubscription<List<CellModel>>? _progressionSubscription;
  StreamSubscription<BigNumber>? _epsCalculationSubscription;
  StreamSubscription<int>? _prestigeCountSubscription;
  Timer? _productionTimer;

  Stream<List<CellModel>> get cells$ => _cellsSubject.stream;
  Stream<Map<String, BigNumber>> get cellEnergies$ => _cellEnergiesSubject.stream;
  Stream<Map<String, CellProductionEntry>> get production$ => _productionSubject.stream;

  List<CellModel> get currentCells => _cellsSubject.hasValue ? _cellsSubject.value : _cellRepository.getDefaultCells();
  Map<String, BigNumber> get currentCellEnergies => _cellEnergiesSubject.value;
  Map<String, CellProductionEntry> get currentProduction => _productionSubject.value;

  Future<void> _init() async {
    await _initializeCells();
    _setupEnergyReaction();
    _setupEPSCalculation();
    _setupPrestigeListener();
    _startProductionTimer();
  }

  Future<void> _initializeCells() async {
    final savedCells = await _cellRepository.getSavedCells();
    final savedProduction = await _productionRepository.getSavedProduction();
    final defaultCells = _cellRepository.getDefaultCells();

    if (savedCells == null || savedCells.isEmpty) {
      _rebuildProductionMap(defaultCells, savedProduction);
      _energyService.updateEPS(_calculateTotalEPS(currentCells, _productionSubject.value));
      return;
    }

    final savedCellsMap = {for (final cell in savedCells) cell.id: cell};

    final finalCells = defaultCells.map((defaultCell) {
      final saved = savedCellsMap[defaultCell.id];
      if (saved == null) return defaultCell;

      return saved.copyWith(name: defaultCell.name, type: defaultCell.type);
    }).toList();

    _cellsSubject.add(finalCells);
    _rebuildProductionMap(defaultCells, savedProduction);
    _energyService.updateEPS(_calculateTotalEPS(finalCells, _productionSubject.value));
  }

  void _rebuildProductionMap(List<CellModel> templateCells, Map<String, CellProductionEntry>? saved) {
    final map = <String, CellProductionEntry>{};
    for (final c in templateCells) {
      map[c.id] = saved?[c.id] ?? CellProductionEntry.initial(c.id);
    }
    _productionSubject.add(map);
  }

  void _startProductionTimer() {
    _productionTimer?.cancel();
    _productionTimer = Timer.periodic(
      const Duration(milliseconds: GameConstants.energyUpdateIntervalMs),
      (_) => _tickProduction(),
    );
  }

  void _tickProduction() {
    final cells = currentCells;
    final map = Map<String, CellProductionEntry>.from(_productionSubject.value);
    var changed = false;
    const dt = GameConstants.energyUpdateIntervalMs * 0.001;

    for (final cell in cells) {
      if (cell.isLocked) continue;
      final cellEnum = cell.cellId;
      if (cellEnum == null) continue;

      var entry = map[cell.id] ?? CellProductionEntry.initial(cell.id);
      final pps = GameBalance.calculateProductionPPS(cellEnum.order, entry.accelerationLevel);
      final delta = BigNumber.fromDouble(pps * dt);
      entry = entry.copyWith(amount: entry.amount + delta);
      map[cell.id] = entry;
      changed = true;
    }

    if (changed) _productionSubject.add(map);
  }

  void _setupEnergyReaction() =>
      _progressionSubscription = _energyService.energy$.map(_processProgression).listen((updatedCells) {
        if (!listEquals(updatedCells, currentCells)) {
          _cellsSubject.add(updatedCells);
          _saveCellsThrottled(updatedCells);
        }
      });

  Timer? _saveTimer;
  List<CellModel>? _pendingCellsToSave;

  void _saveCellsThrottled(List<CellModel> cells) {
    _pendingCellsToSave = cells;
    if (_saveTimer != null) return;

    _saveTimer = Timer(const Duration(milliseconds: GameBalance.energyAutoSaveDurationMs), () {
      if (_pendingCellsToSave != null) {
        _cellRepository.saveCells(_pendingCellsToSave!);
        _pendingCellsToSave = null;
      }
      _saveTimer = null;
    });
  }

  Timer? _productionSaveTimer;
  Map<String, CellProductionEntry>? _pendingProductionSave;

  void _saveProductionThrottled(Map<String, CellProductionEntry> map) {
    _pendingProductionSave = map;
    if (_productionSaveTimer != null) return;

    _productionSaveTimer = Timer(const Duration(milliseconds: GameBalance.energyAutoSaveDurationMs), () {
      if (_pendingProductionSave != null) {
        _productionRepository.saveProduction(_pendingProductionSave!);
        _pendingProductionSave = null;
      }
      _productionSaveTimer = null;
    });
  }

  void _setupEPSCalculation() {
    _epsCalculationSubscription = Rx.combineLatest2<List<CellModel>, Map<String, CellProductionEntry>, BigNumber>(
      cells$,
      _productionSubject.stream,
      _calculateTotalEPS,
    ).listen(_energyService.updateEPS);
  }

  void _setupPrestigeListener() => _prestigeCountSubscription = _prestigeService.prestigeState$
      .map((s) => s.prestigeCount)
      .distinct()
      .skip(1)
      .listen((_) => reset());

  List<CellModel> _processProgression(BigNumber totalEnergy) {
    var cells = currentCells;
    cells = _processUnlocks(cells, totalEnergy);
    _updateCellEnergies(cells, totalEnergy);
    return _processLevelUps(cells);
  }

  List<CellModel> _processUnlocks(List<CellModel> cells, BigNumber totalEnergy) => cells.map((cell) {
    if (!cell.canUnlock(totalEnergy)) return cell;
    return cell.copyWith(isLocked: false, energyPerSecond: cell.eps.format());
  }).toList();

  void _updateCellEnergies(List<CellModel> cells, BigNumber totalEnergy) {
    final updatedEnergies = Map<String, BigNumber>.from(currentCellEnergies);
    var changed = false;

    for (final cell in cells) {
      if (!cell.isLocked) {
        if (updatedEnergies[cell.id] != totalEnergy) {
          updatedEnergies[cell.id] = totalEnergy;
          changed = true;
        }
      }
    }

    if (changed) _cellEnergiesSubject.add(updatedEnergies);
  }

  List<CellModel> _processLevelUps(List<CellModel> cells) => cells.map((cell) {
    final cellEnergy = currentCellEnergies[cell.id];
    if (cellEnergy == null || !cell.canLevelUp(cellEnergy)) return cell;

    final id = cell.cellId;
    if (id == null) return cell;

    final newLevel = GameBalance.calculateMaxLevel(id.order, cellEnergy);
    if (newLevel <= cell.level) return cell;

    final updatedCell = cell.copyWith(level: newLevel);
    return updatedCell.copyWith(energyPerSecond: updatedCell.eps.format());
  }).toList();

  BigNumber _calculateTotalEPS(List<CellModel> cells, Map<String, CellProductionEntry> production) {
    final baseEPS = cells.where((cell) => !cell.isLocked).fold(BigNumber.zero(), (total, cell) => total + cell.eps);
    var productionEPS = BigNumber.zero();
    for (final cell in cells) {
      if (cell.isLocked) continue;
      final id = cell.cellId;
      if (id == null) continue;
      final entry = production[cell.id] ?? CellProductionEntry.initial(cell.id);
      productionEPS = productionEPS + GameBalance.productionEnergyPerSecondFromStock(entry.amount, id.order);
    }
    return (baseEPS + productionEPS) * _prestigeService.getEffectiveMultiplier();
  }

  /// Returns false if cell locked, max level, or not enough energy.
  bool accelerateProduction(String cellId) {
    final cell = currentCells.cast<CellModel?>().firstWhere((c) => c?.id == cellId, orElse: () => null);
    if (cell == null || cell.isLocked) return false;
    final id = cell.cellId;
    if (id == null) return false;

    final map = Map<String, CellProductionEntry>.from(_productionSubject.value);
    var entry = map[cellId] ?? CellProductionEntry.initial(cellId);
    if (entry.accelerationLevel >= GameBalance.maxAccelerationLevel) return false;

    final cost = GameBalance.calculateAccelerationUpgradeCost(id.order, entry.accelerationLevel);
    if (!_energyService.trySpendEnergy(cost)) return false;

    entry = entry.copyWith(accelerationLevel: entry.accelerationLevel + 1);
    map[cellId] = entry;
    _productionSubject.add(map);
    _saveProductionThrottled(map);
    return true;
  }

  void saveCells() => _cellRepository.saveCells(currentCells);

  void saveProduction() => _productionRepository.saveProduction(_productionSubject.value);

  double getFillLevel(String cellId) {
    final cell = currentCells.cast<CellModel?>().firstWhere((c) => c?.id == cellId, orElse: () => null);
    if (cell == null) return 0;

    if (cell.isMaxLevel) return 1;

    final cellEnergy = currentCellEnergies[cellId];
    return cellEnergy == null ? 0 : cell.getProgressToNextLevel(cellEnergy);
  }

  void start() => _energyService.updateEPS(_calculateTotalEPS(currentCells, _productionSubject.value));

  void reset() {
    final defaultCells = _cellRepository.getDefaultCells();
    _cellsSubject.add(defaultCells);
    _cellEnergiesSubject.add({});
    _cellRepository.saveCells(defaultCells);
    _rebuildProductionMap(defaultCells, null);
    saveProduction();
    start();
  }

  @disposeMethod
  void dispose() {
    _progressionSubscription?.cancel();
    _epsCalculationSubscription?.cancel();
    _prestigeCountSubscription?.cancel();
    _saveTimer?.cancel();
    _productionSaveTimer?.cancel();
    _productionTimer?.cancel();
    _cellsSubject.close();
    _cellEnergiesSubject.close();
    _productionSubject.close();
  }
}
