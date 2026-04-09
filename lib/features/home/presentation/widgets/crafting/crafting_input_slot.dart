import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/constants/crafting_layout.dart';
import 'package:idle_laboratory/core/widgets/gradient_slot_frame.dart';

/// Empty square input slot (gradient frame only).
class CraftingInputSlot extends StatelessWidget {
  const CraftingInputSlot({super.key});

  @override
  Widget build(BuildContext context) {
    final side = CraftingLayout.inputSlotSide;
    return SizedBox(
      width: side,
      height: side,
      child: const GradientSlotFrame(
        child: SizedBox.expand(),
      ),
    );
  }
}
