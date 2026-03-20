import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/animated_cell_container.dart';

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
              builder: (context) {
                final selectedCellId = context.select(
                  (CellsBloc bloc) => bloc.state.selectedCellId,
                );
                if (selectedCellId == null)
                  return SizedBox(width: 120.w, height: 72.h);

                final cellId = CellId.fromString(selectedCellId);
                if (cellId == null) return SizedBox(width: 120.w, height: 72.h);

                final fillLevel = context.select(
                  (CellsBloc bloc) => bloc.getFillLevel(selectedCellId),
                );
                final visualTheme = context.getCellTheme(cellId);

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
