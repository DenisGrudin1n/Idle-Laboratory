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

  /// No description provided for @chemicals.
  ///
  /// In en, this message translates to:
  /// **'Chemicals'**
  String get chemicals;

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

  /// No description provided for @lightCell.
  ///
  /// In en, this message translates to:
  /// **'Light Cell'**
  String get lightCell;

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
