import 'dart:math' as math;
import 'package:idle_laboratory/core/utils/big_number.dart';

class GameBalance {
  const GameBalance._();

  static final prestigeMinimumGain = BigNumber(1, 0);
  static final prestigeInitialThreshold = BigNumber(1, 3);
  static const prestigeMultiplierFactor = 1.0;

  static final initialEnergy = BigNumber.zero();
  static final maxEnergy = BigNumber(1, 308);
  static const energyTickRateMs = 100;
  static const energyAutoSaveDurationMs = 5000;

  static const cellInitialLevel = 1;
  static const cellDefaultMaxLevel = 1000;
  static const cellLevelCostMultiplier = 1.25;
  static const cellEPSMultiplier = 1.10;

  static const maxAllowedCellLevel = 1000;
  static final minEnergyValue = BigNumber.zero();
  static final energyPrecisionThreshold = BigNumber(1, -10);

  static const defaultUseCompactNotation = true;
  static const defaultUseScientificNotation = false;
  static const energyDecimalPlaces = 2;
  static const percentageDecimalPlaces = 1;

  static const maxSimultaneousUnlocks = 10;
  static const maxSimultaneousLevelUpsPerCell = 10;
  static const streamDistinctThrottle = Duration(milliseconds: 50);

  static const enableEnergyDebugLogs = false;
  static const enablePrestigeDebugLogs = false;
  static const enableCellDebugLogs = false;

  /// Base unlock cost for each cell based on its index
  static BigNumber getBaseUnlockCost(int cellIndex) {
    if (cellIndex <= 0) return BigNumber.zero();
    // 10^(3n + 1) -> 10^4, 10^7, 10^10...
    return BigNumber.pow(10, 3.0 * cellIndex + 1.0);
  }

  /// Base level up cost (at level 1) for each cell based on its index
  static BigNumber getBaseLevelUpCost(int cellIndex) {
    if (cellIndex <= 0) return BigNumber(1, 1); // 10
    // 10^(3n) -> 1e3, 1e6, 1e9...
    return BigNumber.pow(10, 3.0 * cellIndex);
  }

  /// Base energy per second for each cell at level 1
  static BigNumber getBaseEPS(int cellIndex) {
    if (cellIndex <= 0) return BigNumber(1, 0); // 1
    // 10^(3n - 1) -> 10^2, 10^5, 10^8...
    return BigNumber.pow(10, 3.0 * cellIndex - 1.0);
  }

  static BigNumber calculateLevelCost(int cellIndex, int level) {
    if (level < 1) return BigNumber.zero();
    final baseCost = getBaseLevelUpCost(cellIndex);
    // Cost(level) = BaseCost * (Multiplier ^ (level - 1))
    return baseCost * BigNumber.pow(cellLevelCostMultiplier, level - 1.0);
  }

  static BigNumber calculateLevelEPS(int cellIndex, int level) {
    if (level < 1) return BigNumber.zero();
    final baseEPS = getBaseEPS(cellIndex);
    // EPS(level) = BaseEPS * (Multiplier ^ (level - 1))
    return baseEPS * BigNumber.pow(cellEPSMultiplier, level - 1.0);
  }

  static int calculateMaxLevel(int cellIndex, BigNumber currentEnergy) {
    final baseCost = getBaseLevelUpCost(cellIndex);
    if (currentEnergy < baseCost) return 1;

    // level <= log(Energy / BaseCost) / log(Multiplier) + 1
    final logEnergy = currentEnergy.log10();
    final logBaseCost = baseCost.log10();
    final logMultiplier = math.log(cellLevelCostMultiplier) / math.ln10;

    final maxLevel = ((logEnergy - logBaseCost) / logMultiplier).floor() + 1;
    return maxLevel.clamp(1, maxAllowedCellLevel);
  }

  static BigNumber calculatePrestigeMultiplier(BigNumber currentEnergy, BigNumber currentThreshold) {
    if (currentEnergy < initialThreshold || currentEnergy <= currentThreshold) return BigNumber.zero();

    // Formula: (CurrentEnergy / MaxEverEnergy) ^ 0.5
    final ratio = currentEnergy.ratio(currentThreshold);
    if (ratio <= 1.0) return BigNumber.zero();

    return BigNumber.fromDouble(math.sqrt(ratio) * prestigeMultiplierFactor);
  }

  static final initialThreshold = BigNumber(1, 6); // 1 million energy to start prestiging

  // --- Production (per cell: stock amount + acceleration level) ---

  static const maxAccelerationLevel = 100;

  /// Scales all production-derived EPS (stock → energy/sec). Independent of acceleration costs.
  static const productionEPSContributionMultiplier = 100.0;

  /// Per tier: higher order = **more** EU per stock unit, but **slower** stock gain (PPS ∝ this^-order).
  static const productionTierPowerBase = 8.0;

  /// Energy/sec from stock: amount * 0.001 * [productionTierPowerBase]^order (late tiers punch above their weight).
  static double productionStockEnergyMultiplier(int cellOrder) => 0.001 * math.pow(productionTierPowerBase, cellOrder);

  /// Stock gain (units/s): higher tiers accrue stock slower; acceleration level curve is shared.
  static const productionPPSPerLevelBase = 1.15;

  static double calculateProductionPPS(int cellOrder, int accelerationLevel) {
    final level = accelerationLevel.clamp(1, maxAccelerationLevel);
    final tierMult = math.pow(productionTierPowerBase, -cellOrder);
    return tierMult * math.pow(productionPPSPerLevelBase, level - 1).toDouble();
  }

  static const productionAccelerationCostMultiplier = 1.18;

  /// Exponent step per cell tier on top of 10^2 base; steeper = later cells pay much more per upgrade.
  static const productionAccelerationCostOrderExponent = 0.72;

  /// Cost to buy acceleration level (currentLevel -> currentLevel + 1). currentLevel in 1..max.
  static BigNumber calculateAccelerationUpgradeCost(int cellOrder, int currentAccelerationLevel) {
    if (currentAccelerationLevel >= maxAccelerationLevel) return BigNumber.zero();
    final base = BigNumber.pow(10, 2.0 + cellOrder * productionAccelerationCostOrderExponent);
    return base * BigNumber.pow(productionAccelerationCostMultiplier, currentAccelerationLevel - 1.0);
  }

  static BigNumber productionEnergyPerSecondFromStock(BigNumber amount, int cellOrder) {
    final mult = productionStockEnergyMultiplier(cellOrder) * productionEPSContributionMultiplier;
    return amount.multiplyByDouble(mult);
  }
}
