import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/enums/main_navigation_tab.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/app_border_container.dart';
import 'package:idle_laboratory/core/widgets/app_divider.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/controllers/tutorial_controller.dart';
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

    return Container(
      width: sidebarWidth,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: context.color.sectionBorder, width: 3)),
        borderRadius: BorderRadius.circular(12),
        gradient: context.color.sectionGradient,
      ),
      child: BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
        selector: (state) => state.appVersion,
        builder: (context, appVersion) {
          final isMobile = appVersion == AppVersionEnum.mobile;
          final verticalPadding = isMobile ? 6.0 : 12.0;

          return Column(
            children: [
              const EnergyDisplay(),
              AppDivider(color: context.color.primaryText.withValues(alpha: 0.2)),
              Expanded(
                child: RepaintBoundary(
                  child: Container(
                    key: TutorialController.mainNavKey,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: verticalPadding),
                      itemCount: MainNavigationTab.values.length,
                      separatorBuilder: (context, index) => AppDivider(
                        indent: 12,
                        endIndent: 12,
                        color: context.color.primaryText.withValues(alpha: 0.1),
                      ),
                      itemBuilder: (context, index) {
                        final tab = MainNavigationTab.values[index];
                        return _DrawerTab(
                          tab: tab,
                          label: tab.localize(context.l10n),
                          isActive: selectedTab == tab,
                          onTap: () => onTabSelected(tab),
                          verticalPadding: verticalPadding,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DrawerTab extends StatelessWidget {
  const _DrawerTab({
    required this.tab,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.verticalPadding = 4.0,
  });
  final MainNavigationTab tab;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AppBorderContainer(
            isActive: isActive,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: verticalPadding),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: verticalPadding),
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
            const Positioned(right: 32, bottom: 18, child: StorageBadge(forMainTab: MainNavigationTab.crafting)),
        ],
      ),
    ),
  );
}
