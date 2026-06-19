import 'dart:convert';

import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/core/exceptions/game_exceptions.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/data/repositories/storage_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/storage_inventory_model/storage_inventory_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: StorageRepository)
class StorageRepositoryImpl implements StorageRepository {
  const StorageRepositoryImpl(this._dataSource);
  final LocalStorageDataSource _dataSource;

  @override
  Future<StorageInventoryModel?> getSavedInventory() => guardAsync(() async {
        final json = _dataSource.getString(StorageKeys.storageInventory);
        if (json == null) return null;
        return StorageInventoryModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
      });

  @override
  Future<void> saveInventory(StorageInventoryModel inventory) => guardAsync(() async {
        await _dataSource.setString(StorageKeys.storageInventory, jsonEncode(inventory.toJson()));
      });

  @override
  Future<void> clearAll() => guardAsync(() => _dataSource.remove(StorageKeys.storageInventory));
}
