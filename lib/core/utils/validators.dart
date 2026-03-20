import 'package:idle_laboratory/core/extensions/extensions.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/models/prestige_state_model/prestige_state_model.dart';

/// Validation helpers for game actions and state checks.
///
/// Provides centralized validation logic for:
/// - Cell unlocks and upgrades
/// - Prestige eligibility
/// - Energy sufficiency checks
class GameValidators {
  const GameValidators._();

  /// Validates if a cell can be unlocked with the given energy.
  ///
  /// Returns validation result with success status and optional error message.
  static ValidationResult validateCellUnlock(
    CellModel cell,
    BigNumber availableEnergy,
  ) {
    if (!cell.isLocked) {
      return const ValidationResult.failure('Cell is already unlocked');
    }

    final BigNumber? unlockRequirement = cell.unlockRequirement;
    if (unlockRequirement == null) {
      return const ValidationResult.failure(
        'No unlock requirement defined for cell',
      );
    }

    if (availableEnergy < unlockRequirement) {
      return ValidationResult.failure(
        'Insufficient energy. Required: ${unlockRequirement.formatCompact()}, '
        'Available: ${availableEnergy.formatCompact()}',
      );
    }

    return const ValidationResult.success();
  }

  /// Validates if a cell can be leveled up with the given energy.
  ///
  /// Returns validation result with success status and optional error message.
  static ValidationResult validateCellLevelUp(
    CellModel cell,
    BigNumber availableEnergy,
  ) {
    if (cell.isLocked) {
      return const ValidationResult.failure('Cell is locked');
    }

    if (cell.isMaxLevel) {
      return const ValidationResult.failure('Cell is at maximum level');
    }

    final BigNumber? levelUpRequirement = cell.nextLevelEnergyRequired;
    if (levelUpRequirement == null) {
      return const ValidationResult.failure('No level up requirement defined');
    }

    if (availableEnergy < levelUpRequirement) {
      return ValidationResult.failure(
        'Insufficient energy. Required: ${levelUpRequirement.formatCompact()}, '
        'Available: ${availableEnergy.formatCompact()}',
      );
    }

    return const ValidationResult.success();
  }

  /// Validates if prestige can be performed.
  ///
  /// Returns validation result with success status and optional error message.
  static ValidationResult validatePrestige(PrestigeStateModel prestigeState) {
    if (!prestigeState.isUnlocked) {
      return ValidationResult.failure(
        'Prestige is locked. Reach ${prestigeState.currentThreshold.formatCompact()} '
        'energy to unlock',
      );
    }

    if (!prestigeState.hasSignificantGain()) {
      return const ValidationResult.failure(
        'Prestige gain is too low (< 1.0x). Wait for more progress',
      );
    }

    return const ValidationResult.success();
  }

  /// Validates if there's sufficient energy for an operation.
  ///
  /// Generic energy check that can be reused for any operation.
  static ValidationResult validateEnergyRequirement(
    BigNumber required,
    BigNumber available,
  ) {
    if (available < required) {
      return ValidationResult.failure(
        'Insufficient energy. Required: ${required.formatCompact()}, '
        'Available: ${available.formatCompact()}',
      );
    }

    return const ValidationResult.success();
  }

  /// Validates if energy amount is valid (not negative, not NaN, not infinite).
  static ValidationResult validateEnergyValue(BigNumber energy) {
    if (energy.isNegative) {
      return const ValidationResult.failure('Energy cannot be negative');
    }

    // Check for invalid double values in mantissa
    if (energy.mantissa.isNaN) {
      return const ValidationResult.failure('Energy value is invalid (NaN)');
    }

    if (energy.mantissa.isInfinite) {
      return const ValidationResult.failure(
        'Energy value is invalid (Infinite)',
      );
    }

    return const ValidationResult.success();
  }

  /// Validates if a level value is within acceptable range.
  static ValidationResult validateLevel(int level, {int maxLevel = 1000}) {
    if (level < 0) {
      return const ValidationResult.failure('Level cannot be negative');
    }

    if (level > maxLevel) {
      return ValidationResult.failure('Level exceeds maximum ($maxLevel)');
    }

    return const ValidationResult.success();
  }
}

/// Result of a validation operation.
///
/// Contains success status and optional error message.
class ValidationResult {
  const ValidationResult({required this.isValid, this.errorMessage});

  const ValidationResult.success() : isValid = true, errorMessage = null;

  const ValidationResult.failure(String message)
    : isValid = false,
      errorMessage = message;

  /// Whether the validation passed.
  final bool isValid;

  /// Error message if validation failed, null if successful.
  final String? errorMessage;

  /// Returns the error message or a default message if validation failed.
  String getErrorMessage([String defaultMessage = 'Validation failed']) {
    return errorMessage ?? defaultMessage;
  }

  @override
  String toString() {
    return isValid ? 'Valid' : 'Invalid: $errorMessage';
  }
}
