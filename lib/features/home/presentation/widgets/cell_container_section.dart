import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/lib.dart';

class CellContainerSection extends StatefulWidget {
  const CellContainerSection({super.key});

  @override
  State<CellContainerSection> createState() => _CellContainerSectionState();
}

class _CellContainerSectionState extends State<CellContainerSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SectionCard(
    child: SizedBox(
      width: 0.2.sw,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Cell container with energy
            Builder(
              builder: (BuildContext context) {
                // Get selected cell ID from state
                final String? selectedCellId = context.select(
                  (CellsCubit cubit) => cubit.state.selectedCellId,
                );

                // If no cell is selected, show empty container
                if (selectedCellId == null) {
                  return SizedBox(width: 120.w, height: 72.h);
                }

                // Parse cell ID - early return if invalid
                final CellId? cellId = CellId.fromString(selectedCellId);
                if (cellId == null) {
                  return SizedBox(width: 120.w, height: 72.h);
                }

                // Get fill level for the selected cell
                final double fillLevel = context.select(
                  (CellsCubit cubit) => cubit.getFillLevel(selectedCellId),
                );

                // Get visual theme for this cell type
                final CellVisualTheme visualTheme = context.getCellTheme(
                  cellId,
                );

                return RepaintBoundary(
                  child: SizedBox(
                    width: 120.w,
                    height: 72.h,
                    child: AnimatedCellContainer(
                      fillLevel: fillLevel,
                      visualTheme: visualTheme,
                      animation: _animationController,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
