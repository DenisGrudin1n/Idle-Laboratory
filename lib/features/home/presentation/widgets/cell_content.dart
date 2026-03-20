import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/cells_tab.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cell_container_section.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells_list_section.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/prestige_info_section.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/top_navigation_bar.dart';

class CellContent extends StatefulWidget {
  const CellContent({super.key});

  @override
  State<CellContent> createState() => _CellContentState();
}

class _CellContentState extends State<CellContent> {
  CellsTab _selectedTab = CellsTab.energyCells;

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      // Top navigation bar
      TopNavigationBar(
        selectedTab: _selectedTab,
        onTabSelected: (CellsTab tab) => setState(() => _selectedTab = tab),
      ),
      SizedBox(height: 12.w),
      // Content area with cells drawer
      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Cells list drawer
            const CellsListSection(),
            SizedBox(width: 12.w),
            // Cell container display
            const Expanded(child: CellContainerSection()),
            SizedBox(width: 12.w),
            // Prestige drawer
            const PrestigeInfoSection(),
          ],
        ),
      ),
    ],
  );
}
