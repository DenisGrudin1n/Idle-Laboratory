import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/constants/crafting_layout.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/app_border_container.dart';
import 'package:idle_laboratory/core/widgets/gradient_slot_frame.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/animated_cell_graphic.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/research/research_material_slot_icon.dart';

class CraftingInputSlot extends StatelessWidget {
  const CraftingInputSlot({
    required this.slotIndex,
    this.slotSide,
    this.selectedCellId,
    this.selectedMaterialId,
    this.onTap,
    super.key,
  });

  final int slotIndex;
  final double? slotSide;
  final CellId? selectedCellId;
  final ResearchMaterialId? selectedMaterialId;
  final VoidCallback? onTap;

  bool get isCellSlot => slotIndex == 2;

  @override
  Widget build(BuildContext context) {
    final side = slotSide ?? CraftingLayout.inputSlotSide;

    Widget? child;
    if (isCellSlot) {
      if (selectedCellId != null) {
        child = LayoutBuilder(
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
        );
      } else {
        child = Center(
          child: Text(
            context.l10n.craftingCellSlotTitle,
            style: context.styles.compactSupporting.copyWith(
              color: context.color.primaryText.withValues(alpha: 0.55),
              fontSize: 8,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }
    } else {
      if (selectedMaterialId != null) {
        child = ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: ResearchMaterialSlotIcon(materialId: selectedMaterialId!, fit: BoxFit.cover),
        );
      } else {
        child = Center(
          child: Text(
            context.l10n.craftingReagentSlot(slotIndex + 1),
            style: context.styles.compactSupporting.copyWith(
              color: context.color.primaryText.withValues(alpha: 0.55),
              fontSize: 8,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }
    }

    final slot = SizedBox(
      width: side,
      height: side,
      child: AppBorderContainer(
        isActive: true,
        activeBorderColor: context.color.titleText,
        borderRadius: 10,
        borderWidth: 1,
        child: GradientSlotFrame(showBorder: false, child: child),
      ),
    );

    if (onTap == null) return slot;

    return GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: slot);
  }
}
