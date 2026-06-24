import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/cell_model_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/core/widgets/energy_icon.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_production_entry/cell_production_entry.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/prestige/prestige_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/animated_cell_graphic.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

class ProductionContent extends StatelessWidget {
  const ProductionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SectionCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, l10n),
            const SizedBox(height: 16),
            Expanded(
              child: BlocSelector<CellsBloc, CellsState, (List<CellModel>, Map<String, CellProductionEntry>)>(
                selector: (state) => (state.cells, state.productionByCellId),
                builder: (context, data) {
                  final (cells, productionByCellId) = data;
                  final unlockedCells = cells.where((c) => !c.isLocked).toList();
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: unlockedCells.length,
                    itemBuilder: (context, index) {
                      final cell = unlockedCells[index];
                      final entry = productionByCellId[cell.id] ?? CellProductionEntry.initial(cell.id);
                      return _ProductionItem(cell: cell, entry: entry);
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
        const SizedBox(width: 8),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: context.color.background.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.color.primary.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  const EnergyIcon(sizeMultiplier: 1.3),
                  const SizedBox(width: 4),
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
  const _ProductionItem({required this.cell, required this.entry});
  final CellModel cell;
  final CellProductionEntry entry;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final l10n = context.l10n;

    final cellId = cell.cellId;
    if (cellId == null) return const SizedBox.shrink();

    final pps = GameBalance.calculateProductionPPS(cellId.order, entry.accelerationLevel);
    final productionRateLabel = pps.format(compact: true);
    final atMaxAcceleration = entry.accelerationLevel >= GameBalance.maxAccelerationLevel;
    final accelerationCost = atMaxAcceleration
        ? BigNumber.zero()
        : GameBalance.calculateAccelerationUpgradeCost(cellId.order, entry.accelerationLevel);
    final costLabel = atMaxAcceleration ? '—' : accelerationCost.format(compact: true);

    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isDesk = appVersion == AppVersionEnum.desk;
        final isTablet = appVersion == AppVersionEnum.tablet;
        return Container(
          decoration: BoxDecoration(
            color: color.background.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.primary.withValues(alpha: 0.1)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(9, 4, 9, 4),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$productionRateLabel/s', style: context.styles.productionRate),
                        const SizedBox(height: 2),
                        Text(
                          '${l10n.lvl} ${entry.accelerationLevel}',
                          style: context.styles.productionAccelerationLevel,
                        ),
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
                          child: AnimatedCellGraphic(cellId: cellId),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 4),
                _buildAccelerateButton(
                  context,
                  label: l10n.accelerate,
                  costLabel: costLabel,
                  onTap: atMaxAcceleration
                      ? null
                      : () => context.read<CellsBloc>().add(CellsEvent.accelerateProduction(cell.id)),
                ),
                SizedBox(
                  height: isDesk
                      ? 4
                      : isTablet
                      ? 3
                      : 2,
                ),
                _buildAccelerateButton(
                  context,
                  label: l10n.accelerateMax,
                  costLabel: atMaxAcceleration ? '—' : '',
                  accelerateMax: true,
                  onTap: atMaxAcceleration
                      ? null
                      : () => context.read<CellsBloc>().add(CellsEvent.accelerateProductionMax(cell.id)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAccelerateButton(
    BuildContext context, {
    required String label,
    required String costLabel,
    required VoidCallback? onTap,
    bool accelerateMax = false,
  }) {
    final color = context.color;
    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isDesk = appVersion == AppVersionEnum.desk;
        final isTablet = appVersion == AppVersionEnum.tablet;
        final verticalPadding = isDesk ? 8.0 : 2.0;
        final borderRadius = isDesk
            ? 8.0
            : isTablet
            ? 6.0
            : 4.0;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 4),
            decoration: BoxDecoration(
              color: color.background.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: color.primary.withValues(alpha: 0.14)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 3),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.styles.productionButtonLabel,
                  ),
                ),
                if (costLabel == '—' || !accelerateMax) const SizedBox(width: 4),
                Text(
                  costLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.styles.productionButtonCost,
                ),
                const EnergyIcon(),
              ],
            ),
          ),
        );
      },
    );
  }
}
