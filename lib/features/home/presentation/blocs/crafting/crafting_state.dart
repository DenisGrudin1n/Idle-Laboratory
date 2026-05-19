part of 'crafting_bloc.dart';

@freezed
abstract class CraftingState with _$CraftingState {
  const factory CraftingState({CellId? selectedCellId}) = _CraftingState;
}
