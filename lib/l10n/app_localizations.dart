import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Idle Laboratory'**
  String get appTitle;

  /// No description provided for @energyUnits.
  ///
  /// In en, this message translates to:
  /// **'Energy Units (EU)'**
  String get energyUnits;

  /// No description provided for @perSecond.
  ///
  /// In en, this message translates to:
  /// **'EU/s'**
  String get perSecond;

  /// No description provided for @scientificNotation.
  ///
  /// In en, this message translates to:
  /// **'Scientific Notation'**
  String get scientificNotation;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'ON'**
  String get on;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'OFF'**
  String get off;

  /// No description provided for @cells.
  ///
  /// In en, this message translates to:
  /// **'Cells'**
  String get cells;

  /// No description provided for @crafting.
  ///
  /// In en, this message translates to:
  /// **'Crafting'**
  String get crafting;

  /// No description provided for @craftingInterfaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Crafting interface'**
  String get craftingInterfaceTitle;

  /// No description provided for @craftingInterfaceOverview.
  ///
  /// In en, this message translates to:
  /// **'Combine reagents and a cell to craft new materials.'**
  String get craftingInterfaceOverview;

  /// No description provided for @craftingReagentSlot.
  ///
  /// In en, this message translates to:
  /// **'Reagent {index}'**
  String craftingReagentSlot(int index);

  /// No description provided for @craftingCellSlotTitle.
  ///
  /// In en, this message translates to:
  /// **'Cell'**
  String get craftingCellSlotTitle;

  /// No description provided for @craftingMainOutputSlot.
  ///
  /// In en, this message translates to:
  /// **'Main output'**
  String get craftingMainOutputSlot;

  /// No description provided for @craftingSlotEmpty.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get craftingSlotEmpty;

  /// No description provided for @craftingQuantityMultiplier.
  ///
  /// In en, this message translates to:
  /// **'{count}×'**
  String craftingQuantityMultiplier(int count);

  /// No description provided for @craftingCostWithAmount.
  ///
  /// In en, this message translates to:
  /// **'Crafting cost: {amount}'**
  String craftingCostWithAmount(String amount);

  /// No description provided for @craftingTimeWithDuration.
  ///
  /// In en, this message translates to:
  /// **'Craft time: {duration}'**
  String craftingTimeWithDuration(String duration);

  /// No description provided for @craftingStartReaction.
  ///
  /// In en, this message translates to:
  /// **'Start reaction'**
  String get craftingStartReaction;

  /// No description provided for @craftingClearInputs.
  ///
  /// In en, this message translates to:
  /// **'Clear inputs'**
  String get craftingClearInputs;

  /// No description provided for @craftingSelectCellTitle.
  ///
  /// In en, this message translates to:
  /// **'Select cell'**
  String get craftingSelectCellTitle;

  /// No description provided for @craftingSelectCellOverview.
  ///
  /// In en, this message translates to:
  /// **'Choose a production cell for the bottom crafting slot.'**
  String get craftingSelectCellOverview;

  /// No description provided for @craftingClearCellSelection.
  ///
  /// In en, this message translates to:
  /// **'Clear cell slot'**
  String get craftingClearCellSelection;

  /// No description provided for @craftingCellAmount.
  ///
  /// In en, this message translates to:
  /// **'{amount}'**
  String craftingCellAmount(String amount);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @energyCells.
  ///
  /// In en, this message translates to:
  /// **'Energy Cells'**
  String get energyCells;

  /// No description provided for @production.
  ///
  /// In en, this message translates to:
  /// **'Production'**
  String get production;

  /// No description provided for @storage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get storage;

  /// No description provided for @storageInventoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Material storage'**
  String get storageInventoryTitle;

  /// No description provided for @storageInventoryOverview.
  ///
  /// In en, this message translates to:
  /// **'Crafted materials are kept here for research merges and future reactions.'**
  String get storageInventoryOverview;

  /// No description provided for @research.
  ///
  /// In en, this message translates to:
  /// **'Research'**
  String get research;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @basicEnergyCell.
  ///
  /// In en, this message translates to:
  /// **'Basic Energy Cell'**
  String get basicEnergyCell;

  /// No description provided for @heatCell.
  ///
  /// In en, this message translates to:
  /// **'Heat Cell'**
  String get heatCell;

  /// No description provided for @iceCell.
  ///
  /// In en, this message translates to:
  /// **'Ice Cell'**
  String get iceCell;

  /// No description provided for @steamCell.
  ///
  /// In en, this message translates to:
  /// **'Steam Cell'**
  String get steamCell;

  /// No description provided for @magneticCell.
  ///
  /// In en, this message translates to:
  /// **'Magnetic Cell'**
  String get magneticCell;

  /// No description provided for @lightCell.
  ///
  /// In en, this message translates to:
  /// **'Light Cell'**
  String get lightCell;

  /// No description provided for @crystallineCell.
  ///
  /// In en, this message translates to:
  /// **'Crystalline Cell'**
  String get crystallineCell;

  /// No description provided for @molecularCell.
  ///
  /// In en, this message translates to:
  /// **'Molecular Cell'**
  String get molecularCell;

  /// No description provided for @bacterialCell.
  ///
  /// In en, this message translates to:
  /// **'Bacterial Cell'**
  String get bacterialCell;

  /// No description provided for @geneticCell.
  ///
  /// In en, this message translates to:
  /// **'Genetic Cell'**
  String get geneticCell;

  /// No description provided for @bloodCell.
  ///
  /// In en, this message translates to:
  /// **'Blood Cell'**
  String get bloodCell;

  /// No description provided for @bioCell.
  ///
  /// In en, this message translates to:
  /// **'Bio Cell'**
  String get bioCell;

  /// No description provided for @radiationCell.
  ///
  /// In en, this message translates to:
  /// **'Radiation Cell'**
  String get radiationCell;

  /// No description provided for @nuclearCell.
  ///
  /// In en, this message translates to:
  /// **'Nuclear Cell'**
  String get nuclearCell;

  /// No description provided for @plasmaCell.
  ///
  /// In en, this message translates to:
  /// **'Plasma Cell'**
  String get plasmaCell;

  /// No description provided for @darkMatterCell.
  ///
  /// In en, this message translates to:
  /// **'Dark Matter Cell'**
  String get darkMatterCell;

  /// No description provided for @energyType.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get energyType;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @unlockMoreCells.
  ///
  /// In en, this message translates to:
  /// **'Unlock more cells by\nupgrading further.'**
  String get unlockMoreCells;

  /// No description provided for @sec.
  ///
  /// In en, this message translates to:
  /// **'sec'**
  String get sec;

  /// No description provided for @s.
  ///
  /// In en, this message translates to:
  /// **'s'**
  String get s;

  /// No description provided for @unlockAt.
  ///
  /// In en, this message translates to:
  /// **'Unlock at'**
  String get unlockAt;

  /// No description provided for @maxLvl.
  ///
  /// In en, this message translates to:
  /// **'Max Lvl'**
  String get maxLvl;

  /// No description provided for @nextLvl.
  ///
  /// In en, this message translates to:
  /// **'Next Lvl'**
  String get nextLvl;

  /// No description provided for @prestige.
  ///
  /// In en, this message translates to:
  /// **'Prestige'**
  String get prestige;

  /// No description provided for @prestigeMultiplier.
  ///
  /// In en, this message translates to:
  /// **'Prestige Multiplier'**
  String get prestigeMultiplier;

  /// No description provided for @currentMultiplier.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get currentMultiplier;

  /// No description provided for @nextPrestige.
  ///
  /// In en, this message translates to:
  /// **'Next Prestige'**
  String get nextPrestige;

  /// No description provided for @totalEnergy.
  ///
  /// In en, this message translates to:
  /// **'Total Energy'**
  String get totalEnergy;

  /// No description provided for @prestigeRequirement.
  ///
  /// In en, this message translates to:
  /// **'Requirement'**
  String get prestigeRequirement;

  /// No description provided for @prestigeBonus.
  ///
  /// In en, this message translates to:
  /// **'Bonus Multiplier'**
  String get prestigeBonus;

  /// No description provided for @prestigeButton.
  ///
  /// In en, this message translates to:
  /// **'Prestige Now'**
  String get prestigeButton;

  /// No description provided for @prestigeLocked.
  ///
  /// In en, this message translates to:
  /// **'Reach {requirement} to unlock'**
  String prestigeLocked(Object requirement);

  /// No description provided for @prestigeDescription.
  ///
  /// In en, this message translates to:
  /// **'Reset progress for permanent EPS multiplier'**
  String get prestigeDescription;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @productionRate.
  ///
  /// In en, this message translates to:
  /// **'Production Rate'**
  String get productionRate;

  /// No description provided for @cellsPerSec.
  ///
  /// In en, this message translates to:
  /// **'cells/s'**
  String get cellsPerSec;

  /// No description provided for @energyPerSec.
  ///
  /// In en, this message translates to:
  /// **'EU/s'**
  String get energyPerSec;

  /// No description provided for @totalProduction.
  ///
  /// In en, this message translates to:
  /// **'Total Production'**
  String get totalProduction;

  /// No description provided for @productionOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview of automated cell generation'**
  String get productionOverview;

  /// No description provided for @totalContribution.
  ///
  /// In en, this message translates to:
  /// **'Total contribution from production: {amount} {unit}'**
  String totalContribution(Object amount, Object unit);

  /// No description provided for @accelerate.
  ///
  /// In en, this message translates to:
  /// **'Accelerate'**
  String get accelerate;

  /// No description provided for @accelerationCost.
  ///
  /// In en, this message translates to:
  /// **'Cost: {amount}'**
  String accelerationCost(Object amount);

  /// No description provided for @cellProductionRate.
  ///
  /// In en, this message translates to:
  /// **'{amount} {unit}'**
  String cellProductionRate(Object amount, Object unit);

  /// No description provided for @lvl.
  ///
  /// In en, this message translates to:
  /// **'lvl'**
  String get lvl;

  /// No description provided for @researchMaterialCraftSection.
  ///
  /// In en, this message translates to:
  /// **'How to craft'**
  String get researchMaterialCraftSection;

  /// No description provided for @researchMaterialCraftFromCell.
  ///
  /// In en, this message translates to:
  /// **'Place {amount} {cellName} in the bottom crafting slot (Cell). Leave the two upper reagent slots empty.'**
  String researchMaterialCraftFromCell(String amount, String cellName);

  /// No description provided for @researchMaterialCraftMerge.
  ///
  /// In en, this message translates to:
  /// **'Place {leftMaterial} and {rightMaterial} in the two upper reagent slots, then run the reaction.'**
  String researchMaterialCraftMerge(String leftMaterial, String rightMaterial);

  /// No description provided for @researchMaterialCellCost.
  ///
  /// In en, this message translates to:
  /// **'Cell cost'**
  String get researchMaterialCellCost;

  /// No description provided for @researchMaterialClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get researchMaterialClose;

  /// No description provided for @researchEnergyCore.
  ///
  /// In en, this message translates to:
  /// **'Energy Core'**
  String get researchEnergyCore;

  /// No description provided for @researchEnergyCoreDesc.
  ///
  /// In en, this message translates to:
  /// **'Stabilized EU crystallized from a basic energy cell reaction.'**
  String get researchEnergyCoreDesc;

  /// No description provided for @researchHeatShard.
  ///
  /// In en, this message translates to:
  /// **'Heat Shard'**
  String get researchHeatShard;

  /// No description provided for @researchHeatShardDesc.
  ///
  /// In en, this message translates to:
  /// **'Obsidian shard forged from concentrated thermal cell output.'**
  String get researchHeatShardDesc;

  /// No description provided for @researchFrostCrystal.
  ///
  /// In en, this message translates to:
  /// **'Frost Crystal'**
  String get researchFrostCrystal;

  /// No description provided for @researchFrostCrystalDesc.
  ///
  /// In en, this message translates to:
  /// **'Permafrost lattice distilled from ice cell emissions.'**
  String get researchFrostCrystalDesc;

  /// No description provided for @researchSteamEssence.
  ///
  /// In en, this message translates to:
  /// **'Steam Essence'**
  String get researchSteamEssence;

  /// No description provided for @researchSteamEssenceDesc.
  ///
  /// In en, this message translates to:
  /// **'Condensed vapor orb captured from steam cell exhaust.'**
  String get researchSteamEssenceDesc;

  /// No description provided for @researchMagneticOre.
  ///
  /// In en, this message translates to:
  /// **'Magnetic Ore'**
  String get researchMagneticOre;

  /// No description provided for @researchMagneticOreDesc.
  ///
  /// In en, this message translates to:
  /// **'Ferromagnetic chunks aligned by a magnetic cell field.'**
  String get researchMagneticOreDesc;

  /// No description provided for @researchLightFragment.
  ///
  /// In en, this message translates to:
  /// **'Light Fragment'**
  String get researchLightFragment;

  /// No description provided for @researchLightFragmentDesc.
  ///
  /// In en, this message translates to:
  /// **'Prismatic shard refracted from a light cell beam.'**
  String get researchLightFragmentDesc;

  /// No description provided for @researchCrystalChunk.
  ///
  /// In en, this message translates to:
  /// **'Crystal Chunk'**
  String get researchCrystalChunk;

  /// No description provided for @researchCrystalChunkDesc.
  ///
  /// In en, this message translates to:
  /// **'Violet geometric mass grown inside a crystalline cell.'**
  String get researchCrystalChunkDesc;

  /// No description provided for @researchMolecularGel.
  ///
  /// In en, this message translates to:
  /// **'Molecular Gel'**
  String get researchMolecularGel;

  /// No description provided for @researchMolecularGelDesc.
  ///
  /// In en, this message translates to:
  /// **'Neon gel lattice synthesized in a molecular cell.'**
  String get researchMolecularGelDesc;

  /// No description provided for @researchBacterialSample.
  ///
  /// In en, this message translates to:
  /// **'Bacterial Sample'**
  String get researchBacterialSample;

  /// No description provided for @researchBacterialSampleDesc.
  ///
  /// In en, this message translates to:
  /// **'Sterile colony disc cultured in a bacterial cell.'**
  String get researchBacterialSampleDesc;

  /// No description provided for @researchDnaStrand.
  ///
  /// In en, this message translates to:
  /// **'DNA Strand'**
  String get researchDnaStrand;

  /// No description provided for @researchDnaStrandDesc.
  ///
  /// In en, this message translates to:
  /// **'Bioluminescent helix extracted from a genetic cell.'**
  String get researchDnaStrandDesc;

  /// No description provided for @researchBloodDrop.
  ///
  /// In en, this message translates to:
  /// **'Blood Drop'**
  String get researchBloodDrop;

  /// No description provided for @researchBloodDropDesc.
  ///
  /// In en, this message translates to:
  /// **'Viscous crimson sample drawn from a blood cell core.'**
  String get researchBloodDropDesc;

  /// No description provided for @researchBioMass.
  ///
  /// In en, this message translates to:
  /// **'Bio Mass'**
  String get researchBioMass;

  /// No description provided for @researchBioMassDesc.
  ///
  /// In en, this message translates to:
  /// **'Organic tissue lump harvested from a bio cell chamber.'**
  String get researchBioMassDesc;

  /// No description provided for @researchRadiationDust.
  ///
  /// In en, this message translates to:
  /// **'Radiation Dust'**
  String get researchRadiationDust;

  /// No description provided for @researchRadiationDustDesc.
  ///
  /// In en, this message translates to:
  /// **'Hazardous powder collected from a radiation cell leak.'**
  String get researchRadiationDustDesc;

  /// No description provided for @researchUraniumCore.
  ///
  /// In en, this message translates to:
  /// **'Uranium Core'**
  String get researchUraniumCore;

  /// No description provided for @researchUraniumCoreDesc.
  ///
  /// In en, this message translates to:
  /// **'Dense radioactive sphere refined in a nuclear cell.'**
  String get researchUraniumCoreDesc;

  /// No description provided for @researchPlasmaOrb.
  ///
  /// In en, this message translates to:
  /// **'Plasma Orb'**
  String get researchPlasmaOrb;

  /// No description provided for @researchPlasmaOrbDesc.
  ///
  /// In en, this message translates to:
  /// **'Arcing plasma sphere contained by a plasma cell.'**
  String get researchPlasmaOrbDesc;

  /// No description provided for @researchDarkMatterFragment.
  ///
  /// In en, this message translates to:
  /// **'Dark Matter Fragment'**
  String get researchDarkMatterFragment;

  /// No description provided for @researchDarkMatterFragmentDesc.
  ///
  /// In en, this message translates to:
  /// **'Light-bending shard isolated in a dark matter cell.'**
  String get researchDarkMatterFragmentDesc;

  /// No description provided for @researchThermalCore.
  ///
  /// In en, this message translates to:
  /// **'Thermal Core'**
  String get researchThermalCore;

  /// No description provided for @researchThermalCoreDesc.
  ///
  /// In en, this message translates to:
  /// **'Hybrid hot-cold core merged from heat and frost reagents.'**
  String get researchThermalCoreDesc;

  /// No description provided for @researchPhaseCrystal.
  ///
  /// In en, this message translates to:
  /// **'Phase Crystal'**
  String get researchPhaseCrystal;

  /// No description provided for @researchPhaseCrystalDesc.
  ///
  /// In en, this message translates to:
  /// **'Matter that shifts between solid, liquid, and gas states.'**
  String get researchPhaseCrystalDesc;

  /// No description provided for @researchPhotonCore.
  ///
  /// In en, this message translates to:
  /// **'Photon Core'**
  String get researchPhotonCore;

  /// No description provided for @researchPhotonCoreDesc.
  ///
  /// In en, this message translates to:
  /// **'White-gold luminous core woven from light and crystal reagents.'**
  String get researchPhotonCoreDesc;

  /// No description provided for @researchStructuredMatter.
  ///
  /// In en, this message translates to:
  /// **'Structured Matter'**
  String get researchStructuredMatter;

  /// No description provided for @researchStructuredMatterDesc.
  ///
  /// In en, this message translates to:
  /// **'Nanoscale lattice block from molecular and bacterial samples.'**
  String get researchStructuredMatterDesc;

  /// No description provided for @researchSynapticLattice.
  ///
  /// In en, this message translates to:
  /// **'Synaptic Lattice'**
  String get researchSynapticLattice;

  /// No description provided for @researchSynapticLatticeDesc.
  ///
  /// In en, this message translates to:
  /// **'Neural energy mesh grown from genetic and blood reagents.'**
  String get researchSynapticLatticeDesc;

  /// No description provided for @researchOrganicCore.
  ///
  /// In en, this message translates to:
  /// **'Organic Core'**
  String get researchOrganicCore;

  /// No description provided for @researchOrganicCoreDesc.
  ///
  /// In en, this message translates to:
  /// **'Seed-like organic sphere from bio and radiation materials.'**
  String get researchOrganicCoreDesc;

  /// No description provided for @researchNuclearMass.
  ///
  /// In en, this message translates to:
  /// **'Nuclear Mass'**
  String get researchNuclearMass;

  /// No description provided for @researchNuclearMassDesc.
  ///
  /// In en, this message translates to:
  /// **'Unstable dense mass fused from uranium and plasma cores.'**
  String get researchNuclearMassDesc;

  /// No description provided for @researchVoidPlasma.
  ///
  /// In en, this message translates to:
  /// **'Void Plasma'**
  String get researchVoidPlasma;

  /// No description provided for @researchVoidPlasmaDesc.
  ///
  /// In en, this message translates to:
  /// **'Void-touched plasma orb from dark matter and thermal reagents.'**
  String get researchVoidPlasmaDesc;

  /// No description provided for @researchEntropyCore.
  ///
  /// In en, this message translates to:
  /// **'Entropy Core'**
  String get researchEntropyCore;

  /// No description provided for @researchEntropyCoreDesc.
  ///
  /// In en, this message translates to:
  /// **'Crumbling geometric solid decaying through phase and photon matter.'**
  String get researchEntropyCoreDesc;

  /// No description provided for @researchQuantumMatrix.
  ///
  /// In en, this message translates to:
  /// **'Quantum Matrix'**
  String get researchQuantumMatrix;

  /// No description provided for @researchQuantumMatrixDesc.
  ///
  /// In en, this message translates to:
  /// **'Probability lattice woven from structured and synaptic matter.'**
  String get researchQuantumMatrixDesc;

  /// No description provided for @researchPrimalOrganism.
  ///
  /// In en, this message translates to:
  /// **'Primal Organism'**
  String get researchPrimalOrganism;

  /// No description provided for @researchPrimalOrganismDesc.
  ///
  /// In en, this message translates to:
  /// **'Ancient micro-organism preserved from organic and nuclear mass.'**
  String get researchPrimalOrganismDesc;

  /// No description provided for @researchAnnihilationCore.
  ///
  /// In en, this message translates to:
  /// **'Annihilation Core'**
  String get researchAnnihilationCore;

  /// No description provided for @researchAnnihilationCoreDesc.
  ///
  /// In en, this message translates to:
  /// **'Matter-antimatter seam forged from void plasma and entropy.'**
  String get researchAnnihilationCoreDesc;

  /// No description provided for @researchRealityEngine.
  ///
  /// In en, this message translates to:
  /// **'Reality Engine'**
  String get researchRealityEngine;

  /// No description provided for @researchRealityEngineDesc.
  ///
  /// In en, this message translates to:
  /// **'Cosmic mechanism built from quantum and primal reagents.'**
  String get researchRealityEngineDesc;

  /// No description provided for @researchAbyssalHeart.
  ///
  /// In en, this message translates to:
  /// **'Abyssal Heart'**
  String get researchAbyssalHeart;

  /// No description provided for @researchAbyssalHeartDesc.
  ///
  /// In en, this message translates to:
  /// **'Dark pulsing heart merged from annihilation and reality cores.'**
  String get researchAbyssalHeartDesc;

  /// No description provided for @researchBloodstoneOfDominion.
  ///
  /// In en, this message translates to:
  /// **'Bloodstone of Dominion'**
  String get researchBloodstoneOfDominion;

  /// No description provided for @researchBloodstoneOfDominionDesc.
  ///
  /// In en, this message translates to:
  /// **'Legendary crowned gem at the apex of the research tree.'**
  String get researchBloodstoneOfDominionDesc;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
