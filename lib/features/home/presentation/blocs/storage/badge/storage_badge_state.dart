part of 'storage_badge_cubit.dart';

@freezed
abstract class StorageBadgeState with _$StorageBadgeState {
  const factory StorageBadgeState({
    ResearchMaterialId? materialId,
    @Default(0) int timestamp,
  }) = _StorageBadgeState;
}
