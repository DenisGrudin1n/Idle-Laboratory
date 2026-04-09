import 'package:idle_laboratory/core/interfaces/localized.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

enum CellsTab implements Localized {
  energyCells,
  production,
  overview;

  @override
  String localize(AppLocalizations l10n) => switch (this) {
    CellsTab.energyCells => l10n.energyCells,
    CellsTab.production => l10n.production,
    CellsTab.overview => l10n.overview,
  };
}
