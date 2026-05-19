import 'package:idle_laboratory/core/interfaces/localized.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

enum CellName implements Localized {
  basicEnergyCell,
  heatCell,
  iceCell,
  steamCell,
  magneticCell,
  lightCell,
  crystallineCell,
  molecularCell,
  bacterialCell,
  geneticCell,
  bloodCell,
  bioCell,
  radiationCell,
  nuclearCell,
  plasmaCell,
  darkMatterCell;

  @override
  String localize(AppLocalizations l10n) => switch (this) {
        CellName.basicEnergyCell => l10n.basicEnergyCell,
        CellName.heatCell => l10n.heatCell,
        CellName.iceCell => l10n.iceCell,
        CellName.steamCell => l10n.steamCell,
        CellName.magneticCell => l10n.magneticCell,
        CellName.lightCell => l10n.lightCell,
        CellName.crystallineCell => l10n.crystallineCell,
        CellName.molecularCell => l10n.molecularCell,
        CellName.bacterialCell => l10n.bacterialCell,
        CellName.geneticCell => l10n.geneticCell,
        CellName.bloodCell => l10n.bloodCell,
        CellName.bioCell => l10n.bioCell,
        CellName.radiationCell => l10n.radiationCell,
        CellName.nuclearCell => l10n.nuclearCell,
        CellName.plasmaCell => l10n.plasmaCell,
        CellName.darkMatterCell => l10n.darkMatterCell,
      };
}
