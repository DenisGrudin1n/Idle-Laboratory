import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/crafting_tab.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_interface_panel.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/top_navigation_bar.dart';

class CraftingContent extends StatelessWidget {
  const CraftingContent({super.key});

  @override
  Widget build(BuildContext context) => BlocSelector<NavigationBloc, NavigationState, CraftingTab>(
        selector: (state) => state.craftingTab,
        builder: (context, selectedTab) => Column(
          children: [
            TopNavigationBar<CraftingTab>(
              tabs: CraftingTab.values,
              selectedTab: selectedTab,
              onTabSelected: (tab) => context.read<NavigationBloc>().add(NavigationEvent.craftingTabChanged(tab)),
              tabLabel: (context, tab) => tab.localize(context.l10n),
            ),
            SizedBox(height: 12.w),
            Expanded(child: _buildTabContent(context, selectedTab)),
          ],
        ),
      );

  Widget _buildTabContent(BuildContext context, CraftingTab tab) {
    final l10n = context.l10n;
    return switch (tab) {
      CraftingTab.crafting => SectionCard(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.craftingInterfaceTitle, style: context.styles.sectionHeaderTitle),
                SizedBox(height: 4.h),
                Text(l10n.craftingInterfaceOverview, style: context.styles.sectionHeaderDescription),
                SizedBox(height: 16.h),
                const Expanded(child: CraftingInterfacePanel()),
              ],
            ),
          ),
        ),
      _ => const Center(child: Text('Coming Soon')),
    };
  }
}
