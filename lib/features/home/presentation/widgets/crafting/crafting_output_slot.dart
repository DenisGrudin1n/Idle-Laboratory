import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/constants/crafting_layout.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/app_border_container.dart';
import 'package:idle_laboratory/core/widgets/gradient_slot_frame.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
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

    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isMobile = appVersion == AppVersionEnum.mobile;
        final radius = isMobile ? 16.0 : 24.0;
        final innerRadius = radius - 1.0;

        final child = material == null
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
              );

        final slot = SizedBox(
          width: side,
          height: side,
          child: AppBorderContainer(
            isActive: true,
            activeBorderColor: context.color.titleText,
            borderRadius: radius,
            borderWidth: 1,
            child: GradientSlotFrame(emphasized: true, showBorder: false, borderRadius: radius, child: child),
          ),
        );

        if (onTap == null || material == null) return slot;

        return GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: slot);
      },
    );
  }
}
