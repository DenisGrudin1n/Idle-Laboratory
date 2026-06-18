part of 'storage_bloc.dart';

@freezed
abstract class StorageEvent with _$StorageEvent {
  const factory StorageEvent.inventoryChanged(StorageInventoryModel model) = _InventoryChanged;
}
