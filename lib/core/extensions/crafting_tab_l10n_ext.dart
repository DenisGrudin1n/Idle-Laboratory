import 'package:idle_laboratory/core/enums/crafting_tab.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

extension CraftingTabL10n on CraftingTab {
  String localize(AppLocalizations l10n) => switch (this) {
        CraftingTab.crafting => l10n.crafting,
        CraftingTab.storage => l10n.storage,
        CraftingTab.research => l10n.research,
        CraftingTab.overview => l10n.overview,
      };
}
