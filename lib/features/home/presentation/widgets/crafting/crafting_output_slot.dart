import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/constants/crafting_layout.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/gradient_slot_frame.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/research/research_material_slot_icon.dart';

class CraftingOutputSlot extends StatelessWidget {
  const CraftingOutputSlot({this.outputMaterialId, this.slotSide, super.key});

  final ResearchMaterialId? outputMaterialId;
  final double? slotSide;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final side = slotSide ?? CraftingLayout.outputSlotSide;
    final material = outputMaterialId;
    final innerRadius = 9.r;

    return SizedBox(
      width: side,
      height: side,
      child: GradientSlotFrame(
        emphasized: true,
        child: material == null
            ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.craftingMainOutputSlot,
                        style: context.styles.compactSupporting.copyWith(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        l10n.craftingSlotEmpty,
                        style: context.styles.compactValue.copyWith(
                          color: context.color.primaryText.withValues(alpha: 0.45),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(innerRadius),
                child: SizedBox.expand(
                  child: ResearchMaterialSlotIcon(materialId: material, fit: BoxFit.cover),
                ),
              ),
      ),
    );
  }
}
