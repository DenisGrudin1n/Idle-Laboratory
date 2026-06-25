import 'package:idle_laboratory/core/constants/crafting_layout.dart';

class CraftingLayoutMetrics {
  const CraftingLayoutMetrics(this.scale);

  factory CraftingLayoutMetrics.forAvailableHeight(double height) {
    final available = height;
    final reference = CraftingLayout.slotsRowHeight;
    if (reference <= 0 || available <= 0) {
      return const CraftingLayoutMetrics(1);
    }
    return CraftingLayoutMetrics((available / reference).clamp(_minScale, _maxScale));
  }

  final double scale;

  static const _minScale = 0.85;
  static const _maxScale = 2.4;

  double get inputSlotSide => CraftingLayout.inputSlotSide * scale;

  double get inputVerticalGap => CraftingLayout.inputVerticalGap * scale;

  double get inputsColumnHeight => inputSlotSide * 3 + inputVerticalGap * 2;

  double get outputSlotSide => CraftingLayout.outputSlotSide * scale;

  double get slotsCoreHeight => inputsColumnHeight > outputSlotSide ? inputsColumnHeight : outputSlotSide;

  double get slotsRowHeight => slotsCoreHeight;
}
