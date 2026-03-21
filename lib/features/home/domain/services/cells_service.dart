import 'dart:async';
import 'package:flutter/foundation.dart';
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
    _initializeCells();
    _setupEnergyReaction();
    _setupEPSCalculation();
  }

  final CellRepository _cellRepository;
  final EnergyService _energyService;
  final PrestigeService _prestigeService;

  final BehaviorSubject<List<CellModel>> _cellsSubject = BehaviorSubject<List<CellModel>>();
  final BehaviorSubject<Map<String, BigNumber>> _cellEnergiesSubject =
      BehaviorSubject<Map<String, BigNumber>>.seeded({});

  StreamSubscription<List<CellModel>>? _progressionSubscription;
  StreamSubscription<BigNumber>? _epsCalculationSubscription;

  Stream<List<CellModel>> get cells$ => _cellsSubject.stream;
  Stream<Map<String, BigNumber>> get cellEnergies$ => _cellEnergiesSubject.stream;

  List<CellModel> get currentCells => _cellsSubject.value;
  Map<String, BigNumber> get currentCellEnergies => _cellEnergiesSubject.value;

  Future<void> _initializeCells() async {
    final savedCells = await _cellRepository.getSavedCells();
    _cellsSubject.add(savedCells ?? _cellRepository.getDefaultCells());
  }

  void _setupEnergyReaction() => _progressionSubscription =
          _energyService.energy$.map(_processProgression).listen((updatedCells) {
        if (!listEquals(updatedCells, currentCells)) {
          _cellsSubject.add(updatedCells);
          _cellRepository.saveCells(updatedCells);
        }
      });

  void _setupEPSCalculation() =>
      _epsCalculationSubscription = cells$.map(_calculateTotalEPS).distinct().listen(_energyService.updateEPS);

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
        return cell.copyWith(level: cell.level + 1, energyPerSecond: cell.nextLevelEPS.format());
      }).toList();

  BigNumber _calculateTotalEPS(List<CellModel> cells) {
    final baseEPS =
        cells.where((cell) => !cell.isLocked).fold(BigNumber.zero(), (total, cell) => total + cell.eps);
    return baseEPS * _prestigeService.getEffectiveMultiplier();
  }

  void saveCells() => _cellRepository.saveCells(currentCells);

  double getFillLevel(String cellId) {
    final cell = currentCells.cast<CellModel?>().firstWhere((c) => c?.id == cellId, orElse: () => null);
    final cellEnergy = currentCellEnergies[cellId];
    return cell == null || cellEnergy == null ? 0 : cell.getProgressToNextLevel(cellEnergy);
  }

  void start() => _energyService.updateEPS(_calculateTotalEPS(currentCells));

  void reset() {
    final defaultCells = _cellRepository.getDefaultCells();
    _cellsSubject.add(defaultCells);
    _cellEnergiesSubject.add({});
    _cellRepository.saveCells(defaultCells);
  }

  @disposeMethod
  void dispose() {
    _progressionSubscription?.cancel();
    _epsCalculationSubscription?.cancel();
    _cellsSubject.close();
    _cellEnergiesSubject.close();
  }
}
