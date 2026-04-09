import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/main_navigation_tab.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cell_content.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_content.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/main_navigation_bar.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/settings_toggle.dart';

class CellsScreen extends StatelessWidget {
  const CellsScreen({super.key});

  Widget _buildContent(MainNavigationTab selectedTab) => switch (selectedTab) {
        MainNavigationTab.cells => const CellContent(),
        MainNavigationTab.crafting => const CraftingContent(),
        MainNavigationTab.settings => const SettingsToggle(),
        MainNavigationTab.statistics => const SizedBox.shrink(),
        MainNavigationTab.achievements => const SizedBox.shrink(),
      };

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    return BlocSelector<NavigationBloc, NavigationState, MainNavigationTab>(
      selector: (state) => state.mainTab,
      builder: (context, selectedTab) => Scaffold(
        backgroundColor: color.background,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainNavigationBar(
                selectedTab: selectedTab,
                onTabSelected: (tab) => context.read<NavigationBloc>().add(NavigationEvent.mainTabChanged(tab)),
              ),
              SizedBox(width: 12.w),
              Expanded(child: _buildContent(selectedTab)),
            ],
          ),
        ),
      ),
    );
  }
}
