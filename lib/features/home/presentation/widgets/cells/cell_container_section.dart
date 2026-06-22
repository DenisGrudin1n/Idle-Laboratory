import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/animated_cell_graphic.dart';

class CellContainerSection extends StatelessWidget {
  const CellContainerSection({super.key});

  @override
  Widget build(BuildContext context) => SectionCard(
    child: SizedBox(
      width: 0.2.sw,
      height: double.infinity,
      child: Center(
        child: BlocSelector<CellsBloc, CellsState, String?>(
          selector: (state) => state.selectedCellId,
          builder: (context, selectedCellId) {
            if (selectedCellId == null) return SizedBox(width: 120.w, height: 72.h);
            final cellId = CellId.fromString(selectedCellId);
            if (cellId == null) return SizedBox(width: 120.w, height: 72.h);

            return BlocSelector<CellsBloc, CellsState, double>(
              selector: (state) => context.read<CellsBloc>().getFillLevel(selectedCellId),
              builder: (context, fillLevel) => RepaintBoundary(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final size = (constraints.maxWidth < constraints.maxHeight
                            ? constraints.maxWidth
                            : constraints.maxHeight) *
                        0.85;

                    return Center(
                      child: SizedBox(
                        width: size,
                        height: size,
                        child: AnimatedCellGraphic(cellId: cellId, fillLevel: fillLevel),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}
