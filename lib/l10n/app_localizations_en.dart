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
  String get chemicals => 'Chemicals';

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
  String get lightCell => 'Light Cell';

  @override
  String get molecularCell => 'Molecular Cell';

  @override
  String get bacterialCell => 'Bacterial Cell';

  @override
  String get bloodCell => 'Blood Cell';

  @override
  String get bioCell => 'Bio Cell';

  @override
  String get radiationCell => 'Radiation Cell';

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
}
