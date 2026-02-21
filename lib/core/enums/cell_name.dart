import 'package:idle_laboratory/core/interfaces/localized.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

enum CellName implements Localized {
  basicEnergyCell,
  heatCell,
  iceCell,
  darkMatterCell;

  @override
  String localize(AppLocalizations l10n) => switch (this) {
    CellName.basicEnergyCell => l10n.basicEnergyCell,
    CellName.heatCell => l10n.heatCell,
    CellName.iceCell => l10n.iceCell,
    CellName.darkMatterCell => l10n.darkMatterCell,
  };
}
