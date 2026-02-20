import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/enums.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/widgets.dart';

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
    body: SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Left navigation drawer with energy display inside
            NavigationDrawerWidget(
              selectedTab: _selectedTab,
              onTabSelected: (MainNavigationTab tab) =>
                  setState(() => _selectedTab = tab),
            ),
            // Right content area - full width
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    ),
  );
}
