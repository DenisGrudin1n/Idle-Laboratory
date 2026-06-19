// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Idle Laboratory';

  @override
  String get energyUnits => 'Energy Units (EU)';

  @override
  String get perSecond => 'EU/s';

  @override
  String get scientificNotation => 'Scientific Notation';

  @override
  String get on => 'ON';

  @override
  String get off => 'OFF';

  @override
  String get cells => 'Cells';

  @override
  String get crafting => 'Crafting';

  @override
  String get craftingInterfaceTitle => 'Crafting interface';

  @override
  String get craftingInterfaceOverview => 'Combine reagents and a cell to craft new materials.';

  @override
  String craftingReagentSlot(int index) {
    return 'Reagent $index';
  }

  @override
  String get craftingCellSlotTitle => 'Cell';

  @override
  String get craftingMainOutputSlot => 'Main output';

  @override
  String get craftingSlotEmpty => 'Empty';

  @override
  String craftingQuantityMultiplier(int count) {
    return '$count×';
  }

  @override
  String craftingCostWithAmount(String amount) {
    return 'Crafting cost: $amount';
  }

  @override
  String craftingTimeWithDuration(String duration) {
    return 'Craft time: $duration';
  }

  @override
  String get craftingStartReaction => 'Start reaction';

  @override
  String get craftingStopReaction => 'Stop reaction';

  @override
  String get craftingClearInputs => 'Clear inputs';

  @override
  String get craftingNotEnoughMaterials => 'Not enough materials';

  @override
  String get craftingNotEnoughEnergy => 'Not enough energy';

  @override
  String get craftingTargetAmount => 'Amount';

  @override
  String get craftingSelectCellTitle => 'Select cell';

  @override
  String get craftingSelectCellOverview => 'Choose a production cell for the bottom crafting slot.';

  @override
  String get craftingClearCellSelection => 'Clear cell slot';

  @override
  String craftingCellAmount(String amount) {
    return '$amount';
  }

  @override
  String get settings => 'Settings';

  @override
  String get statistics => 'Statistics';

  @override
  String get achievements => 'Achievements';

  @override
  String get energyCells => 'Energy Cells';

  @override
  String get production => 'Production';

  @override
  String get storage => 'Storage';

  @override
  String get storageInventoryTitle => 'Material storage';

  @override
  String get storageInventoryOverview => 'Crafted materials are kept here for research merges and future reactions.';

  @override
  String get research => 'Research';

  @override
  String get overview => 'Overview';

  @override
  String get basicEnergyCell => 'Basic Energy Cell';

  @override
  String get heatCell => 'Heat Cell';

  @override
  String get iceCell => 'Ice Cell';

  @override
  String get steamCell => 'Steam Cell';

  @override
  String get magneticCell => 'Magnetic Cell';

  @override
  String get lightCell => 'Light Cell';

  @override
  String get crystallineCell => 'Crystalline Cell';

  @override
  String get molecularCell => 'Molecular Cell';

  @override
  String get bacterialCell => 'Bacterial Cell';

  @override
  String get geneticCell => 'Genetic Cell';

  @override
  String get bloodCell => 'Blood Cell';

  @override
  String get bioCell => 'Bio Cell';

  @override
  String get radiationCell => 'Radiation Cell';

  @override
  String get nuclearCell => 'Nuclear Cell';

  @override
  String get plasmaCell => 'Plasma Cell';

  @override
  String get darkMatterCell => 'Dark Matter Cell';

  @override
  String get energyType => 'Energy';

  @override
  String get type => 'Type';

  @override
  String get select => 'Select';

  @override
  String get level => 'Level';

  @override
  String get required => 'Required';

  @override
  String get unlockMoreCells => 'Unlock more cells by\nupgrading further.';

  @override
  String get sec => 'sec';

  @override
  String get s => 's';

  @override
  String get unlockAt => 'Unlock at';

  @override
  String get maxLvl => 'Max Lvl';

  @override
  String get nextLvl => 'Next Lvl';

  @override
  String get prestige => 'Prestige';

  @override
  String get prestigeMultiplier => 'Prestige Multiplier';

  @override
  String get currentMultiplier => 'Current';

  @override
  String get nextPrestige => 'Next Prestige';

  @override
  String get totalEnergy => 'Total Energy';

  @override
  String get prestigeRequirement => 'Requirement';

  @override
  String get prestigeBonus => 'Bonus Multiplier';

  @override
  String get prestigeButton => 'Prestige Now';

  @override
  String prestigeLocked(Object requirement) {
    return 'Reach $requirement to unlock';
  }

  @override
  String get prestigeDescription => 'Reset progress for permanent EPS multiplier';

  @override
  String get amount => 'Amount';

  @override
  String get productionRate => 'Production Rate';

  @override
  String get cellsPerSec => 'cells/s';

  @override
  String get energyPerSec => 'EU/s';

  @override
  String get totalProduction => 'Total Production';

  @override
  String get productionOverview => 'Overview of automated cell generation';

  @override
  String totalContribution(Object amount, Object unit) {
    return 'Total contribution from production: $amount $unit';
  }

  @override
  String get accelerate => 'Accelerate';

  @override
  String accelerationCost(Object amount) {
    return 'Cost: $amount';
  }

  @override
  String cellProductionRate(Object amount, Object unit) {
    return '$amount $unit';
  }

  @override
  String get lvl => 'lvl';

  @override
  String get researchMaterialCraftSection => 'How to craft';

  @override
  String researchMaterialCraftFromCell(String amount, String cellName) {
    return 'Place $amount $cellName in the bottom crafting slot (Cell). Leave the two upper reagent slots empty.';
  }

  @override
  String researchMaterialCraftMerge(String leftMaterial, String rightMaterial) {
    return 'Place $leftMaterial and $rightMaterial in the two upper reagent slots, then run the reaction.';
  }

  @override
  String get researchMaterialCellCost => 'Cell cost';

  @override
  String get researchMaterialClose => 'Close';

  @override
  String get researchEnergyCore => 'Energy Core';

  @override
  String get researchEnergyCoreDesc => 'Stabilized EU crystallized from a basic energy cell reaction.';

  @override
  String get researchHeatShard => 'Heat Shard';

  @override
  String get researchHeatShardDesc => 'Obsidian shard forged from concentrated thermal cell output.';

  @override
  String get researchFrostCrystal => 'Frost Crystal';

  @override
  String get researchFrostCrystalDesc => 'Permafrost lattice distilled from ice cell emissions.';

  @override
  String get researchSteamEssence => 'Steam Essence';

  @override
  String get researchSteamEssenceDesc => 'Condensed vapor orb captured from steam cell exhaust.';

  @override
  String get researchMagneticOre => 'Magnetic Ore';

  @override
  String get researchMagneticOreDesc => 'Ferromagnetic chunks aligned by a magnetic cell field.';

  @override
  String get researchLightFragment => 'Light Fragment';

  @override
  String get researchLightFragmentDesc => 'Prismatic shard refracted from a light cell beam.';

  @override
  String get researchCrystalChunk => 'Crystal Chunk';

  @override
  String get researchCrystalChunkDesc => 'Violet geometric mass grown inside a crystalline cell.';

  @override
  String get researchMolecularGel => 'Molecular Gel';

  @override
  String get researchMolecularGelDesc => 'Neon gel lattice synthesized in a molecular cell.';

  @override
  String get researchBacterialSample => 'Bacterial Sample';

  @override
  String get researchBacterialSampleDesc => 'Sterile colony disc cultured in a bacterial cell.';

  @override
  String get researchDnaStrand => 'DNA Strand';

  @override
  String get researchDnaStrandDesc => 'Bioluminescent helix extracted from a genetic cell.';

  @override
  String get researchBloodDrop => 'Blood Drop';

  @override
  String get researchBloodDropDesc => 'Viscous crimson sample drawn from a blood cell core.';

  @override
  String get researchBioMass => 'Bio Mass';

  @override
  String get researchBioMassDesc => 'Organic tissue lump harvested from a bio cell chamber.';

  @override
  String get researchRadiationDust => 'Radiation Dust';

  @override
  String get researchRadiationDustDesc => 'Hazardous powder collected from a radiation cell leak.';

  @override
  String get researchUraniumCore => 'Uranium Core';

  @override
  String get researchUraniumCoreDesc => 'Dense radioactive sphere refined in a nuclear cell.';

  @override
  String get researchPlasmaOrb => 'Plasma Orb';

  @override
  String get researchPlasmaOrbDesc => 'Arcing plasma sphere contained by a plasma cell.';

  @override
  String get researchDarkMatterFragment => 'Dark Matter Fragment';

  @override
  String get researchDarkMatterFragmentDesc => 'Light-bending shard isolated in a dark matter cell.';

  @override
  String get researchThermalCore => 'Thermal Core';

  @override
  String get researchThermalCoreDesc => 'Hybrid hot-cold core merged from heat and frost reagents.';

  @override
  String get researchPhaseCrystal => 'Phase Crystal';

  @override
  String get researchPhaseCrystalDesc => 'Matter that shifts between solid, liquid, and gas states.';

  @override
  String get researchPhotonCore => 'Photon Core';

  @override
  String get researchPhotonCoreDesc => 'White-gold luminous core woven from light and crystal reagents.';

  @override
  String get researchStructuredMatter => 'Structured Matter';

  @override
  String get researchStructuredMatterDesc => 'Nanoscale lattice block from molecular and bacterial samples.';

  @override
  String get researchSynapticLattice => 'Synaptic Lattice';

  @override
  String get researchSynapticLatticeDesc => 'Neural energy mesh grown from genetic and blood reagents.';

  @override
  String get researchOrganicCore => 'Organic Core';

  @override
  String get researchOrganicCoreDesc => 'Seed-like organic sphere from bio and radiation materials.';

  @override
  String get researchNuclearMass => 'Nuclear Mass';

  @override
  String get researchNuclearMassDesc => 'Unstable dense mass fused from uranium and plasma cores.';

  @override
  String get researchVoidPlasma => 'Void Plasma';

  @override
  String get researchVoidPlasmaDesc => 'Void-touched plasma orb from dark matter and thermal reagents.';

  @override
  String get researchEntropyCore => 'Entropy Core';

  @override
  String get researchEntropyCoreDesc => 'Crumbling geometric solid decaying through phase and photon matter.';

  @override
  String get researchQuantumMatrix => 'Quantum Matrix';

  @override
  String get researchQuantumMatrixDesc => 'Probability lattice woven from structured and synaptic matter.';

  @override
  String get researchPrimalOrganism => 'Primal Organism';

  @override
  String get researchPrimalOrganismDesc => 'Ancient micro-organism preserved from organic and nuclear mass.';

  @override
  String get researchAnnihilationCore => 'Annihilation Core';

  @override
  String get researchAnnihilationCoreDesc => 'Matter-antimatter seam forged from void plasma and entropy.';

  @override
  String get researchRealityEngine => 'Reality Engine';

  @override
  String get researchRealityEngineDesc => 'Cosmic mechanism built from quantum and primal reagents.';

  @override
  String get researchAbyssalHeart => 'Abyssal Heart';

  @override
  String get researchAbyssalHeartDesc => 'Dark pulsing heart merged from annihilation and reality cores.';

  @override
  String get researchBloodstoneOfDominion => 'Bloodstone of Dominion';

  @override
  String get researchBloodstoneOfDominionDesc => 'Legendary crowned gem at the apex of the research tree.';
}
