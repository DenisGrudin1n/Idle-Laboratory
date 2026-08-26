import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/storage/storage_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/controllers/tutorial_controller.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/storage/storage_material_tile.dart';

/// Inventory grid for crafted research materials.
class StorageContent extends StatelessWidget {
  const StorageContent({super.key});

  static final _materials = List<ResearchMaterialId>.unmodifiable(ResearchMaterialId.values);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SectionCard(
      key: TutorialController.storageContainerKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.storageInventoryTitle, style: context.styles.sectionHeaderTitle),
            const SizedBox(height: 4),
            Text(l10n.storageInventoryOverview, style: context.styles.compactValue),
            const SizedBox(height: 16),
            Expanded(
              child: BlocSelector<StorageBloc, StorageState, Map<ResearchMaterialId, int>>(
                selector: (state) => state.inventory,
                builder: (context, inventory) => GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _materials.length,
                  itemBuilder: (context, index) {
                    final materialId = _materials[index];
                    return StorageMaterialTile(
                      materialId: materialId,
                      count: inventory[materialId] ?? 0,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
