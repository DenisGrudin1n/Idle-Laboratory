part of 'crafting_bloc.dart';

@freezed
abstract class CraftingState with _$CraftingState {
  const factory CraftingState({
    CellId? selectedCellId,
    @Default(false) bool isCrafting,
    @Default(0.0) double craftingProgress,
    ResearchMaterialId? craftingMaterialId,
  }) = _CraftingState;
}
