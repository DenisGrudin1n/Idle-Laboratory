import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/cells_tab.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/widgets/top_navigation_bar.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/energy_cells_content.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/production/production_content.dart';

class CellContent extends StatelessWidget {
  const CellContent({super.key});

  @override
  Widget build(BuildContext context) => BlocSelector<NavigationBloc, NavigationState, CellsTab>(
    selector: (state) => state.cellsTab,
    builder: (context, selectedTab) => Column(
      children: [
        TopNavigationBar<CellsTab>(
          tabs: CellsTab.values,
          selectedTab: selectedTab,
          onTabSelected: (tab) => context.read<NavigationBloc>().add(NavigationEvent.cellsTabChanged(tab)),
          tabLabel: (context, tab) => tab.localize(context.l10n),
        ),
        SizedBox(height: 12.w),
        Expanded(child: _buildTabContent(selectedTab)),
      ],
    ),
  );

  Widget _buildTabContent(CellsTab tab) => switch (tab) {
    CellsTab.energyCells => const EnergyCellsContent(),
    CellsTab.production => const ProductionContent(),
    CellsTab.overview => const Center(child: Text('Coming Soon')),
  };
}
