import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';
import 'package:idle_laboratory/lib.dart';

class CellsListDrawer extends StatelessWidget {
  const CellsListDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;

    final List<CellModel> cells = context.select(
      (CellProgressionCubit cubit) => cubit.state.cells,
    );

    final String? rawSelectedCellId = context.select(
      (CellsCubit cubit) => cubit.state.selectedCellId,
    );
    final String? selectedCellId =
        cells.any((CellModel cell) => cell.id == rawSelectedCellId)
        ? rawSelectedCellId
        : null;

    return Container(
      width: 0.25.sw,
      decoration: BoxDecoration(color: context.color.drawerBackground),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header
          Container(
            padding: EdgeInsets.all(12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  l10n.cells,
                  style: TextStyle(
                    color: context.color.titleText,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.refresh,
                  color: context.color.primaryText,
                  size: 16.sp,
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: context.color.primaryText.withValues(alpha: 0.2),
          ),
          // Cells list
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(8.w),
              itemCount: cells.length,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 8.h),
              itemBuilder: (BuildContext context, int index) {
                final CellModel cell = cells[index];
                final bool isSelected = selectedCellId == cell.id;

                return _CellItem(
                  cell: cell,
                  isSelected: isSelected,
                  onTap: () => context.read<CellsCubit>().selectCell(cell.id),
                );
              },
            ),
          ),
          // Footer text
          Container(
            padding: EdgeInsets.all(12.w),
            child: Text(
              l10n.unlockMoreCells,
              style: TextStyle(
                color: context.color.primaryText,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _CellItem extends StatelessWidget {
  const _CellItem({
    required this.cell,
    required this.isSelected,
    required this.onTap,
  });

  final CellModel cell;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: cell.isLocked ? null : onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: isSelected
                ? context.color.primary.withValues(alpha: 0.25)
                : context.color.background.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isSelected ? context.color.primary : Colors.transparent,
              width: 1.w,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Cell name
              Text(
                cell.name.localize(l10n),
                style: TextStyle(
                  color: cell.isLocked
                      ? context.color.primaryText
                      : context.color.titleText,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              // Level and Select button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (!cell.isLocked)
                    Text(
                      '${l10n.level}: ${cell.level}',
                      style: TextStyle(
                        color: context.color.primaryText,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  if (!cell.isLocked)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: context.color.background,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        l10n.select,
                        style: TextStyle(
                          color: context.color.primaryText,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              if (!cell.isLocked) ...<Widget>[
                SizedBox(height: 4.h),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_upward,
                      color: context.color.green,
                      size: 10.sp,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '${cell.energyPerSecond} / ${l10n.sec}',
                      style: TextStyle(
                        color: context.color.green,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
              if (cell.isLocked) ...<Widget>[
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: context.color.background,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.lock,
                        color: context.color.primaryText,
                        size: 10.sp,
                      ),
                      SizedBox(width: 4.w),
                      Builder(
                        builder: (BuildContext context) {
                          final CellId? cellId = CellId.fromString(cell.id);
                          final String unlockRequirement = cellId != null
                              ? CellEnergyPerSecond.getNewCellUnlockRequirement(
                                      cellId,
                                    ) ??
                                    '???'
                              : '???';
                          return Text(
                            '${l10n.unlockAt}: $unlockRequirement',
                            style: TextStyle(
                              color: context.color.primaryText,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
