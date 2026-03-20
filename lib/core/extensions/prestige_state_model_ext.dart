import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/prestige_state_model/prestige_state_model.dart';

/// Extension methods for PrestigeStateModel providing convenience helpers.
extension PrestigeStateModelExt on PrestigeStateModel {
  /// Returns true if prestige is unlocked and ready to perform.
  bool get isReady => isUnlocked;

  /// Returns true if the player has prestiged at least once.
  bool get hasPrestiged => prestigeCount > 0;

  /// Gets the total multiplier as a formatted string.
  String getTotalMultiplierFormatted({bool compact = true}) {
    return totalMultiplier.format(compact: compact);
  }

  /// Gets the current multiplier (next prestige bonus) as a formatted string.
  String getCurrentMultiplierFormatted({bool compact = true}) {
    return currentMultiplier.format(compact: compact);
  }

  /// Gets the threshold as a formatted string.
  String getThresholdFormatted({bool compact = true}) {
    return currentThreshold.format(compact: compact);
  }

  /// Calculates progress toward unlocking prestige (0.0 to 1.0).
  /// Requires current energy to calculate.
  double getProgress(BigNumber currentEnergy) {
    if (currentThreshold <= BigNumber.zero()) {
      return 0;
    }
    return currentEnergy.ratio(currentThreshold, max: 1);
  }

  /// Gets progress as a percentage string (e.g., "75%").
  String getProgressFormatted(BigNumber currentEnergy, {int decimals = 1}) {
    final progress = getProgress(currentEnergy);
    return '${(progress * 100).toStringAsFixed(decimals)}%';
  }

  /// Returns the effective total multiplier that will be active after prestige.
  BigNumber getEffectiveTotalMultiplier() {
    if (!isUnlocked) {
      return totalMultiplier;
    }
    return totalMultiplier + currentMultiplier;
  }

  /// Calculates how much the multiplier will increase if prestiging now.
  BigNumber getMultiplierGain() {
    return currentMultiplier;
  }

  /// Returns true if the multiplier gain is significant (>= 1.0).
  bool hasSignificantGain() {
    return currentMultiplier >= BigNumber(1, 0);
  }
}
