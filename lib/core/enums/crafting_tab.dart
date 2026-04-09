import 'package:idle_laboratory/core/interfaces/localized.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

enum CraftingTab implements Localized {
  crafting,
  storage,
  research,
  overview;

  @override
  String localize(AppLocalizations l10n) => switch (this) {
    CraftingTab.crafting => l10n.crafting,
    CraftingTab.storage => l10n.storage,
    CraftingTab.research => l10n.research,
    CraftingTab.overview => l10n.overview,
  };
}
