import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/constants/crafting_layout.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/gradient_slot_frame.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/research/research_material_slot_icon.dart';

class CraftingOutputSlot extends StatelessWidget {
  const CraftingOutputSlot({this.outputMaterialId, this.slotSide, this.onTap, super.key});

  final ResearchMaterialId? outputMaterialId;
  final double? slotSide;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final side = slotSide ?? CraftingLayout.outputSlotSide;
    final material = outputMaterialId;
    const innerRadius = 9.0;

    final slot = SizedBox(
      width: side,
      height: side,
      child: GradientSlotFrame(
        emphasized: true,
        child: material == null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.craftingMainOutputSlot,
                        style: context.styles.compactSupporting.copyWith(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 4),
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

    if (onTap == null || material == null) return slot;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: slot,
    );
  }
}
