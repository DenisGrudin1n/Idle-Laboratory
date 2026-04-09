import 'package:idle_laboratory/core/constants/image_constants.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';

extension ResearchMaterialIdAssets on ResearchMaterialId {
  /// Asset path when a PNG exists; otherwise `null` (slot stays empty).
  String? get materialAssetPath => switch (this) {
        ResearchMaterialId.energyCore => '${ImageConstants.materialsDir}/energy-core.png',
        ResearchMaterialId.heatShard => '${ImageConstants.materialsDir}/heat-shard.png',
        _ => null,
      };
}
