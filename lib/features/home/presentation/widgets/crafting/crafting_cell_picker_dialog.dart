import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/cell_model_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/app_dialog.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_production_entry/cell_production_entry.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/animated_cell_graphic.dart';

Future<CellId?> showCraftingCellPickerDialog(BuildContext context, {required bool allowClear}) =>
    AppDialog.show<CellId?>(
      context,
      maxWidth: 560,
      padding: const EdgeInsets.all(14),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: _CraftingCellPickerBody(allowClear: allowClear),
    );

class _CraftingCellPickerBody extends StatelessWidget {
  const _CraftingCellPickerBody({required this.allowClear});

  final bool allowClear;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.62,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.craftingSelectCellTitle, style: context.styles.sectionHeaderTitle),
          const SizedBox(height: 4),
          Text(l10n.craftingSelectCellOverview, style: context.styles.sectionHeaderDescription),
          const SizedBox(height: 12),
          Expanded(
            child: BlocSelector<CellsBloc, CellsState, (List<CellModel>, Map<String, CellProductionEntry>)>(
              selector: (state) => (state.cells, state.productionByCellId),
              builder: (context, data) {
                final unlocked = data.$1.where((c) => !c.isLocked).toList();
                if (unlocked.isEmpty && !allowClear) {
                  return Center(
                    child: Text(l10n.unlockMoreCells, style: context.styles.helperText, textAlign: TextAlign.center),
                  );
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: unlocked.length + (allowClear ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (allowClear && index == 0) {
                      return _ClearCellTile(onTap: () => Navigator.of(context).pop());
                    }
                    final cellIndex = allowClear ? index - 1 : index;
                    final cell = unlocked[cellIndex];
                    final cellId = cell.cellId;
                    if (cellId == null) return const SizedBox.shrink();
                    final entry = data.$2[cell.id] ?? CellProductionEntry.initial(cell.id);
                    return _PickerCellTile(
                      cell: cell,
                      cellId: cellId,
                      entry: entry,
                      onSelected: () => Navigator.of(context).pop(cellId),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ClearCellTile extends StatelessWidget {
  const _ClearCellTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final l10n = context.l10n;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            color: color.background.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.titleText.withValues(alpha: 0.35)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.close_rounded, color: color.primaryText, size: 28),
              const SizedBox(height: 8),
              Text(
                l10n.craftingClearCellSelection,
                style: context.styles.compactSupporting,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickerCellTile extends StatelessWidget {
  const _PickerCellTile({required this.cell, required this.cellId, required this.entry, required this.onSelected});

  final CellModel cell;
  final CellId cellId;
  final CellProductionEntry entry;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final l10n = context.l10n;
    final pps = GameBalance.calculateProductionPPS(cellId.order, entry.accelerationLevel);
    final productionRateLabel = pps.format(compact: true);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSelected,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            color: color.background.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.primary.withValues(alpha: 0.1)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$productionRateLabel/s', style: context.styles.productionRate, maxLines: 1),
                          const SizedBox(height: 2),
                          Text(
                            '${l10n.lvl} ${entry.accelerationLevel}',
                            style: context.styles.productionAccelerationLevel,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    Text(entry.amount.format(compact: true), style: context.styles.productionAmount, maxLines: 1),
                  ],
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      const aspect = 0.68;
                      var width = constraints.maxWidth;
                      var height = width / aspect;
                      if (height > constraints.maxHeight) {
                        height = constraints.maxHeight;
                        width = height * aspect;
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
                Text(
                  cell.name.localize(l10n),
                  style: context.styles.compactSupporting,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
