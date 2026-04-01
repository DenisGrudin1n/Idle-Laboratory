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
                      childAspectRatio: 0.8,
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
              style: context.styles.sectionHeaderTitle,
            ),
            Text(
              l10n.productionOverview,
              style: context.styles.sectionHeaderDescription,
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
            style: context.styles.successText,
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
    final l10n = context.l10n;

    // Placeholder values for now
    final amount = BigNumber(1.25, 3); // 1.25k
    final accelerationCost = BigNumber(4.5, 4); // 45k
    final productionRate = BigNumber(5.5, 0); // 5.5 /s

    final cellId = cell.cellId;
    if (cellId == null) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: color.background.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.primary.withValues(alpha: 0.1), width: 1.w),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(9.w, 6.h, 9.w, 4.h),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '${productionRate.format(compact: true)}/s',
                  style: context.styles.productionRate,
                ),
                const Spacer(),
                Text(
                  amount.format(compact: true),
                  style: context.styles.productionAmount,
                ),
              ],
            ),
            SizedBox(
              height: 42.h,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.h),
                  child: AspectRatio(
                    aspectRatio: 0.68,
                    child: AnimatedCellContainer(
                      fillLevel: 1,
                      visualTheme: context.getCellTheme(cellId),
                      animation: animation,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: color.background.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(7.r),
                    border: Border.all(color: color.primary.withValues(alpha: 0.14), width: 1.w),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          l10n.accelerate,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.styles.productionButtonLabel,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        accelerationCost.format(compact: true),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.styles.productionButtonCost,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
