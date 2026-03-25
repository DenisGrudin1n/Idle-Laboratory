import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/cells_tab.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cell_container_section.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells_list_section.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/prestige_info_section.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/top_navigation_bar.dart';

class CellContent extends StatelessWidget {
  const CellContent({super.key});

  @override
  Widget build(BuildContext context) => BlocSelector<NavigationBloc, NavigationState, CellsTab>(
        selector: (state) => state.cellsTab,
        builder: (context, selectedTab) => Column(
          children: [
            TopNavigationBar(
              selectedTab: selectedTab,
              onTabSelected: (tab) => context.read<NavigationBloc>().add(NavigationEvent.cellsTabChanged(tab)),
            ),
            SizedBox(height: 12.w),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CellsListSection(),
                  SizedBox(width: 12.w),
                  const Expanded(child: CellContainerSection()),
                  SizedBox(width: 12.w),
                  const PrestigeInfoSection(),
                ],
              ),
            ),
          ],
        ),
      );
}
