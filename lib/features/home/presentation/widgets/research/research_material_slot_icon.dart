import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/research_material_id_ext.dart';

/// Fills the slot’s inner area (inside [GradientSlotFrame]) edge-to-edge.
class ResearchMaterialSlotIcon extends StatelessWidget {
  const ResearchMaterialSlotIcon({
    required this.materialId,
    this.fit = BoxFit.contain,
    super.key,
  });

  final ResearchMaterialId materialId;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final path = materialId.materialAssetPath;
    if (path == null) return const SizedBox.expand();

    return SizedBox.expand(
      child: Image.asset(
        path,
        fit: fit,
        gaplessPlayback: true,
        errorBuilder: (_, __, ___) => const SizedBox.expand(),
      ),
    );
  }
}
