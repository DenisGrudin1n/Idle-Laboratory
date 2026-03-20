import 'package:idle_laboratory/core/constants/cell_level_constants.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/extensions/cell_level_extensions.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_level_model/cell_level_model.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';

/// Extension methods for CellModel providing convenience helpers.
extension CellModelExt on CellModel {
  /// Gets the CellId enum from the string id.
  /// Returns null if the id is invalid.
  CellId? get cellId => CellId.fromString(id);

  /// Gets the level configurations for this cell.
  /// Returns an empty list if cellId is invalid.
  List<CellLevelModel> get levelConfigs {
    final id = cellId;
    if (id == null) {
      return <CellLevelModel>[];
    }
    return CellLevelConstants.getLevelConfigs(id);
  }

  /// Gets the current level configuration.
  /// Returns null if not found or cell id is invalid.
  CellLevelModel? get currentLevelConfig {
    return levelConfigs.getConfig(level);
  }

  /// Gets the next level configuration.
  /// Returns null if at max level, not found, or cell id is invalid.
  CellLevelModel? get nextLevelConfig {
    return levelConfigs.getConfig(level + 1);
  }

  /// Returns true if this cell is at maximum level.
  bool get isMaxLevel => nextLevelConfig == null;

  /// Returns the energy required to unlock this cell.
  /// Returns null if the cell id is invalid or no requirement is defined.
  BigNumber? get unlockRequirement {
    final id = cellId;
    if (id == null) {
      return null;
    }
    return CellLevelConstants.cellUnlockRequirements[id];
  }

  /// Returns the energy required for the next level.
  /// Returns null if at max level or cell id is invalid.
  BigNumber? get nextLevelEnergyRequired {
    return nextLevelConfig?.energyRequired;
  }

  /// Returns the current level's energy requirement.
  /// Returns null if cell id is invalid or config not found.
  BigNumber? get currentLevelEnergyRequired {
    return currentLevelConfig?.energyRequired;
  }

  /// Checks if this cell can be unlocked with the given energy.
  bool canUnlock(BigNumber availableEnergy) {
    if (!isLocked) {
      return false;
    }
    final requirement = unlockRequirement;
    if (requirement == null) {
      return false;
    }
    return availableEnergy >= requirement;
  }

  /// Checks if this cell can level up with the given energy.
  bool canLevelUp(BigNumber availableEnergy) {
    if (isLocked) {
      return false;
    }
    if (isMaxLevel) {
      return false;
    }
    final requirement = nextLevelEnergyRequired;
    if (requirement == null) {
      return false;
    }
    return availableEnergy >= requirement;
  }

  /// Gets the energy per second for this cell.
  /// Returns zero if locked or cell id is invalid.
  BigNumber get eps {
    if (isLocked) {
      return BigNumber.zero();
    }
    final id = cellId;
    if (id == null) {
      return BigNumber.zero();
    }
    return CellEnergyPerSecond.getEPS(id, level);
  }

  /// Gets the energy per second for the next level.
  /// Returns zero if at max level, locked, or cell id is invalid.
  BigNumber get nextLevelEPS {
    if (isLocked || isMaxLevel) {
      return BigNumber.zero();
    }
    final id = cellId;
    if (id == null) {
      return BigNumber.zero();
    }
    return CellEnergyPerSecond.getEPS(id, level + 1);
  }

  /// Calculates the progress to next level (0.0 to 1.0).
  /// Returns 0.0 if locked or at max level.
  double getProgressToNextLevel(BigNumber currentEnergy) {
    if (isLocked || isMaxLevel) {
      return 0;
    }

    final currentReq = currentLevelEnergyRequired;
    final nextReq = nextLevelEnergyRequired;

    if (currentReq == null || nextReq == null) {
      return 0;
    }

    if (currentEnergy < currentReq) {
      return 0;
    }
    if (currentEnergy >= nextReq) {
      return 1;
    }

    final progressEnergy = currentEnergy - currentReq;
    final levelRange = nextReq - currentReq;

    return progressEnergy.ratio(levelRange, max: 1);
  }

  /// Returns the unlock requirement as a formatted string.
  /// Returns '???' if requirement is not defined.
  String getUnlockRequirementFormatted({bool compact = true}) {
    final requirement = unlockRequirement;
    if (requirement == null) {
      return '???';
    }
    return requirement.format(compact: compact);
  }
}
