import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_level_model/cell_level_model.dart';

class CellLevelConstants {
  CellLevelConstants._();

  static CellLevelModel getLevelConfig(CellId cellId, int level) =>
      CellLevelModel(level: level, energyRequired: GameBalance.calculateLevelCost(cellId.order, level));

  static BigNumber getUnlockRequirement(CellId cellId) => GameBalance.getBaseUnlockCost(cellId.order);

  static final cellUnlockRequirements = {for (final cellId in CellId.values) cellId: getUnlockRequirement(cellId)};
}
