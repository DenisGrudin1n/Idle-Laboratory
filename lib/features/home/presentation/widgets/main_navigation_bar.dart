import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/main_navigation_tab.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/energy_display.dart';

import 'package:idle_laboratory/features/home/presentation/widgets/storage/storage_badge.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({required this.selectedTab, required this.onTabSelected, super.key});
  final MainNavigationTab selectedTab;
  final ValueChanged<MainNavigationTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final sidebarWidth = (width * 0.22).clamp(130.0, 240.0);

    return SectionCard(
      child: SizedBox(
        width: sidebarWidth,
        height: double.infinity,
        child: ListView.separated(
          itemCount: MainNavigationTab.values.length + 1,
          separatorBuilder: (context, index) => index == 0
              ? Divider(height: 1, thickness: 1, color: context.color.primaryText.withValues(alpha: 0.2))
              : Divider(
                  height: 1,
                  thickness: 1,
                  indent: 12,
                  endIndent: 12,
                  color: context.color.primaryText.withValues(alpha: 0.1),
                ),
          itemBuilder: (context, index) {
            if (index == 0) return const EnergyDisplay();
            final tab = MainNavigationTab.values[index - 1];
            return _DrawerTab(
              tab: tab,
              label: tab.localize(context.l10n),
              isActive: selectedTab == tab,
              onTap: () => onTabSelected(tab),
            );
          },
        ),
      ),
    );
  }
}

class _DrawerTab extends StatelessWidget {
  const _DrawerTab({required this.tab, required this.label, required this.isActive, required this.onTap});
  final MainNavigationTab tab;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isActive ? context.color.primary.withValues(alpha: 0.3) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isActive ? context.color.primary : Colors.transparent),
            ),
            child: Row(
              children: [
                Icon(tab.icon, color: context.color.primaryText, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(label, style: context.styles.navigationLabel(isActive: isActive)),
                ),
              ],
            ),
          ),
          if (tab == MainNavigationTab.crafting)
            const Positioned(
              right: 32,
              bottom: 18,
              child: StorageBadge(forMainTab: MainNavigationTab.crafting),
            ),
        ],
      ),
    ),
  );
}
