import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/extensions/cell_model_ext.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/animated_cell_graphic.dart';

class CellContainerSection extends StatelessWidget {
  const CellContainerSection({super.key});

  @override
  Widget build(BuildContext context) => SectionCard(
    child: SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.2,
      height: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size =
              (constraints.maxWidth < constraints.maxHeight ? constraints.maxWidth : constraints.maxHeight) * 0.85;

          return Center(
            child: SizedBox(
              width: size,
              height: size,
              child: BlocSelector<CellsBloc, CellsState, String?>(
                selector: (state) => state.selectedCellId,
                builder: (context, selectedCellId) {
                  if (selectedCellId == null) return const SizedBox.shrink();
                  final cellId = CellId.fromString(selectedCellId);
                  if (cellId == null) return const SizedBox.shrink();

                  return RepaintBoundary(
                    child: BlocSelector<CellsBloc, CellsState, double>(
                      selector: (state) => _fillLevel(state, selectedCellId),
                      builder: (context, fillLevel) => AnimatedCellGraphic(cellId: cellId, fillLevel: fillLevel),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    ),
  );
}

double _fillLevel(CellsState state, String cellId) {
  CellModel? cell;
  for (final candidate in state.cells) {
    if (candidate.id == cellId) {
      cell = candidate;
      break;
    }
  }
  if (cell == null) return 0;
  if (cell.isMaxLevel) return 1;
  final cellEnergy = state.cellEnergies[cellId];
  return cellEnergy == null ? 0 : cell.getProgressToNextLevel(cellEnergy);
}
