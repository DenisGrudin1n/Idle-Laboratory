import 'dart:async';

import 'package:idle_laboratory/core/constants/cell_level_constants.dart';
import 'package:idle_laboratory/core/enums/enums.dart';
import 'package:idle_laboratory/core/extensions/extensions.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/repositories/cell_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_level_model/cell_level_model.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:rxdart/rxdart.dart';

/// Stream-based cells management service.
///
/// Reacts to energy changes to:
/// - Unlock new cells
/// - Level up existing cells
/// - Calculate total EPS
/// - Track per-cell energy
class CellsService {
  CellsService(this._cellRepository, this._energyService) {
    _initializeCells();
    _setupEnergyReaction();
    _setupEPSCalculation();
  }

  final CellRepository _cellRepository;
  final EnergyService _energyService;

  final BehaviorSubject<List<CellModel>> _cellsSubject =
      BehaviorSubject<List<CellModel>>();
  final BehaviorSubject<Map<String, BigNumber>> _cellEnergiesSubject =
      BehaviorSubject<Map<String, BigNumber>>.seeded(<String, BigNumber>{});

  StreamSubscription<List<CellModel>>? _energySubscription;
  StreamSubscription<BigNumber>? _cellsSubscription;

  /// Stream of all cells (locked and unlocked).
  /// Emits when cells are unlocked or leveled up.
  Stream<List<CellModel>> get cells$ => _cellsSubject.stream;

  /// Stream of per-cell energy pools.
  /// Each cell tracks its own energy for independent progression.
  Stream<Map<String, BigNumber>> get cellEnergies$ =>
      _cellEnergiesSubject.stream;

  /// Current cells value (synchronous access)
  List<CellModel> get currentCells => _cellsSubject.value;

  /// Current cell energies (synchronous access)
  Map<String, BigNumber> get currentCellEnergies => _cellEnergiesSubject.value;

  void _initializeCells() {
    final List<CellModel> initialCells = _cellRepository.getAvailableCells();
    _cellsSubject.add(initialCells);
  }

  /// Setup reaction to energy changes:
  /// Energy changes → Check unlocks → Check level-ups → Update cell energies
  void _setupEnergyReaction() {
    _energySubscription = _energyService.energy$
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
    _cellsSubscription = cells$
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
      if (!cell.isLocked) {
        return cell;
      }

      final CellId? cellId = CellId.fromString(cell.id);
      if (cellId == null) {
        return cell;
      }

      final BigNumber? unlockRequirement =
          CellLevelConstants.cellUnlockRequirements[cellId];
      if (unlockRequirement == null) {
        return cell;
      }

      if (totalEnergy >= unlockRequirement) {
        // Unlock the cell
        final BigNumber energyPerSecond = CellEnergyPerSecond.getEPS(
          cellId,
          cell.level,
        );

        return cell.copyWith(
          isLocked: false,
          energyPerSecond: energyPerSecond.format(),
        );
      }

      return cell;
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
      if (cell.isLocked) {
        return cell;
      }

      final BigNumber? cellEnergy = currentCellEnergies[cell.id];
      if (cellEnergy == null) {
        return cell;
      }

      final CellId? cellId = CellId.fromString(cell.id);
      if (cellId == null) {
        return cell;
      }

      final CellLevelModel? nextLevelConfig =
          CellLevelConstants.getLevelConfigs(cellId).getConfig(cell.level + 1);

      if (nextLevelConfig != null &&
          cellEnergy >= nextLevelConfig.energyRequired) {
        // Level up the cell
        final BigNumber energyPerSecond = CellEnergyPerSecond.getEPS(
          cellId,
          cell.level + 1,
        );

        return cell.copyWith(
          level: cell.level + 1,
          energyPerSecond: energyPerSecond.format(),
        );
      }

      return cell;
    }).toList();
  }

  /// Calculate total EPS from all unlocked cells
  BigNumber _calculateTotalEPS(List<CellModel> cells) {
    return cells.where((CellModel cell) => !cell.isLocked).fold(
      BigNumber.zero(),
      (BigNumber total, CellModel cell) {
        final CellId? cellId = CellId.fromString(cell.id);
        if (cellId == null) {
          return total;
        }
        return total + CellEnergyPerSecond.getEPS(cellId, cell.level);
      },
    );
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

    if (cell == null || cell.isLocked) {
      return 0.0;
    }

    final BigNumber? cellEnergy = currentCellEnergies[cellId];
    if (cellEnergy == null) {
      return 0.0;
    }

    final CellId? cellIdEnum = CellId.fromString(cell.id);
    if (cellIdEnum == null) {
      return 0.0;
    }

    final List<CellLevelModel> configs = CellLevelConstants.getLevelConfigs(
      cellIdEnum,
    );
    final CellLevelModel? currentConfig = configs.getConfig(cell.level);
    final CellLevelModel? nextConfig = configs.getConfig(cell.level + 1);

    if (currentConfig == null || nextConfig == null) {
      return 1.0;
    }

    if (cellEnergy < currentConfig.energyRequired) {
      return 0.0;
    }
    if (cellEnergy >= nextConfig.energyRequired) {
      return 1.0;
    }

    final BigNumber progressEnergy = cellEnergy - currentConfig.energyRequired;
    final BigNumber levelRange =
        nextConfig.energyRequired - currentConfig.energyRequired;

    if (levelRange <= BigNumber.zero()) {
      return 1.0;
    }

    return progressEnergy.ratio(levelRange, max: 1.0);
  }

  /// Starts the service (initializes EPS calculation)
  void start() {
    // Trigger initial EPS calculation
    final BigNumber initialEPS = _calculateTotalEPS(currentCells);
    _energyService.updateEPS(initialEPS);
  }

  /// Disposes of all streams and subscriptions
  void dispose() {
    _energySubscription?.cancel();
    _cellsSubscription?.cancel();
    _cellsSubject.close();
    _cellEnergiesSubject.close();
  }
}
