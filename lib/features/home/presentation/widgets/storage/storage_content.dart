import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/storage/storage_material_tile.dart';

/// Inventory grid for crafted research materials (counts wired when storage bloc exists).
class StorageContent extends StatelessWidget {
  const StorageContent({super.key});

  static final _materials = List<ResearchMaterialId>.unmodifiable(ResearchMaterialId.values);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SectionCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.storageInventoryTitle, style: context.styles.sectionHeaderTitle),
            SizedBox(height: 4.h),
            Text(l10n.storageInventoryOverview, style: context.styles.compactValue),
            SizedBox(height: 16.h),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                ),
                itemCount: _materials.length,
                itemBuilder: (context, index) => StorageMaterialTile(materialId: _materials[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
