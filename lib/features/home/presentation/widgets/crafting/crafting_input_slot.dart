import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/constants/crafting_layout.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/gradient_slot_frame.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/animated_cell_graphic.dart';

class CraftingInputSlot extends StatelessWidget {
  const CraftingInputSlot({
    required this.slotIndex,
    this.slotSide,
    this.selectedCellId,
    this.onTap,
    super.key,
  });

  final int slotIndex;
  final double? slotSide;
  final CellId? selectedCellId;
  final VoidCallback? onTap;

  bool get isCellSlot => slotIndex == 2;

  @override
  Widget build(BuildContext context) {
    final side = slotSide ?? CraftingLayout.inputSlotSide;
    final child = isCellSlot && selectedCellId != null
        ? LayoutBuilder(
            builder: (context, constraints) {
              final graphicH = constraints.maxHeight * CraftingLayout.inputCellGraphicScale;
              final graphicW = graphicH * CraftingLayout.cellGraphicAspectWidthOverHeight;
              return Center(
                child: SizedBox(
                  width: graphicW,
                  height: graphicH,
                  child: AnimatedCellGraphic(cellId: selectedCellId!),
                ),
              );
            },
          )
        : isCellSlot
            ? Center(
                child: Text(
                  context.l10n.craftingCellSlotTitle,
                  style: context.styles.compactSupporting.copyWith(
                    color: context.color.primaryText.withValues(alpha: 0.55),
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : const SizedBox.expand();

    final slot = SizedBox(
      width: side,
      height: side,
      child: GradientSlotFrame(child: child),
    );

    if (onTap == null) return slot;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: slot,
    );
  }
}
