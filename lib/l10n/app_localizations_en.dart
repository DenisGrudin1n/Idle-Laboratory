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
  String get tutorialWelcomeTitle => 'Welcome to Idle Laboratory!';

  @override
  String get tutorialWelcomeDesc =>
      'You are an apprentice alchemist in this laboratory. Produce energy, craft materials, and follow the magician\'s guidance — every spark matters.';

  @override
  String get prologueStep1Title => 'A New Laboratory';

  @override
  String get prologueStep1Desc =>
      'Welcome, apprentice. I am the keeper of this place — titles matter less than the work ahead.\n\nI have searched long for someone with steady hands and a curious mind. Beyond these walls the world grows thin and brittle: storms of energy crack where they should not, and light fades from places that once thrived.\n\nTogether, I believe we can mend it.';

  @override
  String get prologueStep2Title => 'Our Shared Purpose';

  @override
  String get prologueStep2Desc =>
      'Here you will grow energy cells, craft reagents, and climb the Research Tree — one careful reaction at a time.\n\nAt its summit sleeps a relic of immense promise: the Bloodstone of Dominion. Legends say it can restore balance — seal wounds in the land, quiet chaos, and open a kinder age.\n\nI will guide you. Trust the process. Every spark you farm, every merge you complete, brings that stone — and hope — closer.';

  @override
  String get prologueNext => 'NEXT';

  @override
  String get prologueBegin => 'BEGIN';

  @override
  String get tutorialEnergyTitle => 'Energy & EPS';

  @override
  String get tutorialEnergyDesc =>
      'This section shows your total Energy Units (EU) and your current Energy Per Second (EPS). Energy is the lifeblood of your laboratory.';

  @override
  String get tutorialMainNavTitle => 'Main Navigation';

  @override
  String get tutorialMainNavDesc =>
      'Use this sidebar to switch between different areas of your laboratory: Cells, Crafting, Storage, and more.';

  @override
  String get tutorialSubTabsTitle => 'Sub-Tabs';

  @override
  String get tutorialSubTabsDesc =>
      'Each main section has sub-tabs. For example, in the Cells section, you can switch between Energy Cells, Production, and Overview.';

  @override
  String get tutorialCellsListTitle => 'Energy Cells';

  @override
  String get tutorialCellsListDesc =>
      'Here you can see your energy cells. Level them up to increase your EPS. Each cell type has unique properties.';

  @override
  String get tutorialPrestigeTitle => 'Prestige';

  @override
  String get tutorialPrestigeDesc =>
      'When you reach enough energy, you can Prestige. This resets your progress but gives you a permanent multiplier to your EPS.';

  @override
  String get tutorialNext => 'NEXT';

  @override
  String get tutorialSkip => 'SKIP';

  @override
  String get tutorialProductionTitle => 'Production';

  @override
  String get tutorialProductionDesc =>
      'In this tab, your cells automatically generate more of themselves over time. You can accelerate this process by spending energy to upgrade each cell\'s level.';

  @override
  String get tutorialCraftingTitle => 'Crafting Interface';

  @override
  String get tutorialCraftingDesc =>
      'This is where you combine your resources to create advanced materials. You can use cells and other materials as reagents to run powerful reactions.';

  @override
  String get tutorialCraftingCellSlotTitle => 'Cell Slot';

  @override
  String get tutorialCraftingCellSlotDesc =>
      'The bottom slot is specifically for energy cells. Some recipes require a certain amount of a specific cell type to proceed.';

  @override
  String get tutorialCraftingMaterialSlotsTitle => 'Material Slots';

  @override
  String get tutorialCraftingMaterialSlotsDesc =>
      'The two upper slots are for research materials. Combine different materials here to discover higher-tier resources.';

  @override
  String get tutorialCraftingOutputSlotTitle => 'Output Slot';

  @override
  String get tutorialCraftingOutputSlotDesc =>
      'The result of your crafting reaction will appear here. Tap it to start the reaction once all reagents are placed.';

  @override
  String get tutorialCraftingInfoTitle => 'Reaction Info';

  @override
  String get tutorialCraftingInfoDesc =>
      'Here you can see the energy cost, time required, and the target amount for your reaction. Use the \'Start reaction\' button to begin.';

  @override
  String get tutorialStorageTitle => 'Material Storage';

  @override
  String get tutorialStorageDesc =>
      'All your crafted materials are stored here. You can see your current inventory and use these materials for further research and crafting.';

  @override
  String get tutorialResearchTitle => 'Research Tree';

  @override
  String get tutorialResearchDesc =>
      'The Research Tree shows the path to the ultimate alchemical goals. Discover new materials by merging lower-tier ones in the crafting interface.';

  @override
  String get tutorialResearchGoalTitle => 'The Ultimate Goal';

  @override
  String get tutorialResearchGoalDesc =>
      'At the peak of the Research Tree waits the Bloodstone of Dominion. With it, the magician believes we can reshape the world — heal what is broken, open paths once closed, and finally achieve what ordinary power never could. Your journey leads here.';

  @override
  String get endingRevealTitle => 'The Mask Falls';

  @override
  String get endingRevealDesc =>
      'Ah… at last. You have done it. The Bloodstone of Dominion is mine!\n\nDid you truly think I sought this gem to mend the world? How charming. While you farmed, merged, and trusted me, I only needed a willing pair of hands.\n\nNow the stone answers to me — and with it, I shall bend kingdoms, silence rivals, and claim dominion over all. Your laboratory was never a sanctuary.\n\nIt was my forge.';

  @override
  String get endingRevealContinue => 'CONTINUE';

  @override
  String get endingToBeContinuedTitle => 'To Be Continued';

  @override
  String get endingToBeContinuedDesc =>
      'The Bloodstone has awakened a darker chapter… but that tale belongs to another time.\n\nThank you for playing Idle Laboratory.';

  @override
  String get endingToBeContinuedClose => 'CLOSE';

  @override
  String get storyBeatDarkMatterUnlockTitle => 'An Unusual Curiosity';

  @override
  String get storyBeatDarkMatterUnlockDesc =>
      'Dark matter… remarkable. You have opened the final frontier of the cell lattice — and I confess, this energy intrigues me personally.\n\nNot merely as your guide, but as one who has studied the hidden currents of the world. Press on. I wish to see what this curious power reveals.';

  @override
  String get storyBeatDarkMatterProductionMaxTitle => 'Pushed to the Limit';

  @override
  String get storyBeatDarkMatterProductionMaxDesc =>
      'Maximum acceleration on the dark matter line — excellent. The throughput you have coaxed from it is… satisfying.\n\nDo not mistake my enthusiasm for mere mentorship. There is a hunger in this work that suits us both. More. Always more.';

  @override
  String get storyBeatBloodDropTitle => 'Crimson Reagent';

  @override
  String get storyBeatBloodDropDesc =>
      'Blood drop… life distilled into reagent. You have crossed a threshold few laboratories ever reach.\n\nI feel it — a thread of vital force, answerable to the right will. Continue your craft. We are gathering something far greater than raw materials.';

  @override
  String get storyBeatAbyssalHeartTitle => 'The Depths Answer';

  @override
  String get storyBeatAbyssalHeartDesc =>
      'The Abyssal Heart… at last it beats in your vault. Can you sense it? Power no longer distant — close enough to taste.\n\nI am… pleased. More than pleased. Stay the course, partner. What we are building will soon be within my — our grasp.';

  @override
  String get storyLoreContinue => 'CONTINUE';

  @override
  String get debugCraftBloodstone => 'Debug: Craft Bloodstone';

  @override
  String get debugStoryBeatDarkMatterUnlock => 'Debug: Lore — Dark Matter Unlock';

  @override
  String get debugStoryBeatDarkMatterProductionMax => 'Debug: Lore — Dark Matter Prod Max';

  @override
  String get debugStoryBeatBloodDrop => 'Debug: Lore — First Blood Drop';

  @override
  String get debugStoryBeatAbyssalHeart => 'Debug: Lore — Abyssal Heart';

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
  String get accelerateMax => 'Accelerate max';

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
  String get researchBloodstoneOfDominionDesc =>
      'A legendary crowned gem at the apex of the research tree — said to grant the power to reshape destiny itself.';
}
