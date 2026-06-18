part of 'storage_bloc.dart';

@freezed
abstract class StorageState with _$StorageState {
  const factory StorageState({
    @Default({}) Map<ResearchMaterialId, int> inventory,
    ResearchMaterialId? lastAddedMaterial,
    @Default(0) int lastAddedTimestamp,
  }) = _StorageState;
}
