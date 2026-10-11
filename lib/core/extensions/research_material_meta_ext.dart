import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';

extension CellIdResearchMaterial on CellId {
  /// Base-tier research material crafted from this cell (bottom tree row).
  ResearchMaterialId? get baseResearchMaterial =>
      order < ResearchMaterialIdMeta.baseTierCount ? ResearchMaterialId.values[order] : null;
}

extension ResearchMaterialIdMeta on ResearchMaterialId {
  static const baseTierCount = 16;

  int get linearIndex => index;

  bool get isBaseTier => index < baseTierCount;

  CellId? get sourceCellId => isBaseTier ? CellId.values[index] : null;

  BigNumber? get baseTierCraftCellCost =>
      isBaseTier ? GameBalance.calculateBaseTierResearchCraftCellCost(index) : null;
}
