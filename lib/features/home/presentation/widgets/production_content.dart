import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/cell_model_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_production_entry/cell_production_entry.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/prestige/prestige_bloc.dart';
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
              child: BlocSelector<CellsBloc, CellsState, (List<CellModel>, Map<String, CellProductionEntry>)>(
                selector: (state) => (state.cells, state.productionByCellId),
                builder: (context, data) {
                  final (cells, productionByCellId) = data;
                  final unlockedCells = cells.where((c) => !c.isLocked).toList();
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                    ),
                    itemCount: unlockedCells.length,
                    itemBuilder: (context, index) {
                      final cell = unlockedCells[index];
                      final entry = productionByCellId[cell.id] ?? CellProductionEntry.initial(cell.id);
                      return _ProductionItem(cell: cell, entry: entry, animation: _controller);
                    },
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.totalProduction, style: context.styles.sectionHeaderTitle),
              Text(l10n.productionOverview, style: context.styles.sectionHeaderDescription),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Flexible(child: _buildSummaryStats(context, l10n)),
      ],
    );
  }

  Widget _buildSummaryStats(BuildContext context, AppLocalizations l10n) {
    return BlocSelector<CellsBloc, CellsState, (List<CellModel>, Map<String, CellProductionEntry>)>(
      selector: (state) => (state.cells, state.productionByCellId),
      builder: (context, data) {
        final (cells, productionByCellId) = data;
        return BlocSelector<PrestigeBloc, PrestigeState, BigNumber>(
          selector: (state) => state.prestigeState?.totalMultiplier ?? BigNumber(1, 0),
          builder: (context, prestigeMult) {
            final contribution = cells.totalProductionEPSUnscaled(productionByCellId) * prestigeMult;
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
                  Flexible(
                    child: Text(
                      l10n.totalContribution(contribution.format(compact: true), l10n.energyPerSec),
                      style: context.styles.successText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _ProductionItem extends StatelessWidget {
  const _ProductionItem({required this.cell, required this.entry, required this.animation});
  final CellModel cell;
  final CellProductionEntry entry;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final l10n = context.l10n;

    final cellId = cell.cellId;
    if (cellId == null) return const SizedBox.shrink();

    final pps = GameBalance.calculateProductionPPS(cellId.order, entry.accelerationLevel);
    final productionRateLabel = BigNumber.fromDouble(pps).format(compact: true);
    final atMaxAcceleration = entry.accelerationLevel >= GameBalance.maxAccelerationLevel;
    final accelerationCost = atMaxAcceleration
        ? BigNumber.zero()
        : GameBalance.calculateAccelerationUpgradeCost(cellId.order, entry.accelerationLevel);
    final costLabel = atMaxAcceleration ? '—' : accelerationCost.format(compact: true);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$productionRateLabel/s', style: context.styles.productionRate),
                    SizedBox(height: 2.h),
                    Text('${l10n.lvl} ${entry.accelerationLevel}', style: context.styles.productionAccelerationLevel),
                  ],
                ),
                const Spacer(),
                Text(entry.amount.format(compact: true), style: context.styles.productionAmount),
              ],
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const graphicAspectWidthOverHeight = 0.68;
                  var width = constraints.maxWidth;
                  var height = width / graphicAspectWidthOverHeight;
                  if (height > constraints.maxHeight) {
                    height = constraints.maxHeight;
                    width = height * graphicAspectWidthOverHeight;
                  }
                  return Center(
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: AnimatedCellContainer(
                        fillLevel: 1,
                        visualTheme: context.getCellTheme(cellId),
                        animation: animation,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 4.h),
            Center(
              child: GestureDetector(
                onTap: atMaxAcceleration
                    ? null
                    : () => context.read<CellsBloc>().add(CellsEvent.accelerateProduction(cell.id)),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: color.background.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(7.r),
                    border: Border.all(color: color.primary.withValues(alpha: 0.14), width: 1.w),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 3.w),
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
                        costLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.styles.productionButtonCost,
                      ),
                      Icon(Icons.bolt, color: color.green, size: 12.sp),
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
