import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/constants/cell_level_constants.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/cell_level_extensions.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/core/widgets/status_badge.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/settings/settings_bloc.dart';

class CellsListSection extends StatelessWidget {
  const CellsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final cells = context.select((CellsBloc bloc) => bloc.state.cells);
    final rawSelectedCellId = context.select(
      (CellsBloc bloc) => bloc.state.selectedCellId,
    );
    final selectedCellId = cells.any((cell) => cell.id == rawSelectedCellId)
        ? rawSelectedCellId
        : null;

    return SectionCard(
      child: SizedBox(
        width: 0.2.sw,
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
                separatorBuilder: (_, __) => SizedBox(height: 8.h),
                itemBuilder: (context, index) {
                  final cell = cells[index];
                  final isSelected = selectedCellId == cell.id;

                  return _CellItem(
                    cell: cell,
                    isSelected: isSelected,
                    onTap: () => context.read<CellsBloc>().add(
                      CellsEvent.selectCell(cell.id),
                    ),
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
    final l10n = context.l10n;

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
                  if (!cell.isLocked) StatusBadge(text: l10n.select),
                ],
              ),
              if (!cell.isLocked) ...<Widget>[
                SizedBox(height: 4.h),
                // Energy requirement for next level
                () {
                  final cellId = CellId.fromString(cell.id);
                  if (cellId == null) {
                    return const SizedBox.shrink();
                  }

                  final nextLevelConfig = CellLevelConstants.getLevelConfigs(
                    cellId,
                  ).getConfig(cell.level + 1);

                  final isScientific = context.select(
                    (SettingsBloc bloc) => bloc.state.isScientificNotation,
                  );
                  final text = nextLevelConfig == null
                      ? l10n.maxLvl
                      : '${l10n.nextLvl}: ${nextLevelConfig.energyRequired.format(useScientific: isScientific)}';
                  return Row(
                    children: [
                      Icon(
                        Icons.battery_charging_full,
                        color: context.color.primaryText,
                        size: 10.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        text,
                        style: TextStyle(
                          color: context.color.primaryText,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                }(),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: context.color.green,
                      size: 10.sp,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '${cell.energyPerSecond ?? '0.0'} / ${l10n.sec}',
                      style: TextStyle(
                        color: context.color.green,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
              if (cell.isLocked) ...[
                SizedBox(height: 6.h),
                StatusBadge(
                  text: () {
                    final cellId = CellId.fromString(cell.id);
                    final unlockRequirement = cellId != null
                        ? CellEnergyPerSecond.getNewCellUnlockRequirement(
                                cellId,
                              ) ??
                              '???'
                        : '???';
                    return '${l10n.unlockAt}: $unlockRequirement';
                  }(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
