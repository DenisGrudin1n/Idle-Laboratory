import 'dart:async';

import 'package:idle_laboratory/core/extensions/extensions.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/repositories/cell_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:idle_laboratory/features/home/domain/services/prestige_service.dart';
import 'package:rxdart/rxdart.dart';

/// Stream-based cells management service.
///
/// Reacts to energy changes to:
/// - Unlock new cells
/// - Level up existing cells
/// - Calculate total EPS
/// - Track per-cell energy
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
    final List<CellModel> initialCells = _cellRepository.getAvailableCells();
    _cellsSubject.add(initialCells);
  }

  /// Setup reaction to energy changes:
  /// Energy changes → Check unlocks → Check level-ups → Update cell energies
  void _setupEnergyReaction() {
    _progressionSubscription = _energyService.energy$
        .map((BigNumber energy) => _processProgression(energy))
        .listen((List<CellModel> updatedCells) {
          if (_cellsHaveChanged(updatedCells)) {
            _cellsSubject.add(updatedCells);
          }
        });
  }

  /// Setup EPS calculation that reacts to cell changes:
  /// Cells change → Calculate total EPS → Update EnergyService
  void _setupEPSCalculation() {
    _epsCalculationSubscription = cells$
        .map((List<CellModel> cells) => _calculateTotalEPS(cells))
        .distinct()
        .listen((BigNumber totalEPS) {
          _energyService.updateEPS(totalEPS);
        });
  }

  /// Process progression for all cells based on current energy
  List<CellModel> _processProgression(BigNumber totalEnergy) {
    List<CellModel> cells = currentCells;

    // Step 1: Check and unlock cells
    cells = _processUnlocks(cells, totalEnergy);

    // Step 2: Update per-cell energies
    _updateCellEnergies(cells, totalEnergy);

    // Step 3: Check and process level-ups
    cells = _processLevelUps(cells);

    return cells;
  }

  /// Check and unlock cells that meet energy requirements
  List<CellModel> _processUnlocks(
    List<CellModel> cells,
    BigNumber totalEnergy,
  ) {
    return cells.map((CellModel cell) {
      // Use extension method to check if cell can be unlocked
      if (!cell.canUnlock(totalEnergy)) {
        return cell;
      }

      // Unlock the cell with its EPS from extension
      return cell.copyWith(isLocked: false, energyPerSecond: cell.eps.format());
    }).toList();
  }

  /// Update per-cell dedicated energy pools
  void _updateCellEnergies(List<CellModel> cells, BigNumber totalEnergy) {
    final Map<String, BigNumber> updatedEnergies = Map<String, BigNumber>.from(
      currentCellEnergies,
    );

    for (final CellModel cell in cells) {
      if (cell.isLocked) {
        continue;
      }

      // All unlocked cells share the total energy for now
      // (can be modified for different progression mechanics)
      updatedEnergies[cell.id] = totalEnergy;
    }

    if (updatedEnergies != currentCellEnergies) {
      _cellEnergiesSubject.add(updatedEnergies);
    }
  }

  /// Check and process level-ups for all unlocked cells
  List<CellModel> _processLevelUps(List<CellModel> cells) {
    return cells.map((CellModel cell) {
      final BigNumber? cellEnergy = currentCellEnergies[cell.id];
      if (cellEnergy == null) {
        return cell;
      }

      // Use extension method to check if cell can level up
      if (!cell.canLevelUp(cellEnergy)) {
        return cell;
      }

      // Level up the cell with its next level EPS from extension
      return cell.copyWith(
        level: cell.level + 1,
        energyPerSecond: cell.nextLevelEPS.format(),
      );
    }).toList();
  }

  /// Calculate total EPS from all unlocked cells
  BigNumber _calculateTotalEPS(List<CellModel> cells) {
    // Use extension method to get EPS directly from cell
    final BigNumber baseEPS = cells
        .where((CellModel cell) => !cell.isLocked)
        .fold(BigNumber.zero(), (BigNumber total, CellModel cell) {
          return total + cell.eps;
        });

    final BigNumber multiplier = _prestigeService.getEffectiveMultiplier();
    return baseEPS * multiplier;
  }

  /// Check if cells have actually changed (avoid redundant emits)
  bool _cellsHaveChanged(List<CellModel> newCells) {
    final List<CellModel> currentCells = _cellsSubject.value;
    if (newCells.length != currentCells.length) {
      return true;
    }

    for (int i = 0; i < newCells.length; i++) {
      if (newCells[i] != currentCells[i]) {
        return true;
      }
    }

    return false;
  }

  /// Get fill level (0.0 to 1.0) for cell container visualization
  double getFillLevel(String cellId) {
    final CellModel? cell = currentCells.cast<CellModel?>().firstWhere(
      (CellModel? c) => c?.id == cellId,
      orElse: () => null,
    );

    if (cell == null) {
      return 0.0;
    }

    final BigNumber? cellEnergy = currentCellEnergies[cellId];
    if (cellEnergy == null) {
      return 0.0;
    }

    // Use extension method to calculate progress
    return cell.getProgressToNextLevel(cellEnergy);
  }

  /// Starts the service (initializes EPS calculation)
  void start() {
    // Trigger initial EPS calculation
    final BigNumber initialEPS = _calculateTotalEPS(currentCells);
    _energyService.updateEPS(initialEPS);
  }

  void reset() {
    _initializeCells();
    _cellEnergiesSubject.add(<String, BigNumber>{});
  }

  /// Disposes of all streams and subscriptions
  void dispose() {
    _progressionSubscription?.cancel();
    _epsCalculationSubscription?.cancel();
    _cellsSubject.close();
    _cellEnergiesSubject.close();
  }
}
