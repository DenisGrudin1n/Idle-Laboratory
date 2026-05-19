import 'package:idle_laboratory/core/constants/image_constants.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';

extension ResearchMaterialIdAssets on ResearchMaterialId {
  /// Asset path when an image exists; otherwise `null` (slot stays empty).
  String? get materialAssetPath => switch (this) {
        ResearchMaterialId.energyCore => '${ImageConstants.materialsDir}/energy-core.png',
        ResearchMaterialId.heatShard => '${ImageConstants.materialsDir}/heat-shard.png',
        ResearchMaterialId.frostCrystal => '${ImageConstants.materialsDir}/frost-crystal.jpeg',
        ResearchMaterialId.steamEssence => '${ImageConstants.materialsDir}/steam-essence.jpeg',
        ResearchMaterialId.magneticOre => '${ImageConstants.materialsDir}/magnetic-ore.jpeg',
        ResearchMaterialId.lightFragment => '${ImageConstants.materialsDir}/light-fragment.jpeg',
        ResearchMaterialId.crystalChunk => '${ImageConstants.materialsDir}/crystal-chunk.jpeg',
        ResearchMaterialId.molecularGel => '${ImageConstants.materialsDir}/molecular-gel.jpeg',
        ResearchMaterialId.bacterialSample => '${ImageConstants.materialsDir}/bacterial-sample.jpg',
        ResearchMaterialId.dnaStrand => '${ImageConstants.materialsDir}/dna-strand.jpg',
        ResearchMaterialId.bloodDrop => '${ImageConstants.materialsDir}/blood-drop.jpg',
        ResearchMaterialId.bioMass => '${ImageConstants.materialsDir}/bio-mass.jpeg',
        ResearchMaterialId.radiationDust => '${ImageConstants.materialsDir}/radiation-dust.jpeg',
        ResearchMaterialId.uraniumCore => '${ImageConstants.materialsDir}/uranium-core.jpeg',
        ResearchMaterialId.plasmaOrb => '${ImageConstants.materialsDir}/plasma-orb.jpeg',
        ResearchMaterialId.darkMatterFragment => '${ImageConstants.materialsDir}/dark-matter-fragment.jpeg',
        ResearchMaterialId.thermalCore => '${ImageConstants.materialsDir}/thermal-core.jpeg',
        ResearchMaterialId.phaseCrystal => '${ImageConstants.materialsDir}/phase-crystal.jpeg',
        ResearchMaterialId.photonCore => '${ImageConstants.materialsDir}/photone-core.jpeg',
        ResearchMaterialId.structuredMatter => '${ImageConstants.materialsDir}/structured-matter.jpg',
        ResearchMaterialId.synapticLattice => '${ImageConstants.materialsDir}/synaptic-lattice.jpg',
        ResearchMaterialId.organicCore => '${ImageConstants.materialsDir}/organic-core.jpg',
        ResearchMaterialId.nuclearMass => '${ImageConstants.materialsDir}/nuclear-mass.jpg',
        ResearchMaterialId.voidPlasma => '${ImageConstants.materialsDir}/void-plasma.jpg',
        ResearchMaterialId.entropyCore => '${ImageConstants.materialsDir}/entropy-core.jpg',
        ResearchMaterialId.quantumMatrix => '${ImageConstants.materialsDir}/quantum-matrix.jpg',
        ResearchMaterialId.primalOrganism => '${ImageConstants.materialsDir}/primal-organism.jpg',
        ResearchMaterialId.annihilationCore => '${ImageConstants.materialsDir}/annihilation-core.jpg',
        ResearchMaterialId.realityEngine => '${ImageConstants.materialsDir}/reality-engine.jpg',
        ResearchMaterialId.abyssalHeart => '${ImageConstants.materialsDir}/abyssal-heart.jpg',
        ResearchMaterialId.bloodstoneOfDominion => '${ImageConstants.materialsDir}/bloodstone-of-dominion.jpg',
      };
}
