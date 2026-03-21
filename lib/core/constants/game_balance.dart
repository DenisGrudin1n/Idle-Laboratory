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
  static const cellDefaultMaxLevel = 100;
  static const cellLevelCostScaleFactor = 1.15;
  static const cellEPSScaleFactor = 1.1;

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

  static BigNumber calculateLevelCost(BigNumber baseCost, int level) => level <= 1
      ? baseCost
      : BigNumber.fromDouble(baseCost.toDouble() * (cellLevelCostScaleFactor * level));

  static BigNumber calculateLevelEPS(BigNumber baseEPS, int level) => level <= 1
      ? baseEPS
      : BigNumber.fromDouble(baseEPS.toDouble() * (cellEPSScaleFactor * level));

  static BigNumber calculatePrestigeMultiplier(BigNumber energy, BigNumber threshold) =>
      threshold <= BigNumber.zero() ? BigNumber.zero() : BigNumber.fromDouble(energy.ratio(threshold) * prestigeMultiplierFactor);
}
