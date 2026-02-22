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
    // Trigger progression updates whenever energy changes
    _updateProgression();
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
    // Can't check unlocks if totalEnergy hasn't been initialized
    if (state.totalEnergy == null) {
      return;
    }

    bool needsUpdate = false;
    final List<CellModel> updatedCells = state.cells.map((CellModel cell) {
      if (cell.isLocked) {
        final CellId? cellId = CellId.fromString(cell.id);
        if (cellId == null) {
          return cell;
        }

        final BigNumber? unlockRequirement =
            CellLevelConstants.cellUnlockRequirements[cellId];
        if (unlockRequirement != null &&
            state.totalEnergy! >= unlockRequirement) {
          needsUpdate = true;
          // Set energyPerSecond when unlocking the cell
          final BigNumber energyPerSecond = CellEnergyPerSecond.getEPS(
            cellId,
            cell.level,
          );
          return cell.copyWith(
            isLocked: false,
            energyPerSecond: energyPerSecond.format(),
          );
        }
      }
      return cell;
    }).toList();

    if (needsUpdate) {
      emit(state.copyWith(cells: updatedCells));
      // Update energy per second when cells are unlocked
      _updateEnergyPerSecond();
    }
  }

  void _updateLevelProgress() {
    final CellModel? basicCell = _findCellById(CellId.basicEnergyCell.id);

    if (basicCell == null || basicCell.isLocked || state.totalEnergy == null) {
      return;
    }

    final int currentLevel = basicCell.level;
    final CellLevelModel? nextLevelConfig = CellLevelConstants.energyCellLevels
        .getConfig(currentLevel + 1);

    if (nextLevelConfig == null) {
      return; // Max level reached
    }

    final BigNumber currentEnergy = state.totalEnergy!;
    final BigNumber requiredEnergy = nextLevelConfig.energyRequired;

    // Check if level up is achieved
    if (currentEnergy >= requiredEnergy) {
      _levelUpCell(basicCell, currentLevel + 1);
    }
  }

  void _levelUpCell(CellModel cell, int newLevel) {
    final CellLevelModel? newConfig = CellLevelConstants.energyCellLevels
        .getConfig(newLevel);
    if (newConfig == null) {
      return;
    }

    final CellId? cellId = CellId.fromString(cell.id);
    if (cellId == null) {
      return;
    }

    // Get energy per second for the new level
    final BigNumber energyPerSecond = CellEnergyPerSecond.getEPS(
      cellId,
      newLevel,
    );

    final List<CellModel> updatedCells = state.cells.map((CellModel c) {
      if (c.id == cell.id) {
        return c.copyWith(
          level: newLevel,
          energyPerSecond: energyPerSecond.format(),
        );
      }
      return c;
    }).toList();

    emit(state.copyWith(cells: updatedCells));

    // Update energy per second in EnergyCubit
    _updateEnergyPerSecond();
  }

  /// Updates the EnergyCubit with the total energy per second from all cells
  void _updateEnergyPerSecond() {
    // Prevent circular updates: if we're already updating EPS, don't trigger another update
    if (_isUpdatingEPS) {
      return;
    }

    _isUpdatingEPS = true;
    try {
      BigNumber totalEPS = BigNumber.zero();

      for (final CellModel cell in state.cells) {
        if (!cell.isLocked) {
          final CellId? cellId = CellId.fromString(cell.id);
          if (cellId != null) {
            totalEPS =
                totalEPS + CellEnergyPerSecond.getEPS(cellId, cell.level);
          }
        }
      }

      _energyCubit.updateEnergyPerSecond(totalEPS);
    } finally {
      _isUpdatingEPS = false;
    }
  }

  /// Get fill level (0.0 to 1.0) for cell container visualization
  double getFillLevel(String cellId) {
    final CellModel? cell = _findCellById(cellId);

    if (cell == null || cell.isLocked) {
      return 0.0;
    }

    // If totalEnergy hasn't been initialized yet, return 0.0
    if (state.totalEnergy == null) {
      return 0.0;
    }

    final int currentLevel = cell.level;
    final CellLevelModel? currentConfig = CellLevelConstants.energyCellLevels
        .getConfig(currentLevel);
    final CellLevelModel? nextConfig = CellLevelConstants.energyCellLevels
        .getConfig(currentLevel + 1);

    if (currentConfig == null || nextConfig == null) {
      return 1.0;
    }

    final BigNumber currentEnergy = state.totalEnergy!;
    final BigNumber previousRequired = currentConfig.energyRequired;
    final BigNumber nextRequired = nextConfig.energyRequired;

    // If current energy is below the previous level requirement, return 0.0
    // This handles cases where energy might be reduced or spent
    if (currentEnergy < previousRequired) {
      return 0.0;
    }

    // If current energy meets or exceeds the next level requirement, return 1.0
    // This handles the brief moment before level-up occurs
    if (currentEnergy >= nextRequired) {
      return 1.0;
    }

    // Calculate progress from previous level to next level
    final BigNumber progressEnergy = currentEnergy - previousRequired;
    final BigNumber levelRange = nextRequired - previousRequired;

    if (levelRange <= BigNumber.zero()) {
      return 1.0;
    }

    // Use BigNumber.ratio() to avoid precision loss with very large numbers
    // This keeps the calculation in BigNumber space and only converts the final ratio
    final double fillLevel = progressEnergy.ratio(levelRange);

    // Clamp to ensure valid range, even if ratio returns unexpected values
    return fillLevel.clamp(0.0, 1.0);
  }

  @override
  Future<void> close() {
    _energySubscription?.cancel();
    return super.close();
  }
}
