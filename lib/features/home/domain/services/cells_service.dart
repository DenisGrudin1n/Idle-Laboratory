import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/extensions/cell_model_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/repositories/cell_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:idle_laboratory/features/home/domain/services/prestige_service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class CellsService {
  CellsService(this._cellRepository, this._energyService, this._prestigeService) {
    _cellsSubject.add(_cellRepository.getDefaultCells());
    _init();
  }

  final CellRepository _cellRepository;
  final EnergyService _energyService;
  final PrestigeService _prestigeService;

  final BehaviorSubject<List<CellModel>> _cellsSubject = BehaviorSubject<List<CellModel>>();
  final BehaviorSubject<Map<String, BigNumber>> _cellEnergiesSubject = BehaviorSubject<Map<String, BigNumber>>.seeded(
    {},
  );

  StreamSubscription<List<CellModel>>? _progressionSubscription;
  StreamSubscription<BigNumber>? _epsCalculationSubscription;
  StreamSubscription<int>? _prestigeCountSubscription;

  Stream<List<CellModel>> get cells$ => _cellsSubject.stream;
  Stream<Map<String, BigNumber>> get cellEnergies$ => _cellEnergiesSubject.stream;

  List<CellModel> get currentCells => _cellsSubject.hasValue ? _cellsSubject.value : _cellRepository.getDefaultCells();
  Map<String, BigNumber> get currentCellEnergies => _cellEnergiesSubject.value;

  Future<void> _init() async {
    await _initializeCells();
    _setupEnergyReaction();
    _setupEPSCalculation();
    _setupPrestigeListener();
  }

  Future<void> _initializeCells() async {
    final savedCells = await _cellRepository.getSavedCells();
    final defaultCells = _cellRepository.getDefaultCells();

    if (savedCells == null || savedCells.isEmpty) return;

    final savedCellsMap = {for (final cell in savedCells) cell.id: cell};

    final finalCells = defaultCells.map((defaultCell) {
      final saved = savedCellsMap[defaultCell.id];
      if (saved == null) return defaultCell;

      // Smart merge: keep saved progress (level, lock status) but ensure latest metadata
      return saved.copyWith(
        name: defaultCell.name,
        type: defaultCell.type,
      );
    }).toList();

    _cellsSubject.add(finalCells);
    // Immediately sync EPS with EnergyService after loading
    _energyService.updateEPS(_calculateTotalEPS(finalCells));
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

  void _setupEPSCalculation() =>
      _epsCalculationSubscription = cells$.map(_calculateTotalEPS).distinct().listen(_energyService.updateEPS);

  void _setupPrestigeListener() => _prestigeCountSubscription = _prestigeService.prestigeState$
      .map((s) => s.prestigeCount)
      .distinct()
      .skip(1) // Skip initial emission
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

    final cellId = cell.cellId;
    if (cellId == null) return cell;

    final newLevel = GameBalance.calculateMaxLevel(cellId.index, cellEnergy);
    if (newLevel <= cell.level) return cell;

    final updatedCell = cell.copyWith(level: newLevel);
    return updatedCell.copyWith(energyPerSecond: updatedCell.eps.format());
  }).toList();

  BigNumber _calculateTotalEPS(List<CellModel> cells) {
    final baseEPS = cells.where((cell) => !cell.isLocked).fold(BigNumber.zero(), (total, cell) => total + cell.eps);
    return baseEPS * _prestigeService.getEffectiveMultiplier();
  }

  void saveCells() => _cellRepository.saveCells(currentCells);

  double getFillLevel(String cellId) {
    final cell = currentCells.cast<CellModel?>().firstWhere((c) => c?.id == cellId, orElse: () => null);
    if (cell == null) return 0;

    // Rule: Max level cells are always 100% filled
    if (cell.isMaxLevel) return 1;

    final cellEnergy = currentCellEnergies[cellId];
    return cellEnergy == null ? 0 : cell.getProgressToNextLevel(cellEnergy);
  }

  void start() => _energyService.updateEPS(_calculateTotalEPS(currentCells));

  void reset() {
    final defaultCells = _cellRepository.getDefaultCells();
    _cellsSubject.add(defaultCells);
    _cellEnergiesSubject.add({});
    _cellRepository.saveCells(defaultCells);
    start();
  }

  @disposeMethod
  void dispose() {
    _progressionSubscription?.cancel();
    _epsCalculationSubscription?.cancel();
    _prestigeCountSubscription?.cancel();
    _saveTimer?.cancel();
    _cellsSubject.close();
    _cellEnergiesSubject.close();
  }
}
