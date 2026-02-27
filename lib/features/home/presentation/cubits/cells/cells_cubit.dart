import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/constants/cell_level_constants.dart';
import 'package:idle_laboratory/core/enums/enums.dart';
import 'package:idle_laboratory/core/extensions/extensions.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/repositories/cell_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_level_model/cell_level_model.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/presentation/cubits/energy/energy_cubit.dart';

part 'cells_cubit.freezed.dart';
part 'cells_state.dart';

/// Manages cell level progression and energy-based unlocking
class CellsCubit extends Cubit<CellsState> {
  CellsCubit(this._cellRepository, this._energyCubit)
    : super(const CellsState()) {
    _loadCells();
  }

  final CellRepository _cellRepository;
  final EnergyCubit _energyCubit;

  StreamSubscription<EnergyState>? _energySubscription;
  bool _isUpdatingEPS = false; // Flag to prevent circular updates

  /// Helper method to safely find a cell by ID
  CellModel? _findCellById(String cellId) {
    if (state.cells.isEmpty) {
      return null;
    }
    try {
      return state.cells.firstWhere((CellModel c) => c.id == cellId);
    } catch (_) {
      return null;
    }
  }

  void _loadCells() {
    final List<CellModel> cells = _cellRepository.getAvailableCells();
    emit(
      state.copyWith(
        cells: cells,
        selectedCellId: cells.isNotEmpty ? cells.first.id : null,
      ),
    );
  }

  /// Selects a cell by ID
  void selectCell(String cellId) {
    emit(state.copyWith(selectedCellId: cellId));
  }

  void _onEnergyUpdate(EnergyState energyState) {
    emit(state.copyWith(totalEnergy: energyState.currentEnergy));

    // Trigger progression updates (includes unlocking new cells)
    _updateProgression();

    // Update per-cell dedicated energies after unlocks to ensure new cells get entries
    _updateCellEnergies(energyState.currentEnergy);
  }

  /// Starts the progression system
  /// Progression is driven by energy updates from EnergyCubit, not a separate timer
  void start() {
    // Ensure we only have a single active subscription
    _energySubscription?.cancel();
    _energySubscription = _energyCubit.stream.listen(_onEnergyUpdate);

    // Set initial energy per second from unlocked cells

    _updateEnergyPerSecond();
    // Perform an initial progression update through the same path as stream events
    _onEnergyUpdate(_energyCubit.state);
  }

  void _updateProgression() {
    // Check if any cells need to be unlocked based on total energy
    _checkUnlocks();

    // Update level progress for unlocked cells
    _updateLevelProgress();
  }

  void _checkUnlocks() {
    if (state.totalEnergy == null) {
      return;
    }
    if (!state.cells.any((CellModel cell) => cell.isLocked)) {
      return;
    }
    if (!_hasAnyUnlockableCell()) {
      return;
    }

    final List<CellModel> updatedCells = state.cells
        .map((CellModel cell) => _tryUnlockCell(cell))
        .toList();

    emit(state.copyWith(cells: updatedCells));
    _updateEnergyPerSecond();
  }

  /// Checks if any locked cell meets unlock requirements
  bool _hasAnyUnlockableCell() {
    return state.cells.any((CellModel cell) {
      if (!cell.isLocked) {
        return false;
      }
      return _canUnlockCell(cell);
    });
  }

  /// Checks if a specific cell can be unlocked based on current energy
  bool _canUnlockCell(CellModel cell) {
    final CellId? cellId = CellId.fromString(cell.id);
    if (cellId == null) {
      return false;
    }

    final BigNumber? unlockRequirement =
        CellLevelConstants.cellUnlockRequirements[cellId];
    if (unlockRequirement == null) {
      return false;
    }

    return state.totalEnergy! >= unlockRequirement;
  }

  /// Attempts to unlock a cell, returns the unlocked or original cell
  CellModel _tryUnlockCell(CellModel cell) {
    if (!cell.isLocked || !_canUnlockCell(cell)) {
      return cell;
    }

    final CellId cellId = CellId.fromString(cell.id)!;
    final BigNumber energyPerSecond = CellEnergyPerSecond.getEPS(
      cellId,
      cell.level,
    );

    // Note: cellEnergies and state emission are handled in higher-level flows
    // (e.g., via _updateCellEnergies) to avoid intermediate emits during unlocks.

    return cell.copyWith(
      isLocked: false,
      energyPerSecond: energyPerSecond.format(),
    );
  }

