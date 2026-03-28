import 'package:idle_laboratory/core/constants/cell_level_constants.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_level_model/cell_level_model.dart';

extension CellLevelConfigExtension on List<CellLevelModel> {
  CellLevelModel? getConfig(int level) => level < 1 || level > length ? null : this[level - 1];

  BigNumber? getCellNextLevelRequirement(int currentLevel) => getConfig(currentLevel + 1)?.energyRequired;
}

class CellEnergyPerSecond {
  CellEnergyPerSecond._();

  static final basicEnergyCellEPS = {
    1: BigNumber(1, 0),
    2: BigNumber(3.5, 0),
    3: BigNumber(1.2, 1),
    4: BigNumber(5, 1),
    5: BigNumber(2.5, 2),
  };

  static final heatCellEPS = {
    1: BigNumber(5, 1),
    2: BigNumber(1.75, 2),
    3: BigNumber(6, 2),
    4: BigNumber(2.5, 3),
    5: BigNumber(1.25, 4),
  };

  static BigNumber getEPS(CellId cellId, int level) => switch (cellId) {
        CellId.basicEnergyCell => basicEnergyCellEPS[level] ?? BigNumber.zero(),
        CellId.heatCell => heatCellEPS[level] ?? BigNumber.zero(),
        _ => BigNumber.zero(),
      };

  static String? getNewCellUnlockRequirement(CellId cellId) =>
      CellLevelConstants.cellUnlockRequirements[cellId]?.format();
}
