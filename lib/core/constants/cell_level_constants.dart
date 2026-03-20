import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_level_model/cell_level_model.dart';

/// Constants for cell level progression
class CellLevelConstants {
  CellLevelConstants._();

  /// Basic energy cell level configurations
  /// Each level requires exponentially more energy
  static final List<CellLevelModel> basicEnergyCellLevels = <CellLevelModel>[
    // Level 1: Starting level
    CellLevelModel(
      level: 1,
      energyRequired: BigNumber.zero(), // No requirement for level 1
    ),
    // Level 2: 50 energy required
    CellLevelModel(
      level: 2,
      energyRequired: BigNumber(5, 1), // 50
    ),
    // Level 3: 1,000 energy required
    CellLevelModel(
      level: 3,
      energyRequired: BigNumber(1, 3), // 1K
    ),
    // Level 4: 25,000 energy required
    CellLevelModel(
      level: 4,
      energyRequired: BigNumber(2.5, 4), // 25K
    ),
    // Level 5: 500,000 energy required
    CellLevelModel(
      level: 5,
      energyRequired: BigNumber(5, 5), // 500K
    ),
  ];

  /// Heat cell level configurations
  /// Requires more energy than basic cell (10x multiplier)
  static final List<CellLevelModel> heatCellLevels = <CellLevelModel>[
    // Level 1: Starting level
    CellLevelModel(
      level: 1,
      energyRequired: BigNumber.zero(), // No requirement for level 1
    ),
    // Level 2: 500 energy required (10x basic)
    CellLevelModel(
      level: 2,
      energyRequired: BigNumber(5, 2), // 500
    ),
    // Level 3: 10,000 energy required (10x basic)
    CellLevelModel(
      level: 3,
      energyRequired: BigNumber(1, 4), // 10K
    ),
    // Level 4: 250,000 energy required (10x basic)
    CellLevelModel(
      level: 4,
      energyRequired: BigNumber(2.5, 5), // 250K
    ),
    // Level 5: 5,000,000 energy required (10x basic)
    CellLevelModel(
      level: 5,
      energyRequired: BigNumber(5, 6), // 5M
    ),
  ];

  /// Get level configurations for a specific cell type
  static List<CellLevelModel> getLevelConfigs(CellId cellId) {
    switch (cellId) {
      case CellId.basicEnergyCell:
        return basicEnergyCellLevels;
      case CellId.heatCell:
        return heatCellLevels;
      case CellId.iceCell:
      case CellId.darkMatterCell:
        // TODO: Implement for other cells
        return basicEnergyCellLevels; // Fallback for now
    }
  }

  /// Energy requirements for unlocking cells
  static final Map<CellId, BigNumber> cellUnlockRequirements =
      <CellId, BigNumber>{
        CellId.heatCell: BigNumber(1, 3), // 1K
        CellId.iceCell: BigNumber(1, 5), // 100K
        CellId.darkMatterCell: BigNumber(1, 7), // 10M
      };
}
