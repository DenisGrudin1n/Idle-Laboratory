import 'package:idle_laboratory/core/constants/cell_level_constants.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';

class CellEnergyPerSecond {
  CellEnergyPerSecond._();

  static BigNumber getEPS(CellId cellId, int level) => GameBalance.calculateLevelEPS(cellId.order, level);

  static String? getNewCellUnlockRequirement(CellId cellId) => CellLevelConstants.getUnlockRequirement(cellId).format();
}
