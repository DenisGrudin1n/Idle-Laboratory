import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/enums.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/widgets.dart';

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
      // Content area with cells drawer
      const Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Cells list drawer
            CellsListDrawer(),
            // Main content area (empty for now)
            Expanded(child: SizedBox.shrink()),
          ],
        ),
      ),
    ],
  );
}
