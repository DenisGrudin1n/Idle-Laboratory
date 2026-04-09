import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/interfaces/localized.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

enum MainNavigationTab implements Localized {
  cells(Icons.science),
  crafting(Icons.precision_manufacturing),
  settings(Icons.settings),
  statistics(Icons.bar_chart),
  achievements(Icons.emoji_events);

  const MainNavigationTab(this.icon);

  final IconData icon;

  @override
  String localize(AppLocalizations l10n) => switch (this) {
    MainNavigationTab.cells => l10n.cells,
    MainNavigationTab.crafting => l10n.crafting,
    MainNavigationTab.settings => l10n.settings,
    MainNavigationTab.statistics => l10n.statistics,
    MainNavigationTab.achievements => l10n.achievements,
  };
}
