import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/cell_id_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/core/utils/research_material_tree.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

extension ResearchMaterialIdMeta on ResearchMaterialId {
  static const baseTierCount = 16;

  int get linearIndex => index;

  bool get isBaseTier => index < baseTierCount;

  CellId? get sourceCellId => isBaseTier ? CellId.values[index] : null;

  BigNumber? get baseTierCraftCellCost =>
      isBaseTier ? GameBalance.calculateBaseTierResearchCraftCellCost(index) : null;

  String displayName(AppLocalizations l10n) => switch (this) {
        ResearchMaterialId.energyCore => l10n.researchEnergyCore,
        ResearchMaterialId.heatShard => l10n.researchHeatShard,
        ResearchMaterialId.frostCrystal => l10n.researchFrostCrystal,
        ResearchMaterialId.steamEssence => l10n.researchSteamEssence,
        ResearchMaterialId.magneticOre => l10n.researchMagneticOre,
        ResearchMaterialId.lightFragment => l10n.researchLightFragment,
        ResearchMaterialId.crystalChunk => l10n.researchCrystalChunk,
        ResearchMaterialId.molecularGel => l10n.researchMolecularGel,
        ResearchMaterialId.bacterialSample => l10n.researchBacterialSample,
        ResearchMaterialId.dnaStrand => l10n.researchDnaStrand,
        ResearchMaterialId.bloodDrop => l10n.researchBloodDrop,
        ResearchMaterialId.bioMass => l10n.researchBioMass,
        ResearchMaterialId.radiationDust => l10n.researchRadiationDust,
        ResearchMaterialId.uraniumCore => l10n.researchUraniumCore,
        ResearchMaterialId.plasmaOrb => l10n.researchPlasmaOrb,
        ResearchMaterialId.darkMatterFragment => l10n.researchDarkMatterFragment,
        ResearchMaterialId.thermalCore => l10n.researchThermalCore,
        ResearchMaterialId.phaseCrystal => l10n.researchPhaseCrystal,
        ResearchMaterialId.photonCore => l10n.researchPhotonCore,
        ResearchMaterialId.structuredMatter => l10n.researchStructuredMatter,
        ResearchMaterialId.synapticLattice => l10n.researchSynapticLattice,
        ResearchMaterialId.organicCore => l10n.researchOrganicCore,
        ResearchMaterialId.nuclearMass => l10n.researchNuclearMass,
        ResearchMaterialId.voidPlasma => l10n.researchVoidPlasma,
        ResearchMaterialId.entropyCore => l10n.researchEntropyCore,
        ResearchMaterialId.quantumMatrix => l10n.researchQuantumMatrix,
        ResearchMaterialId.primalOrganism => l10n.researchPrimalOrganism,
        ResearchMaterialId.annihilationCore => l10n.researchAnnihilationCore,
        ResearchMaterialId.realityEngine => l10n.researchRealityEngine,
        ResearchMaterialId.abyssalHeart => l10n.researchAbyssalHeart,
        ResearchMaterialId.bloodstoneOfDominion => l10n.researchBloodstoneOfDominion,
      };

  String description(AppLocalizations l10n) => switch (this) {
        ResearchMaterialId.energyCore => l10n.researchEnergyCoreDesc,
        ResearchMaterialId.heatShard => l10n.researchHeatShardDesc,
        ResearchMaterialId.frostCrystal => l10n.researchFrostCrystalDesc,
        ResearchMaterialId.steamEssence => l10n.researchSteamEssenceDesc,
        ResearchMaterialId.magneticOre => l10n.researchMagneticOreDesc,
        ResearchMaterialId.lightFragment => l10n.researchLightFragmentDesc,
        ResearchMaterialId.crystalChunk => l10n.researchCrystalChunkDesc,
        ResearchMaterialId.molecularGel => l10n.researchMolecularGelDesc,
        ResearchMaterialId.bacterialSample => l10n.researchBacterialSampleDesc,
        ResearchMaterialId.dnaStrand => l10n.researchDnaStrandDesc,
        ResearchMaterialId.bloodDrop => l10n.researchBloodDropDesc,
        ResearchMaterialId.bioMass => l10n.researchBioMassDesc,
        ResearchMaterialId.radiationDust => l10n.researchRadiationDustDesc,
        ResearchMaterialId.uraniumCore => l10n.researchUraniumCoreDesc,
        ResearchMaterialId.plasmaOrb => l10n.researchPlasmaOrbDesc,
        ResearchMaterialId.darkMatterFragment => l10n.researchDarkMatterFragmentDesc,
        ResearchMaterialId.thermalCore => l10n.researchThermalCoreDesc,
        ResearchMaterialId.phaseCrystal => l10n.researchPhaseCrystalDesc,
        ResearchMaterialId.photonCore => l10n.researchPhotonCoreDesc,
        ResearchMaterialId.structuredMatter => l10n.researchStructuredMatterDesc,
        ResearchMaterialId.synapticLattice => l10n.researchSynapticLatticeDesc,
        ResearchMaterialId.organicCore => l10n.researchOrganicCoreDesc,
        ResearchMaterialId.nuclearMass => l10n.researchNuclearMassDesc,
        ResearchMaterialId.voidPlasma => l10n.researchVoidPlasmaDesc,
        ResearchMaterialId.entropyCore => l10n.researchEntropyCoreDesc,
        ResearchMaterialId.quantumMatrix => l10n.researchQuantumMatrixDesc,
        ResearchMaterialId.primalOrganism => l10n.researchPrimalOrganismDesc,
        ResearchMaterialId.annihilationCore => l10n.researchAnnihilationCoreDesc,
        ResearchMaterialId.realityEngine => l10n.researchRealityEngineDesc,
        ResearchMaterialId.abyssalHeart => l10n.researchAbyssalHeartDesc,
        ResearchMaterialId.bloodstoneOfDominion => l10n.researchBloodstoneOfDominionDesc,
      };

  String craftInstructions(AppLocalizations l10n) {
    if (isBaseTier) {
      final cell = sourceCellId!;
      final amount = baseTierCraftCellCost!.format(compact: true);
      return l10n.researchMaterialCraftFromCell(amount, cell.cellName.localize(l10n));
    }
    final inputs = ResearchMaterialTree.childIndices(index);
    if (inputs == null) return description(l10n);
    final left = ResearchMaterialId.values[inputs.$1].displayName(l10n);
    final right = ResearchMaterialId.values[inputs.$2].displayName(l10n);
    return l10n.researchMaterialCraftMerge(left, right);
  }
}
