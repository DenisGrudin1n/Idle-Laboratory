import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';

abstract class CellRepository {
  List<CellModel> getDefaultCells();
  Future<List<CellModel>?> getSavedCells();
  Future<void> saveCells(List<CellModel> cells);
  Future<void> clearAll();
}
