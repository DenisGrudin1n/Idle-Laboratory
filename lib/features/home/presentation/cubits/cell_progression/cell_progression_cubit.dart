import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/constants/cell_level_constants.dart';
import 'package:idle_laboratory/core/constants/game_constants.dart';
import 'package:idle_laboratory/core/enums/enums.dart';
import 'package:idle_laboratory/core/extensions/extensions.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/repositories/cell_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_level_model/cell_level_model.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/presentation/cubits/energy/energy_cubit.dart';

part 'cell_progression_cubit.freezed.dart';
part 'cell_progression_state.dart';

/// Manages cell level progression and energy-based unlocking
class CellProgressionCubit extends Cubit<CellProgressionState> {
  CellProgressionCubit(this._cellRepository, this._energyCubit)
    : super(CellProgressionState(totalEnergy: BigNumber.zero())) {
    _loadCells();
    _energySubscription = _energyCubit.stream.listen(_onEnergyUpdate);
  }

  final CellRepository _cellRepository;
  final EnergyCubit _energyCubit;
  Timer? _timer;
  StreamSubscription<EnergyState>? _energySubscription;

  void _loadCells() {
    final List<CellModel> cells = _cellRepository.getAvailableCells();
    emit(state.copyWith(cells: cells));
  }

  void _onEnergyUpdate(EnergyState energyState) {
    emit(state.copyWith(totalEnergy: energyState.currentEnergy));
  }

  /// Starts the progression system with 10 updates per second
  void start() {
    // Set initial energy per second from unlocked cells
    _updateEnergyPerSecond();

    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: GameConstants.energyUpdateIntervalMs),
      (_) => _updateProgression(),
    );
  }

  void _updateProgression() {
    // Check if any cells need to be unlocked based on total energy
    _checkUnlocks();

    // Update level progress for unlocked cells
    _updateLevelProgress();
  }

  void _checkUnlocks() {
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
            state.totalEnergy >= unlockRequirement) {
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
    if (state.cells.isEmpty) {
      return;
    }

    final CellModel basicCell = state.cells.firstWhere(
      (CellModel cell) => cell.id == CellId.basicEnergyCell.id,
      orElse: () => state.cells.first,
    );

    if (basicCell.isLocked) {
      return;
    }

    final int currentLevel = basicCell.level;
    final CellLevelModel? nextLevelConfig = CellLevelConstants.energyCellLevels
        .getConfig(currentLevel + 1);

    if (nextLevelConfig == null) {
      return; // Max level reached
    }

    final BigNumber currentEnergy = state.totalEnergy;
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
    BigNumber totalEPS = BigNumber.zero();

    for (final CellModel cell in state.cells) {
      if (!cell.isLocked) {
        final CellId? cellId = CellId.fromString(cell.id);
        if (cellId != null) {
          totalEPS = totalEPS + CellEnergyPerSecond.getEPS(cellId, cell.level);
        }
      }
    }

    _energyCubit.updateEnergyPerSecond(totalEPS);
  }

  /// Update total energy from external source (EnergyCubit)
  void updateTotalEnergy(BigNumber energy) {
    emit(state.copyWith(totalEnergy: energy));
  }

  /// Get fill level (0.0 to 1.0) for cell container visualization
  double getFillLevel(String cellId) {
    final CellModel? cell = state.cells.firstWhere(
      (CellModel c) => c.id == cellId,
      orElse: () => state.cells.first,
    );

    if (cell == null || cell.isLocked) {
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

    final BigNumber currentEnergy = state.totalEnergy;
    final BigNumber previousRequired = currentConfig.energyRequired;
    final BigNumber nextRequired = nextConfig.energyRequired;

    // Calculate progress from previous level to next level
    final BigNumber progressEnergy = currentEnergy - previousRequired;
    final BigNumber levelRange = nextRequired - previousRequired;

    if (levelRange <= BigNumber.zero()) {
      return 1.0;
    }

    final double fillLevel = progressEnergy.toDouble() / levelRange.toDouble();
    return fillLevel.clamp(0.0, 1.0);
  }

  /// Get energy per second for active cell
  BigNumber getEnergyPerSecond() {
    final CellModel? basicCell = state.cells.firstWhere(
      (CellModel cell) => cell.id == CellId.basicEnergyCell.id,
      orElse: () => state.cells.first,
    );

    if (basicCell == null || basicCell.isLocked) {
      return BigNumber.zero();
    }

    final CellId? cellId = CellId.fromString(basicCell.id);
    if (cellId == null) {
      return BigNumber.zero();
    }

    return CellEnergyPerSecond.getEPS(cellId, basicCell.level);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _energySubscription?.cancel();
    return super.close();
  }
}
