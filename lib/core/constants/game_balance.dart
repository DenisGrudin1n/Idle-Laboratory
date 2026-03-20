import 'package:idle_laboratory/core/utils/big_number.dart';

/// Centralized game balance constants and configuration.
///
/// This class contains all tunable parameters for game balance including:
/// - Unlock thresholds
/// - Level up costs
/// - Prestige calculations
/// - Energy generation rates
/// - Time-based constants
///
/// Keeping these in one place makes it easy to tune game balance
/// and prevents magic numbers scattered throughout the codebase.
class GameBalance {
  const GameBalance._();

  // ============================================================================
  // PRESTIGE CONSTANTS
  // ============================================================================

  /// Minimum multiplier gain required for prestige to be considered worthwhile.
  /// If gain is less than this, prestige is not recommended.
  static final BigNumber prestigeMinimumGain = BigNumber(1.0, 0);

  /// Initial prestige threshold (first prestige unlock requirement).
  static final BigNumber prestigeInitialThreshold = BigNumber(1.0, 3); // 1000

  /// Multiplier for calculating prestige bonus from energy.
  /// Higher value = more generous prestige rewards.
  static const double prestigeMultiplierFactor = 1.0;

  // ============================================================================
  // ENERGY CONSTANTS
  // ============================================================================

  /// Initial energy amount when starting the game.
  static final BigNumber initialEnergy = BigNumber.zero();

  /// Maximum energy value (soft cap, can be exceeded but with diminishing returns).
  /// Set very high to effectively have no cap.
  static final BigNumber maxEnergy = BigNumber(1.0, 308); // ~10^308

  /// Energy update tick rate in milliseconds.
  /// Lower value = smoother updates but more CPU usage.
  static const int energyTickRateMs = 100;

  /// How often to save energy to storage (in milliseconds).
  /// Higher value = less frequent writes but more potential data loss on crash.
  static const int energyAutoSaveDurationMs = 5000;

  // ============================================================================
  // CELL CONSTANTS
  // ============================================================================

  /// Initial cell level when unlocked.
  static const int cellInitialLevel = 1;

  /// Maximum cell level.
  /// Can be overridden per-cell in CellLevelConstants.
  static const int cellDefaultMaxLevel = 100;

  /// Default energy cost scaling factor for cell level-ups.
  /// Each level costs (baseCost * scaleFactor^level).
  static const double cellLevelCostScaleFactor = 1.15;

  /// Default EPS (Energy Per Second) scaling factor for cell level-ups.
  /// Each level produces (baseEPS * scaleFactor^level).
  static const double cellEPSScaleFactor = 1.1;

  // ============================================================================
  // VALIDATION CONSTANTS
  // ============================================================================

  /// Maximum allowed level for any cell (hard limit).
  static const int maxAllowedCellLevel = 1000;

  /// Minimum energy value (prevents negative energy bugs).
  static final BigNumber minEnergyValue = BigNumber.zero();

  /// Precision threshold for energy comparisons.
  /// Values within this threshold are considered equal.
  static final BigNumber energyPrecisionThreshold = BigNumber(1.0, -10);

  // ============================================================================
  // UI/UX CONSTANTS
  // ============================================================================

  /// Whether to use compact notation by default (1.5K vs 1500).
  static const bool defaultUseCompactNotation = true;

  /// Whether to use scientific notation by default (1.5e3 vs 1.5K).
  static const bool defaultUseScientificNotation = false;

  /// Number of decimal places for energy display.
  static const int energyDecimalPlaces = 2;

  /// Number of decimal places for percentage display.
  static const int percentageDecimalPlaces = 1;

  // ============================================================================
  // PERFORMANCE CONSTANTS
  // ============================================================================

  /// Maximum number of cells that can be unlocked simultaneously.
  /// Prevents performance issues with large energy jumps.
  static const int maxSimultaneousUnlocks = 10;

  /// Maximum number of level-ups that can happen simultaneously per cell.
  /// Prevents performance issues with large energy jumps.
  static const int maxSimultaneousLevelUpsPerCell = 10;

  /// Stream distinct check interval - how long to wait before re-checking equality.
  /// Lower = more responsive but more CPU usage.
  static const Duration streamDistinctThrottle = Duration(milliseconds: 50);

  // ============================================================================
  // DEBUG CONSTANTS
  // ============================================================================

  /// Whether to enable debug logging for energy calculations.
  static const bool enableEnergyDebugLogs = false;

  /// Whether to enable debug logging for prestige calculations.
  static const bool enablePrestigeDebugLogs = false;

  /// Whether to enable debug logging for cell progression.
  static const bool enableCellDebugLogs = false;

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Calculates the energy cost for a specific cell level.
  ///
  /// Uses exponential scaling: baseCost * (scaleFactor ^ level)
  static BigNumber calculateLevelCost(BigNumber baseCost, int level) {
    if (level <= 1) {
      return baseCost;
    }
    final double scaledCost =
        baseCost.toDouble() * (cellLevelCostScaleFactor * level);
    return BigNumber.fromDouble(scaledCost);
  }

  /// Calculates the EPS for a specific cell level.
  ///
  /// Uses exponential scaling: baseEPS * (scaleFactor ^ level)
  static BigNumber calculateLevelEPS(BigNumber baseEPS, int level) {
    if (level <= 1) {
      return baseEPS;
    }
    final double scaledEPS = baseEPS.toDouble() * (cellEPSScaleFactor * level);
    return BigNumber.fromDouble(scaledEPS);
  }

  /// Calculates prestige multiplier from energy and threshold.
  static BigNumber calculatePrestigeMultiplier(
    BigNumber energy,
    BigNumber threshold,
  ) {
    if (threshold <= BigNumber.zero()) {
      return BigNumber.zero();
    }
    final double ratio = energy.ratio(threshold);
    return BigNumber.fromDouble(ratio * prestigeMultiplierFactor);
  }
}
