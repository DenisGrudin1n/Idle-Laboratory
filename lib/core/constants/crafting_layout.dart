abstract final class CraftingLayout {
  CraftingLayout._();

  static const _baselineInputSlotSide = 48.0;
  static const inputSlotSizeFactor = 0.92;
  static const outputSlotSizeFactor = 0.7;

  static double get inputSlotSide => _baselineInputSlotSide * inputSlotSizeFactor;

  static double get inputVerticalGap => 14;

  static double get gapAfterOutputSlot => 24;

  static double get inputsColumnHeight => inputSlotSide * 3 + inputVerticalGap * 2;

  static double get _baselineInputsColumnHeight => _baselineInputSlotSide * 3 + inputVerticalGap * 2;

  static double get outputSlotSide => (_baselineInputsColumnHeight + 12) * outputSlotSizeFactor;

  static double get slotsCoreHeight => inputsColumnHeight > outputSlotSide ? inputsColumnHeight : outputSlotSide;

  static double get slotsRowHeight => slotsCoreHeight;

  static const cellGraphicAspectWidthOverHeight = 0.68;

  static const inputCellGraphicScale = 0.82;

  static double get actionCellIconHeight => 9;

  static double get gapAfterInputSlots => 10;

  static double get gapBeforeOutputSlot => 0;

  static double maxCraftingBlockWidth(double available) => (available * 0.62).clamp(300, 540);
}
