import 'package:idle_laboratory/features/home/domain/models/storage_inventory_model/storage_inventory_model.dart';

abstract interface class StorageRepository {
  Future<StorageInventoryModel?> getSavedInventory();
  Future<void> saveInventory(StorageInventoryModel inventory);
  Future<void> clearAll();
}
