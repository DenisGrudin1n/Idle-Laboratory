import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/constants/cell_level_constants.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/cell_level_extensions.dart';
import 'package:idle_laboratory/core/extensions/cell_model_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/core/widgets/status_badge.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/settings/settings_bloc.dart';

class CellsListSection extends StatelessWidget {
  const CellsListSection({super.key});

  @override
  Widget build(BuildContext context) => SectionCard(
    child: SizedBox(
      width: 0.2.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            alignment: Alignment.center,
            child: Text(
              context.l10n.cells,
              style: TextStyle(color: context.color.titleText, fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(height: 1, thickness: 1, color: context.color.primaryText.withValues(alpha: 0.2)),
          Expanded(
            child: BlocSelector<CellsBloc, CellsState, (List<CellModel>, String?)>(
              selector: (state) => (state.cells, state.selectedCellId),
              builder: (context, data) {
                final (cells, selectedCellId) = data;
                final selectedId = cells.any((cell) => cell.id == selectedCellId) ? selectedCellId : null;
                return ListView.separated(
                  padding: EdgeInsets.all(8.w),
                  itemCount: cells.length,
                  separatorBuilder: (context, index) => SizedBox(height: 8.h),
                  itemBuilder: (context, index) => _CellItem(
                    cell: cells[index],
                    isSelected: selectedId == cells[index].id,
                    onTap: () => context.read<CellsBloc>().add(CellsEvent.selectCell(cells[index].id)),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.w),
            child: Text(
              context.l10n.unlockMoreCells,
              style: TextStyle(color: context.color.primaryText, fontSize: 10.sp, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

class _CellItem extends StatelessWidget {
  const _CellItem({required this.cell, required this.isSelected, required this.onTap});
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
            border: Border.all(color: isSelected ? context.color.primary : Colors.transparent, width: 1.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cell.name.localize(l10n),
                style: TextStyle(
                  color: cell.isLocked ? context.color.primaryText : context.color.titleText,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!cell.isLocked) ...[
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${l10n.level}: ${cell.level}',
                      style: TextStyle(color: context.color.primaryText, fontSize: 9.sp, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Icon(Icons.arrow_upward, color: context.color.green, size: 10.sp),
                        SizedBox(width: 2.w),
                        Text(
                          '${cell.energyPerSecond ?? '0.0'} / ${l10n.sec}',
                          style: TextStyle(color: context.color.green, fontSize: 9.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                BlocSelector<SettingsBloc, SettingsState, bool>(
                  selector: (state) => state.isScientificNotation,
                  builder: (context, isScientific) {
                    final cellId = CellId.fromString(cell.id);
                    if (cellId == null) return const SizedBox.shrink();
                    final nextLevelConfig = CellLevelConstants.getLevelConfigs(cellId).getConfig(cell.level + 1);
                    return Row(
                      children: [
                        Icon(Icons.battery_charging_full, color: context.color.primaryText, size: 10.sp),
                        SizedBox(width: 4.w),
                        Text(
                          nextLevelConfig == null
                              ? l10n.maxLvl
                              : '${l10n.nextLvl}: ${nextLevelConfig.energyRequired.format(useScientific: isScientific)}',
                          style: TextStyle(
                            color: context.color.primaryText,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
              if (cell.isLocked) ...[
                SizedBox(height: 6.h),
                StatusBadge(text: '${l10n.unlockAt}: ${cell.getUnlockRequirementFormatted()}'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
