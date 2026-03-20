import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_level_model/cell_level_model.dart';

class CellLevelConstants {
  CellLevelConstants._();

  static final basicEnergyCellLevels = [
    CellLevelModel(level: 1, energyRequired: BigNumber.zero()),
    CellLevelModel(level: 2, energyRequired: BigNumber(5, 1)),
    CellLevelModel(level: 3, energyRequired: BigNumber(1, 3)),
    CellLevelModel(level: 4, energyRequired: BigNumber(2.5, 4)),
    CellLevelModel(level: 5, energyRequired: BigNumber(5, 5)),
  ];

  static final heatCellLevels = [
    CellLevelModel(level: 1, energyRequired: BigNumber.zero()),
    CellLevelModel(level: 2, energyRequired: BigNumber(5, 2)),
    CellLevelModel(level: 3, energyRequired: BigNumber(1, 4)),
    CellLevelModel(level: 4, energyRequired: BigNumber(2.5, 5)),
    CellLevelModel(level: 5, energyRequired: BigNumber(5, 6)),
  ];

  static List<CellLevelModel> getLevelConfigs(CellId cellId) => switch (cellId) {
        CellId.basicEnergyCell => basicEnergyCellLevels,
        CellId.heatCell => heatCellLevels,
        CellId.iceCell || CellId.darkMatterCell => basicEnergyCellLevels,
      };

  static final cellUnlockRequirements = {
    CellId.heatCell: BigNumber(1, 3),
    CellId.iceCell: BigNumber(1, 5),
    CellId.darkMatterCell: BigNumber(1, 7),
  };
}
