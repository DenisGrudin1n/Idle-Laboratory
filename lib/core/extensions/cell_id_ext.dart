import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/cell_name.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';

extension CellIdNaming on CellId {
  CellName get cellName => CellName.values[order];
}

extension CellIdLookup on CellId {
  CellModel? findIn(Iterable<CellModel> cells) {
    for (final cell in cells) {
      if (cell.id == id) return cell;
    }
    return null;
  }
}
