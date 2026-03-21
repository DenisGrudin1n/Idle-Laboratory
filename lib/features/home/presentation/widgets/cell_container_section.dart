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

class _CellContainerSectionState extends State<CellContainerSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                    child: SizedBox(
                      width: 120.w,
                      height: 72.h,
                      child: AnimatedCellContainer(fillLevel: fillLevel, visualTheme: context.getCellTheme(cellId), animation: _controller),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
}
