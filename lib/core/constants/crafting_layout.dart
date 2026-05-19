import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class CraftingLayout {
  CraftingLayout._();

  static const _baselineInputSlotSide = 48.0;
  static const inputSlotSizeFactor = 0.92;
  static const outputSlotSizeFactor = 0.7;

  static double get inputSlotSide => (_baselineInputSlotSide * inputSlotSizeFactor).r;

  static double get inputVerticalGap => 14.h;

  static double get gapAfterOutputSlot => 24.w;

  static double get inputsColumnHeight => inputSlotSide * 3 + inputVerticalGap * 2;

  static double get _baselineInputsColumnHeight => _baselineInputSlotSide.r * 3 + inputVerticalGap * 2;

  static double get outputSlotSide => (_baselineInputsColumnHeight + 12.h) * outputSlotSizeFactor;

  static double get slotsCoreHeight => inputsColumnHeight > outputSlotSide ? inputsColumnHeight : outputSlotSide;

  static double get slotsRowHeight => slotsCoreHeight;

  static const cellGraphicAspectWidthOverHeight = 0.68;

  static const inputCellGraphicScale = 0.82;

  static double get actionCellIconHeight => 9.h;

  static double get gapAfterInputSlots => 10.w;

  static double get gapBeforeOutputSlot => 0.w;

  static double maxCraftingBlockWidth(double available) => (available * 0.62).clamp(300.w, 540.w);
}
