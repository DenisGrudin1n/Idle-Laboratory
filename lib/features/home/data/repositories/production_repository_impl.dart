import 'dart:convert';

import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/core/exceptions/game_exceptions.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/data/repositories/production_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_production_entry/cell_production_entry.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductionRepository)
class ProductionRepositoryImpl implements ProductionRepository {
  const ProductionRepositoryImpl(this._dataSource);
  final LocalStorageDataSource _dataSource;

  @override
  Future<Map<String, CellProductionEntry>?> getSavedProduction() => guardAsync(() async {
        final json = _dataSource.getString(StorageKeys.productionData);
        if (json == null) return null;
        final list = jsonDecode(json) as List<dynamic>;
        final map = <String, CellProductionEntry>{};
        for (final item in list) {
          try {
            final entry = CellProductionEntry.fromJson(item as Map<String, dynamic>);
            if (entry.cellId.isNotEmpty) map[entry.cellId] = entry;
          } catch (_) {}
        }
        return map.isEmpty ? null : map;
      });

  @override
  Future<void> saveProduction(Map<String, CellProductionEntry> byCellId) => guardAsync(() async {
        final list = byCellId.values.map((e) => e.toJson()).toList();
        await _dataSource.setString(StorageKeys.productionData, jsonEncode(list));
      });

  @override
  Future<void> clearAll() => guardAsync(() => _dataSource.remove(StorageKeys.productionData));
}
