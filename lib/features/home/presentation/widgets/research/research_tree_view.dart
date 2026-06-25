import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/constants/crafting_layout.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/utils/research_material_tree.dart';
import 'package:idle_laboratory/core/utils/research_tree_geometry.dart';
import 'package:idle_laboratory/core/widgets/gradient_slot_frame.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/research/research_material_detail_dialog.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/research/research_material_slot_icon.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/research/research_tree_conduit_painter.dart';

/// Binary research pyramid (16 → … → 1) with shared slot frames and conduit styling.
class ResearchTreeView extends StatelessWidget {
  const ResearchTreeView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final tube = color.treeConduitTubeColor;
    final glow = color.treeConduitGlowColor;

    return LayoutBuilder(
      builder: (context, constraints) {
        const baseRowGap = 14.0;
        const baseMarginV = 10.0;
        
        // 1. Find the slot size that fits the width and a *minimum* height
        final fitted = ResearchTreeGeometry.layoutFitted(
          maxWidth: constraints.maxWidth,
          maxHeight: constraints.maxHeight,
          initialSlotSide: CraftingLayout.inputSlotSide,
          rowGap: baseRowGap,
          marginH: 8,
          marginV: baseMarginV,
        );

        // 2. If we have extra height, stretch the gaps instead of the slots
        var finalRowGap = baseRowGap;
        var finalMarginV = baseMarginV;
        final targetHeight = constraints.maxHeight * 0.95;
        
        if (targetHeight > fitted.height) {
          final extraHeight = targetHeight - fitted.height;
          // Distribute extra height: 70% to gaps, 30% to margins
          finalRowGap = baseRowGap + (extraHeight * 0.7) / 4;
          finalMarginV = baseMarginV + (extraHeight * 0.3) / 2;
        }

        // 3. Final layout with stretched gaps
        final finalGeo = ResearchTreeGeometry.layout(
          maxWidth: constraints.maxWidth,
          slotSide: fitted.slotSide,
          rowGap: finalRowGap,
          marginH: 8,
          marginV: finalMarginV,
        );

        return Center(
          child: SizedBox(
            width: finalGeo.width,
            height: finalGeo.height,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: ResearchTreeConduitPainter(slotRows: finalGeo.rows, tubeColor: tube, glowColor: glow),
                    ),
                  ),
                ),
                for (var t = 0; t < finalGeo.rows.length; t++)
                  for (var i = 0; i < finalGeo.rows[t].length; i++)
                    Positioned(
                      left: finalGeo.rows[t][i].left,
                      top: finalGeo.rows[t][i].top,
                      width: finalGeo.rows[t][i].width,
                      height: finalGeo.rows[t][i].height,
                      child: _ResearchTreeSlot(
                        materialId: ResearchMaterialTree.idForSlot(rowFromTop: t, slotIndex: i),
                        emphasized: t == 0,
                      ),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ResearchTreeSlot extends StatelessWidget {
  const _ResearchTreeSlot({required this.materialId, required this.emphasized});

  final ResearchMaterialId materialId;
  final bool emphasized;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () => showResearchMaterialDetailDialog(context, materialId),
      borderRadius: BorderRadius.circular(10),
      child: GradientSlotFrame(
        emphasized: emphasized,
        showBorder: false,
        child: ResearchMaterialSlotIcon(materialId: materialId),
      ),
    ),
  );
}
