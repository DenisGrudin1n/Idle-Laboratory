import 'package:idle_laboratory/core/enums/cells_tab.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

extension CellsTabL10n on CellsTab {
  String localize(AppLocalizations l10n) => switch (this) {
        CellsTab.energyCells => l10n.energyCells,
        CellsTab.production => l10n.production,
        CellsTab.overview => l10n.overview,
      };
}
