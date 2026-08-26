import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/cell_name.dart';
import 'package:idle_laboratory/core/enums/cell_type.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_production_entry/cell_production_entry.dart';
import 'package:idle_laboratory/features/home/domain/models/prestige_state_model/prestige_state_model.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/prestige/prestige_bloc.dart';

CellModel testCell({
  required CellId id,
  bool isLocked = true,
  int level = 1,
}) {
  return CellModel(
    id: id.id,
    name: CellName.values[id.order],
    type: CellType.energy,
    level: level,
    isLocked: isLocked,
  );
}

List<CellModel> defaultTestCells({int unlockedCount = 4}) {
  return CellId.values
      .map((id) => testCell(id: id, isLocked: id.order >= unlockedCount))
      .toList(growable: false);
}

Map<String, CellProductionEntry> testProductionMap(
  List<CellModel> cells, {
  BigNumber? amount,
  int accelerationLevel = 1,
}) {
  return {
    for (final cell in cells)
      cell.id: CellProductionEntry(
        cellId: cell.id,
        amount: amount ?? BigNumber(10, 0),
        accelerationLevel: accelerationLevel,
      ),
  };
}

CellsState testCellsState({
  List<CellModel>? cells,
  Map<String, CellProductionEntry>? productionByCellId,
}) {
  final resolvedCells = cells ?? defaultTestCells();
  return CellsState(
    cells: resolvedCells,
    productionByCellId: productionByCellId ?? testProductionMap(resolvedCells),
  );
}

PrestigeState testPrestigeState() => PrestigeState(prestigeState: PrestigeStateModel.initial());

CellsState withProductionAmount(CellsState state, String cellId, BigNumber amount) {
  final entry = state.productionByCellId[cellId] ?? CellProductionEntry.initial(cellId);
  return state.copyWith(
    productionByCellId: {
      ...state.productionByCellId,
      cellId: entry.copyWith(amount: amount),
    },
  );
}

CellsState withAccelerationLevel(CellsState state, String cellId, int level) {
  final entry = state.productionByCellId[cellId] ?? CellProductionEntry.initial(cellId);
  return state.copyWith(
    productionByCellId: {
      ...state.productionByCellId,
      cellId: entry.copyWith(accelerationLevel: level),
    },
  );
}
