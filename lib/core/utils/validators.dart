import 'package:idle_laboratory/core/extensions/big_number_ext.dart';
import 'package:idle_laboratory/core/extensions/cell_model_ext.dart';
import 'package:idle_laboratory/core/extensions/prestige_state_model_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/models/prestige_state_model/prestige_state_model.dart';

class GameValidators {
  const GameValidators._();

  static ValidationResult validateCellUnlock(CellModel cell, BigNumber availableEnergy) {
    if (!cell.isLocked) return const ValidationResult.failure('Cell is already unlocked');
    final requirement = cell.unlockRequirement;
    if (requirement == null) return const ValidationResult.failure('No unlock requirement defined');
    return availableEnergy < requirement
        ? ValidationResult.failure('Insufficient energy. Required: ${requirement.formatCompact()}, Available: ${availableEnergy.formatCompact()}')
        : const ValidationResult.success();
  }

  static ValidationResult validateCellLevelUp(CellModel cell, BigNumber availableEnergy) {
    if (cell.isLocked) return const ValidationResult.failure('Cell is locked');
    if (cell.isMaxLevel) return const ValidationResult.failure('Cell is at maximum level');
    final requirement = cell.nextLevelEnergyRequired;
    if (requirement == null) return const ValidationResult.failure('No level up requirement defined');
    return availableEnergy < requirement
        ? ValidationResult.failure('Insufficient energy. Required: ${requirement.formatCompact()}, Available: ${availableEnergy.formatCompact()}')
        : const ValidationResult.success();
  }

  static ValidationResult validatePrestige(PrestigeStateModel prestigeState) {
    if (!prestigeState.isUnlocked)
      return ValidationResult.failure('Prestige is locked. Reach ${prestigeState.currentThreshold.formatCompact()} energy to unlock');
    if (!prestigeState.hasSignificantGain()) return const ValidationResult.failure('Prestige gain is too low (< 1.0x). Wait for more progress');
    return const ValidationResult.success();
  }

  static ValidationResult validateEnergyRequirement(BigNumber requirement, BigNumber available) => available < requirement
      ? ValidationResult.failure('Insufficient energy. Required: ${requirement.formatCompact()}, Available: ${available.formatCompact()}')
      : const ValidationResult.success();

  static ValidationResult validateEnergyValue(BigNumber energy) {
    if (energy.mantissa < 0) return const ValidationResult.failure('Energy cannot be negative');
    if (energy.mantissa.isNaN) return const ValidationResult.failure('Energy value is invalid (NaN)');
    if (energy.mantissa.isInfinite) return const ValidationResult.failure('Energy value is invalid (Infinite)');
    return const ValidationResult.success();
  }

  static ValidationResult validateLevel(int level, {int maxLevel = 1000}) {
    if (level < 0) return const ValidationResult.failure('Level cannot be negative');
    if (level > maxLevel) return ValidationResult.failure('Level exceeds maximum ($maxLevel)');
    return const ValidationResult.success();
  }
}

class ValidationResult {
  const ValidationResult({required this.isValid, this.errorMessage});
  const ValidationResult.success()
    : isValid = true,
      errorMessage = null;
  const ValidationResult.failure(String message)
    : isValid = false,
      errorMessage = message;

  final bool isValid;
  final String? errorMessage;

  String getErrorMessage([String defaultMessage = 'Validation failed']) => errorMessage ?? defaultMessage;

  @override
  String toString() => isValid ? 'Valid' : 'Invalid: $errorMessage';
}
