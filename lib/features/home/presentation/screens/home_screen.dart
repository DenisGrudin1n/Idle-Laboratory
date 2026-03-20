import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/main_navigation_tab.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cell_content.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/main_navigation_bar.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/settings_toggle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MainNavigationTab _selectedTab = MainNavigationTab.cells;

  Widget _buildContent() => switch (_selectedTab) {
        MainNavigationTab.cells => const CellContent(),
        MainNavigationTab.chemicals => const SizedBox.shrink(),
        MainNavigationTab.settings => const SettingsToggle(),
        MainNavigationTab.statistics => const SizedBox.shrink(),
        MainNavigationTab.achievements => const SizedBox.shrink(),
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.color.background,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainNavigationBar(selectedTab: _selectedTab, onTabSelected: (tab) => setState(() => _selectedTab = tab)),
              SizedBox(width: 12.w),
              Expanded(child: _buildContent()),
            ],
          ),
        ),
      );
}
