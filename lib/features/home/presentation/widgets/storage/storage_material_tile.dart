import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/research_material_l10n_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/gradient_slot_frame.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/research/research_material_detail_dialog.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/research/research_material_slot_icon.dart';

/// One material in the storage grid (icon slot + name + stack count).
class StorageMaterialTile extends StatelessWidget {
  const StorageMaterialTile({
    required this.materialId,
    this.count = 0,
    super.key,
  });

  final ResearchMaterialId materialId;
  final int count;

  bool get _hasStock => count > 0;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final l10n = context.l10n;
    final countLabel = count > 0 ? l10n.craftingQuantityMultiplier(count) : '0';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => showResearchMaterialDetailDialog(context, materialId),
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GradientSlotFrame(
                      emphasized: _hasStock,
                      showBorder: _hasStock,
                      child: Opacity(
                        opacity: _hasStock ? 1 : 0.42,
                        child: ResearchMaterialSlotIcon(materialId: materialId),
                      ),
                    ),
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: color.background.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: _hasStock ? color.green.withValues(alpha: 0.5) : color.primary.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          countLabel,
                          style: (_hasStock ? context.styles.successText : context.styles.compactValue).copyWith(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              materialId.displayName(l10n),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.styles.compactValue.copyWith(
                color: _hasStock ? color.titleText : color.primaryText.withValues(alpha: 0.65),
                fontSize: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
