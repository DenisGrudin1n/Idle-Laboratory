import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/research_material_id_ext.dart';

/// Fills the slot’s inner area (inside [GradientSlotFrame]’s stroke) edge-to-edge.
class ResearchMaterialSlotIcon extends StatelessWidget {
  const ResearchMaterialSlotIcon({required this.materialId, super.key});

  final ResearchMaterialId materialId;

  @override
  Widget build(BuildContext context) {
    final path = materialId.materialAssetPath;
    if (path == null) return const SizedBox.expand();

    return SizedBox.expand(
      child: Image.asset(
        path,
        fit: BoxFit.contain,
        gaplessPlayback: true,
        errorBuilder: (_, __, ___) => const SizedBox.expand(),
      ),
    );
  }
}
