import 'package:idle_laboratory/core/interfaces/localized.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

enum CellType implements Localized {
  energy;

  @override
  String localize(AppLocalizations l10n) => switch (this) {
    CellType.energy => l10n.energyType,
  };
}
