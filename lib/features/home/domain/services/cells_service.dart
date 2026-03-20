import 'dart:async';
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
  CellsService(
    this._cellRepository,
    this._energyService,
    this._prestigeService,
  ) {
    _initializeCells();
    _setupEnergyReaction();
    _setupEPSCalculation();
  }

  final CellRepository _cellRepository;
  final EnergyService _energyService;
  final PrestigeService _prestigeService;

  final BehaviorSubject<List<CellModel>> _cellsSubject =
      BehaviorSubject<List<CellModel>>();
  final BehaviorSubject<Map<String, BigNumber>> _cellEnergiesSubject =
      BehaviorSubject<Map<String, BigNumber>>.seeded(<String, BigNumber>{});

  StreamSubscription<List<CellModel>>? _progressionSubscription;
  StreamSubscription<BigNumber>? _epsCalculationSubscription;

  Stream<List<CellModel>> get cells$ => _cellsSubject.stream;
  Stream<Map<String, BigNumber>> get cellEnergies$ =>
      _cellEnergiesSubject.stream;

  List<CellModel> get currentCells => _cellsSubject.value;
  Map<String, BigNumber> get currentCellEnergies => _cellEnergiesSubject.value;

  void _initializeCells() {
    final initialCells = _cellRepository.getAvailableCells();
    _cellsSubject.add(initialCells);
  }

  void _setupEnergyReaction() {
    _progressionSubscription = _energyService.energy$
        .map(_processProgression)
        .listen((updatedCells) {
          if (_cellsHaveChanged(updatedCells)) {
            _cellsSubject.add(updatedCells);
          }
        });
  }

  void _setupEPSCalculation() {
    _epsCalculationSubscription = cells$
        .map(_calculateTotalEPS)
        .distinct()
        .listen(_energyService.updateEPS);
  }

  List<CellModel> _processProgression(BigNumber totalEnergy) {
    var cells = currentCells;
    cells = _processUnlocks(cells, totalEnergy);
    _updateCellEnergies(cells, totalEnergy);
    return _processLevelUps(cells);
  }

  List<CellModel> _processUnlocks(
    List<CellModel> cells,
    BigNumber totalEnergy,
  ) => cells.map((cell) {
    if (!cell.canUnlock(totalEnergy)) return cell;
    return cell.copyWith(isLocked: false, energyPerSecond: cell.eps.format());
  }).toList();

  void _updateCellEnergies(List<CellModel> cells, BigNumber totalEnergy) {
    final updatedEnergies = Map<String, BigNumber>.from(currentCellEnergies);
    for (final cell in cells) {
      if (!cell.isLocked) updatedEnergies[cell.id] = totalEnergy;
    }
    if (updatedEnergies != currentCellEnergies)
      _cellEnergiesSubject.add(updatedEnergies);
  }

  List<CellModel> _processLevelUps(List<CellModel> cells) => cells.map((cell) {
    final cellEnergy = currentCellEnergies[cell.id];
    if (cellEnergy == null || !cell.canLevelUp(cellEnergy)) return cell;
    return cell.copyWith(
      level: cell.level + 1,
      energyPerSecond: cell.nextLevelEPS.format(),
    );
  }).toList();

  BigNumber _calculateTotalEPS(List<CellModel> cells) {
    final baseEPS = cells
        .where((cell) => !cell.isLocked)
        .fold(BigNumber.zero(), (total, cell) => total + cell.eps);
    final multiplier = _prestigeService.getEffectiveMultiplier();
    return baseEPS * multiplier;
  }

  bool _cellsHaveChanged(List<CellModel> newCells) {
    final current = _cellsSubject.value;
    if (newCells.length != current.length) return true;
    for (var i = 0; i < newCells.length; i++) {
      if (newCells[i] != current[i]) return true;
    }
    return false;
  }

  double getFillLevel(String cellId) {
    final cell = currentCells.cast<CellModel?>().firstWhere(
      (c) => c?.id == cellId,
      orElse: () => null,
    );
    if (cell == null) return 0;
    final cellEnergy = currentCellEnergies[cellId];
    if (cellEnergy == null) return 0;
    return cell.getProgressToNextLevel(cellEnergy);
  }

  void start() {
    final initialEPS = _calculateTotalEPS(currentCells);
    _energyService.updateEPS(initialEPS);
  }

  void reset() {
    _initializeCells();
    _cellEnergiesSubject.add(<String, BigNumber>{});
  }

  @disposeMethod
  void dispose() {
    _progressionSubscription?.cancel();
    _epsCalculationSubscription?.cancel();
    _cellsSubject.close();
    _cellEnergiesSubject.close();
  }
}
