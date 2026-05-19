import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/cell_name.dart';

extension CellIdNaming on CellId {
  CellName get cellName => CellName.values[order];
}