  /// Updates each unlocked cell's dedicated energy pool
  void _updateCellEnergies(BigNumber totalEnergy) {
    final Map<String, BigNumber> updatedCellEnergies =
        Map<String, BigNumber>.from(state.cellEnergies);

    for (final CellModel cell in state.cells) {
      if (cell.isLocked) {
        continue;
      }

      // Ensure this cell has an energy entry
      if (!updatedCellEnergies.containsKey(cell.id)) {
        updatedCellEnergies[cell.id] = BigNumber.zero();
      }

      // Each cell accumulates its own portion of EPS
      // based on its contribution to the total EPS
      final CellId? cellId = CellId.fromString(cell.id);
      if (cellId != null) {
        updatedCellEnergies[cell.id] = totalEnergy;
      }
    }

    if (updatedCellEnergies != state.cellEnergies) {
      emit(state.copyWith(cellEnergies: updatedCellEnergies));
    }
  }

  void _updateLevelProgress() {
    // Check all unlocked cells for level-ups
    for (final CellModel cell in state.cells) {
      if (cell.isLocked) {
        continue;
      }

      if (_shouldLevelUp(cell)) {
        _levelUpCell(cell, cell.level + 1);
      }
    }
  }

  /// Checks if a cell should level up based on current energy
  bool _shouldLevelUp(CellModel cell) {
    final BigNumber? cellEnergy = state.cellEnergies[cell.id];
    if (cellEnergy == null) {
      return false;
    }

    final CellId? cellId = CellId.fromString(cell.id);
    if (cellId == null) {
      return false;
    }

    final CellLevelModel? nextLevelConfig = CellLevelConstants.getLevelConfigs(
      cellId,
    ).getConfig(cell.level + 1);
    if (nextLevelConfig == null) {
      return false; // Max level reached
    }

    return cellEnergy >= nextLevelConfig.energyRequired;
  }

  void _levelUpCell(CellModel cell, int newLevel) {
    final CellId? cellId = CellId.fromString(cell.id);
    if (cellId == null) {
      return;
    }

    final CellLevelModel? newConfig = CellLevelConstants.getLevelConfigs(
      cellId,
    ).getConfig(newLevel);
    if (newConfig == null) {
      return;
    }

    final BigNumber energyPerSecond = CellEnergyPerSecond.getEPS(
      cellId,
      newLevel,
    );

    final List<CellModel> updatedCells = state.cells
        .map(
          (CellModel c) => c.id == cell.id
              ? c.copyWith(
                  level: newLevel,
                  energyPerSecond: energyPerSecond.format(),
                )
              : c,
        )
        .toList();

    emit(state.copyWith(cells: updatedCells));
    _updateEnergyPerSecond();
  }

  /// Updates the EnergyCubit with the total energy per second from all cells
  void _updateEnergyPerSecond() {
    if (_isUpdatingEPS) {
      return;
    }

    _isUpdatingEPS = true;
    try {
      final BigNumber totalEPS = _calculateTotalEPS();
      _energyCubit.updateEnergyPerSecond(totalEPS);
    } finally {
      _isUpdatingEPS = false;
    }
  }

  /// Calculates total energy per second from all unlocked cells
  BigNumber _calculateTotalEPS() {
    return state.cells.where((CellModel cell) => !cell.isLocked).fold(
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

  /// Get fill level (0.0 to 1.0) for cell container visualization
  double getFillLevel(String cellId) {
    final CellModel? cell = _findCellById(cellId);
    if (cell == null || cell.isLocked) {
      return 0.0;
    }

    // Use this cell's dedicated energy pool
    final BigNumber? cellEnergy = state.cellEnergies[cellId];
    if (cellEnergy == null) {
      return 0.0;
    }

    final (CellLevelModel?, CellLevelModel?) configs = _getLevelConfigs(cell);
    final (CellLevelModel? currentConfig, CellLevelModel? nextConfig) = configs;
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

  /// Gets the current and next level configurations for a cell
  (CellLevelModel?, CellLevelModel?) _getLevelConfigs(CellModel cell) {
    final CellId? cellId = CellId.fromString(cell.id);
    if (cellId == null) {
      return (null, null);
    }

    final List<CellLevelModel> configs = CellLevelConstants.getLevelConfigs(
      cellId,
    );
    final CellLevelModel? currentConfig = configs.getConfig(cell.level);
    final CellLevelModel? nextConfig = configs.getConfig(cell.level + 1);
    return (currentConfig, nextConfig);
  }

  @override
  Future<void> close() {
    _energySubscription?.cancel();
    return super.close();
  }
}
