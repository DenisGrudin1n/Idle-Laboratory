part of 'crafting_bloc.dart';

@freezed
class CraftingEvent with _$CraftingEvent {
  const factory CraftingEvent.cellSlotChanged(CellId? cellId) = _CellSlotChanged;
  const factory CraftingEvent.reagent1Changed(ResearchMaterialId? materialId) = _Reagent1Changed;
  const factory CraftingEvent.reagent2Changed(ResearchMaterialId? materialId) = _Reagent2Changed;
  const factory CraftingEvent.targetQuantityChanged(int quantity) = _TargetQuantityChanged;
  const factory CraftingEvent.inputsCleared() = _InputsCleared;
  const factory CraftingEvent.startReaction() = _StartReaction;
  const factory CraftingEvent.stopReaction() = _StopReaction;
  const factory CraftingEvent.validate() = _Validate;
  const factory CraftingEvent.tick(double dt) = _Tick;
}
