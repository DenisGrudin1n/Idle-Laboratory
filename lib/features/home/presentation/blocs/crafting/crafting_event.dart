part of 'crafting_bloc.dart';

@freezed
class CraftingEvent with _$CraftingEvent {
  const factory CraftingEvent.cellSlotChanged(CellId? cellId) = _CellSlotChanged;
  const factory CraftingEvent.inputsCleared() = _InputsCleared;
}
