import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/cell_model_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/animated_cell_container.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

class ProductionContent extends StatefulWidget {
  const ProductionContent({super.key});

  @override
  State<ProductionContent> createState() => _ProductionContentState();
}

class _ProductionContentState extends State<ProductionContent> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SectionCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, l10n),
            SizedBox(height: 16.h),
            Expanded(
              child: BlocSelector<CellsBloc, CellsState, List<CellModel>>(
                selector: (state) => state.cells,
                builder: (context, cells) {
                  final unlockedCells = cells.where((c) => !c.isLocked).toList();
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                    ),
                    itemCount: unlockedCells.length,
                    itemBuilder: (context, index) =>
                        _ProductionItem(cell: unlockedCells[index], animation: _controller),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.totalProduction,
              style: TextStyle(color: context.color.titleText, fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              l10n.productionOverview,
              style: TextStyle(color: context.color.primaryText.withValues(alpha: 0.6), fontSize: 10.sp),
            ),
          ],
        ),
        _buildSummaryStats(context, l10n),
      ],
    );
  }

  Widget _buildSummaryStats(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: context.color.background.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.color.primary.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(Icons.bolt, color: context.color.green, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            l10n.totalContribution('0.0', l10n.energyPerSec),
            style: TextStyle(color: context.color.green, fontSize: 11.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _ProductionItem extends StatelessWidget {
  const _ProductionItem({required this.cell, required this.animation});
  final CellModel cell;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final color = context.color;

    // Placeholder values for now
    final amount = BigNumber(1.25, 3); // 1.25k

    final cellId = cell.cellId;
    if (cellId == null) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: color.background.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.primary.withValues(alpha: 0.1), width: 1.w),
      ),
      child: Stack(
        children: [
          // 1. Amount in Top-Right
          Positioned(
            top: 6.h,
            right: 9.w,
            child: Text(
              amount.format(compact: true),
              style: TextStyle(color: color.titleText, fontSize: 10.sp, fontWeight: FontWeight.bold),
            ),
          ),
          // 2. Small Animated Cell in the center (scaled proportionally)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: AspectRatio(
                aspectRatio: 0.6,
                child: AnimatedCellContainer(
                  fillLevel: 1,
                  visualTheme: context.getCellTheme(cellId),
                  animation: animation,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
