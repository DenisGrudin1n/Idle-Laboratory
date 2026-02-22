import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_level_model/cell_level_model.dart';

/// Constants for cell level progression
class CellLevelConstants {
  CellLevelConstants._();

  /// Energy cell level configurations
  /// Each level requires exponentially more energy
  static final List<CellLevelModel> energyCellLevels = <CellLevelModel>[
    // Level 1: Starting level
    CellLevelModel(
      level: 1,
      energyRequired: BigNumber.zero(), // No requirement for level 1
    ),
    // Level 2: 50 energy required
    CellLevelModel(
      level: 2,
      energyRequired: BigNumber(5.0, 1), // 50
    ),
    // Level 3: 1,000 energy required
    CellLevelModel(
      level: 3,
      energyRequired: BigNumber(1.0, 3), // 1K
    ),
    // Level 4: 25,000 energy required
    CellLevelModel(
      level: 4,
      energyRequired: BigNumber(2.5, 4), // 25K
    ),
    // Level 5: 500,000 energy required
    CellLevelModel(
      level: 5,
      energyRequired: BigNumber(5.0, 5), // 500K
    ),
  ];

  /// Energy requirements for unlocking cells
  static final Map<CellId, BigNumber> cellUnlockRequirements =
      <CellId, BigNumber>{
        CellId.heatCell: BigNumber(1.0, 3), // 1K
        CellId.iceCell: BigNumber(1.0, 5), // 100K
        CellId.darkMatterCell: BigNumber(1.0, 7), // 10M
      };
}
