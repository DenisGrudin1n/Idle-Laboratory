import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/research_material_l10n_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/app_dialog.dart';
import 'package:idle_laboratory/core/widgets/gradient_slot_frame.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/storage/storage_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/research/research_material_slot_icon.dart';

Future<ResearchMaterialId?> showCraftingMaterialPickerDialog(BuildContext context, {required bool allowClear}) =>
    AppDialog.show<ResearchMaterialId?>(
      context,
      maxWidth: 560.w,
      padding: EdgeInsets.all(14.w),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: _CraftingMaterialPickerBody(allowClear: allowClear),
    );

class _CraftingMaterialPickerBody extends StatelessWidget {
  const _CraftingMaterialPickerBody({required this.allowClear});

  final bool allowClear;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SizedBox(
      height: 0.62.sh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.storageInventoryTitle, style: context.styles.sectionHeaderTitle),
          SizedBox(height: 4.h),
          Text(l10n.storageInventoryOverview, style: context.styles.sectionHeaderDescription),
          SizedBox(height: 12.h),
          Expanded(
            child: BlocSelector<StorageBloc, StorageState, Map<ResearchMaterialId, int>>(
              selector: (state) => state.inventory,
              builder: (context, inventory) {
                final stocked = ResearchMaterialId.values.where((m) => (inventory[m] ?? 0) > 0).toList();

                if (stocked.isEmpty && !allowClear) {
                  return Center(
                    child: Text(l10n.craftingSlotEmpty, style: context.styles.helperText, textAlign: TextAlign.center),
                  );
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                  ),
                  itemCount: stocked.length + (allowClear ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (allowClear && index == 0) {
                      return _ClearMaterialTile(onTap: () => Navigator.of(context).pop());
                    }
                    final materialIndex = allowClear ? index - 1 : index;
                    final materialId = stocked[materialIndex];
                    final count = inventory[materialId] ?? 0;

                    return _PickerMaterialTile(
                      materialId: materialId,
                      count: count,
                      onSelected: () => Navigator.of(context).pop(materialId),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ClearMaterialTile extends StatelessWidget {
  const _ClearMaterialTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final l10n = context.l10n;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Ink(
          decoration: BoxDecoration(
            color: color.background.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: color.titleText.withValues(alpha: 0.35), width: 1.w),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.close_rounded, color: color.primaryText, size: 24.sp),
              SizedBox(height: 4.h),
              Text(
                l10n.craftingClearInputs,
                style: context.styles.compactSupporting.copyWith(fontSize: 8.sp),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickerMaterialTile extends StatelessWidget {
  const _PickerMaterialTile({required this.materialId, required this.count, required this.onSelected});

  final ResearchMaterialId materialId;
  final int count;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final l10n = context.l10n;
    final countLabel = l10n.craftingQuantityMultiplier(count);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSelected,
        borderRadius: BorderRadius.circular(10.r),
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GradientSlotFrame(emphasized: true, child: ResearchMaterialSlotIcon(materialId: materialId)),
                    Positioned(
                      right: -2.w,
                      top: -2.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: color.background.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(color: color.green.withValues(alpha: 0.5), width: 1.w),
                        ),
                        child: Text(
                          countLabel,
                          style: context.styles.successText.copyWith(fontSize: 8.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              materialId.displayName(l10n),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.styles.compactValue.copyWith(color: color.titleText, fontSize: 8.sp),
            ),
          ],
        ),
      ),
    );
  }
}
