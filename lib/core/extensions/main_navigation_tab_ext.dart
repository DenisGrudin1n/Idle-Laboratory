import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/main_navigation_tab.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

extension MainNavigationTabExt on MainNavigationTab {
  IconData get icon => switch (this) {
        MainNavigationTab.cells => Icons.science,
        MainNavigationTab.crafting => Icons.precision_manufacturing,
        MainNavigationTab.settings => Icons.settings,
        MainNavigationTab.statistics => Icons.bar_chart,
        MainNavigationTab.achievements => Icons.emoji_events,
      };

  String localize(AppLocalizations l10n) => switch (this) {
        MainNavigationTab.cells => l10n.cells,
        MainNavigationTab.crafting => l10n.crafting,
        MainNavigationTab.settings => l10n.settings,
        MainNavigationTab.statistics => l10n.statistics,
        MainNavigationTab.achievements => l10n.achievements,
      };
}
