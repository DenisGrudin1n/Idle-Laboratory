import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/constants/crafting_layout.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/utils/research_tree_geometry.dart';
import 'package:idle_laboratory/core/widgets/gradient_slot_frame.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/research/research_tree_conduit_painter.dart';

/// Binary research pyramid (16 → … → 1) with shared gradient slots and conduit styling.
class ResearchTreeView extends StatelessWidget {
  const ResearchTreeView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final tube = color.primary.withValues(alpha: 0.55);
    final glow = color.primary.withValues(alpha: 0.12);

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
                      child: GradientSlotFrame(
                        emphasized: t == 0,
                        child: const SizedBox.expand(),
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
