import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/research_material_l10n_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/app_dialog.dart';
import 'package:idle_laboratory/core/widgets/gradient_slot_frame.dart';
import 'package:idle_laboratory/core/widgets/info_row.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/research/research_material_slot_icon.dart';

void showResearchMaterialDetailDialog(BuildContext context, ResearchMaterialId materialId) {
  AppDialog.show<void>(context, child: ResearchMaterialDetailBody(materialId: materialId));
}

class ResearchMaterialDetailBody extends StatelessWidget {
  const ResearchMaterialDetailBody({required this.materialId, super.key});

  final ResearchMaterialId materialId;

  static const _iconSide = 48.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = context.color;
    final cost = materialId.baseTierCraftCellCost;
    final slotRadius = 10.r;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: _iconSide.r,
              height: _iconSide.r,
              child: GradientSlotFrame(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(slotRadius),
                  child: ResearchMaterialSlotIcon(materialId: materialId, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(materialId.displayName(l10n), style: context.styles.sectionTitle),
                  SizedBox(height: 4.h),
                  Text(
                    materialId.description(l10n),
                    style: context.styles.sectionHeaderDescription.copyWith(height: 1.3),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(l10n.researchMaterialCraftSection, style: context.styles.bodyLabel),
        SizedBox(height: 6.h),
        if (cost != null)
          InfoRow(
            label: l10n.researchMaterialCellCost,
            value: cost.format(compact: true),
            valueColor: color.green,
            spacing: 6.h,
          ),
        Text(materialId.craftInstructions(l10n), style: context.styles.helperText.copyWith(height: 1.35)),
        SizedBox(height: 12.h),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: color.titleText,
              side: BorderSide(color: color.primary, width: 1.w),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.researchMaterialClose, style: context.styles.buttonLabel.copyWith(fontSize: 11.sp)),
          ),
        ),
      ],
    );
  }
}
