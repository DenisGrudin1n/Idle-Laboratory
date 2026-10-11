import 'package:idle_laboratory/core/constants/game_errors.dart';
import 'package:idle_laboratory/core/extensions/cell_model_ext.dart';
import 'package:idle_laboratory/core/extensions/prestige_state_model_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/models/prestige_state_model/prestige_state_model.dart';

/// Game validation helpers. Failure payloads are [GameErrors] codes (not UI copy).
class GameValidators {
  const GameValidators._();

  static ValidationResult validateCellUnlock(CellModel cell, BigNumber availableEnergy) {
    if (!cell.isLocked) return const ValidationResult.failure(GameErrors.cellAlreadyUnlocked);
    final requirement = cell.unlockRequirement;
    if (requirement == null) return const ValidationResult.failure(GameErrors.cellNoUnlockRequirement);
    return availableEnergy < requirement
        ? const ValidationResult.failure(GameErrors.insufficientEnergy)
        : const ValidationResult.success();
  }

  static ValidationResult validateCellLevelUp(CellModel cell, BigNumber availableEnergy) {
    if (cell.isLocked) return const ValidationResult.failure(GameErrors.cellLocked);
    if (cell.isMaxLevel) return const ValidationResult.failure(GameErrors.cellMaxLevel);
    final requirement = cell.nextLevelEnergyRequired;
    if (requirement == null) return const ValidationResult.failure(GameErrors.cellNoLevelUpRequirement);
    return availableEnergy < requirement
        ? const ValidationResult.failure(GameErrors.insufficientEnergy)
        : const ValidationResult.success();
  }

  static ValidationResult validatePrestige(PrestigeStateModel prestigeState) {
    if (!prestigeState.isUnlocked) return const ValidationResult.failure(GameErrors.prestigeLocked);
    if (!prestigeState.hasSignificantGain()) return const ValidationResult.failure(GameErrors.prestigeGainTooLow);
    return const ValidationResult.success();
  }

  static ValidationResult validateEnergyRequirement(BigNumber requirement, BigNumber available) =>
      available < requirement
          ? const ValidationResult.failure(GameErrors.insufficientEnergy)
          : const ValidationResult.success();

  static ValidationResult validateEnergyValue(BigNumber energy) {
    if (energy.mantissa < 0) return const ValidationResult.failure(GameErrors.energyNegative);
    if (energy.mantissa.isNaN) return const ValidationResult.failure(GameErrors.energyNaN);
    if (energy.mantissa.isInfinite) return const ValidationResult.failure(GameErrors.energyInfinite);
    return const ValidationResult.success();
  }

  static ValidationResult validateLevel(int level, {int maxLevel = 1000}) {
    if (level < 0) return const ValidationResult.failure(GameErrors.levelNegative);
    if (level > maxLevel) return const ValidationResult.failure(GameErrors.levelExceedsMaximum);
    return const ValidationResult.success();
  }
}

class ValidationResult {
  const ValidationResult({required this.isValid, this.errorCode});
  const ValidationResult.success()
    : isValid = true,
      errorCode = null;
  const ValidationResult.failure(String code)
    : isValid = false,
      errorCode = code;

  final bool isValid;
  final String? errorCode;

  String getErrorCode([String defaultCode = 'validation_failed']) => errorCode ?? defaultCode;

  @override
  String toString() => isValid ? 'Valid' : 'Invalid: $errorCode';
}
