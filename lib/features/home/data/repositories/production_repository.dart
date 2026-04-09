import 'package:idle_laboratory/features/home/domain/models/cell_production_entry/cell_production_entry.dart';

abstract class ProductionRepository {
  Future<Map<String, CellProductionEntry>?> getSavedProduction();
  Future<void> saveProduction(Map<String, CellProductionEntry> byCellId);
  Future<void> clearAll();
}
