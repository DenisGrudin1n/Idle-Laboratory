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
}
