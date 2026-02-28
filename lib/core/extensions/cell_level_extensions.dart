import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_level_model/cell_level_model.dart';

import '../constants/cell_level_constants.dart';

/// Extension for cell level configuration operations
extension CellLevelConfigExtension on List<CellLevelModel> {
  /// Get configuration for a specific level
  CellLevelModel? getConfig(int level) {
    if (level < 1 || level > length) {
      return null;
    }
    return this[level - 1];
  }

  /// Get energy requirement for next level
  // TODO: use method later
  BigNumber? getCellNextLevelRequirement(int currentLevel) {
    final CellLevelModel? nextConfig = getConfig(currentLevel + 1);
    return nextConfig?.energyRequired;
  }
}

/// Energy per second values for each cell level
class CellEnergyPerSecond {
  CellEnergyPerSecond._();

  /// Energy per second mapping for basic energy cell levels
  static final Map<int, BigNumber> basicEnergyCellEPS = <int, BigNumber>{
    1: BigNumber(1.0, 0), // 1 EU/s
    2: BigNumber(3.5, 0), // 3.5 EU/s
    3: BigNumber(1.2, 1), // 12 EU/s
    4: BigNumber(5.0, 1), // 50 EU/s
    5: BigNumber(2.5, 2), // 250 EU/s
  };

  /// Energy per second mapping for heat cell levels
  static final Map<int, BigNumber> heatCellEPS = <int, BigNumber>{
    1: BigNumber(5.0, 1), // 50 EU/s
    2: BigNumber(1.75, 2), // 175 EU/s
    3: BigNumber(6.0, 2), // 600 EU/s
    4: BigNumber(2.5, 3), // 2,500 EU/s
    5: BigNumber(1.25, 4), // 12,500 EU/s
  };

  /// Get energy per second for a specific cell and level
  static BigNumber getEPS(CellId cellId, int level) {
    switch (cellId) {
      case CellId.basicEnergyCell:
        return basicEnergyCellEPS[level] ?? BigNumber.zero();
      case CellId.heatCell:
        return heatCellEPS[level] ?? BigNumber.zero();
      case CellId.iceCell:
      case CellId.darkMatterCell:
        // TODO: Implement for other cells
        return BigNumber.zero();
    }
  }

  /// Get energy requirement to unlock a specific cell
  // TODO: use method later
  static String? getNewCellUnlockRequirement(CellId cellId) {
    final BigNumber? requirement =
        CellLevelConstants.cellUnlockRequirements[cellId];
    return requirement?.format();
  }
}
