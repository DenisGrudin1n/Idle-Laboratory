import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Crafting UI geometry. Uses ScreenUtil; only valid after [ScreenUtilInit].
abstract final class CraftingLayout {
  CraftingLayout._();

  static double get inputSlotSide => 40.r;

  static double get inputVerticalGap => 5.h;

  static double get inputsColumnHeight => inputSlotSide * 3 + inputVerticalGap * 2;

  static double get gapAfterInputSlots => 10.w;

  static double get gapBeforeOutputSlot => 14.w;

  /// Max width of the crafting block vs parent width (responsive clamp).
  static double maxCraftingBlockWidth(double available) =>
      (available * 0.62).clamp(300.w, 540.w);
}
