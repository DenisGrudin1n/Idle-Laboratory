import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/cell_model_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/core/widgets/app_dialog.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_production_entry/cell_production_entry.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/animated_cell_graphic.dart';

Future<CellId?> showCraftingCellPickerDialog(
  BuildContext context, {
  required bool allowClear,
}) =>
    AppDialog.show<CellId?>(
      context,
      maxWidth: 560.w,
      padding: EdgeInsets.all(14.w),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: _CraftingCellPickerBody(allowClear: allowClear),
    );

class _CraftingCellPickerBody extends StatelessWidget {
  const _CraftingCellPickerBody({required this.allowClear});

  final bool allowClear;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SizedBox(
      height: 0.62.sh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.craftingSelectCellTitle, style: context.styles.sectionHeaderTitle),
          SizedBox(height: 4.h),
          Text(l10n.craftingSelectCellOverview, style: context.styles.sectionHeaderDescription),
          SizedBox(height: 12.h),
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                  ),
                  itemCount: unlocked.length + (allowClear ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (allowClear && index == 0) {
                      return _ClearCellTile(
                        onTap: () => Navigator.of(context).pop(),
                      );
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
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          decoration: BoxDecoration(
            color: color.background.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: color.titleText.withValues(alpha: 0.35), width: 1.w),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.close_rounded, color: color.primaryText, size: 28.sp),
              SizedBox(height: 8.h),
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
  const _PickerCellTile({
    required this.cell,
    required this.cellId,
    required this.entry,
    required this.onSelected,
  });

  final CellModel cell;
  final CellId cellId;
  final CellProductionEntry entry;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final l10n = context.l10n;
    final pps = GameBalance.calculateProductionPPS(cellId.order, entry.accelerationLevel);
    final productionRateLabel = BigNumber.fromDouble(pps).format(compact: true);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSelected,
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          decoration: BoxDecoration(
            color: color.background.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: color.primary.withValues(alpha: 0.1), width: 1.w),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 6.h),
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
                          SizedBox(height: 2.h),
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
                SizedBox(height: 4.h),
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
