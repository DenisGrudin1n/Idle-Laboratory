import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        final fitted = ResearchTreeGeometry.layoutFitted(
          maxWidth: constraints.maxWidth,
          maxHeight: constraints.maxHeight,
          initialSlotSide: CraftingLayout.inputSlotSide,
          rowGap: 14.h,
          marginH: 8.w,
          marginV: 10.h,
        );

        return FittedBox(
          child: SizedBox(
            width: fitted.width,
            height: fitted.height,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: ResearchTreeConduitPainter(
                        slotRows: fitted.rows,
                        tubeColor: tube,
                        glowColor: glow,
                      ),
                    ),
                  ),
                ),
                for (var t = 0; t < fitted.rows.length; t++)
                  for (var i = 0; i < fitted.rows[t].length; i++)
                    Positioned(
                      left: fitted.rows[t][i].left,
                      top: fitted.rows[t][i].top,
                      width: fitted.rows[t][i].width,
                      height: fitted.rows[t][i].height,
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
          borderRadius: BorderRadius.circular(10.r),
          child: GradientSlotFrame(
            emphasized: emphasized,
            showBorder: false,
            child: ResearchMaterialSlotIcon(materialId: materialId),
          ),
        ),
      );
}
