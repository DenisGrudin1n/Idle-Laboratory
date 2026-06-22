import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/research_material_l10n_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/app_dialog.dart';
import 'package:idle_laboratory/core/widgets/gradient_slot_frame.dart';
import 'package:idle_laboratory/core/widgets/info_row.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
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
    const slotRadius = 10.0;

    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isMobile = appVersion == AppVersionEnum.mobile;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: _iconSide,
                  height: _iconSide,
                  child: GradientSlotFrame(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(slotRadius),
                      child: ResearchMaterialSlotIcon(materialId: materialId, fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(materialId.displayName(l10n), style: context.styles.sectionTitle),
                      const SizedBox(height: 4),
                      Text(
                        materialId.description(l10n),
                        style: context.styles.sectionHeaderDescription.copyWith(height: 1.3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(l10n.researchMaterialCraftSection, style: context.styles.bodyLabel),
            const SizedBox(height: 6),
            if (cost != null)
              InfoRow(
                label: l10n.researchMaterialCellCost,
                value: cost.format(compact: true),
                valueColor: color.green,
                spacing: 6,
              ),
            Text(materialId.craftInstructions(l10n), style: context.styles.helperText.copyWith(height: 1.35)),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: color.titleText,
                  side: BorderSide(color: color.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: isMobile ? 5 : 8),
                  minimumSize: isMobile ? Size.zero : const Size(60, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.researchMaterialClose, style: context.styles.buttonLabel.copyWith(fontSize: 11)),
              ),
            ),
          ],
        );
      },
    );
  }
}
