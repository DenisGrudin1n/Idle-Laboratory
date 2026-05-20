part of 'storage_bloc.dart';

@freezed
abstract class StorageState with _$StorageState {
  const factory StorageState({
    @Default({}) Map<ResearchMaterialId, int> inventory,
  }) = _StorageState;
}
