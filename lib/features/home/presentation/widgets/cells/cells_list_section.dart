import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/cell_model_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/app_border_container.dart';
import 'package:idle_laboratory/core/widgets/app_divider.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/core/widgets/status_badge.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/settings/settings_bloc.dart';

class CellsListSection extends StatelessWidget {
  const CellsListSection({super.key});

  @override
  Widget build(BuildContext context) => SectionCard(
    child: SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.2,
      child: BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
        selector: (state) => state.appVersion,
        builder: (context, appVersion) {
          final isMobile = appVersion == AppVersionEnum.mobile;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(isMobile ? 12 : 20),
                alignment: Alignment.center,
            child: Text(context.l10n.cells, style: context.styles.sectionTitle),
          ),
          AppDivider(color: context.color.primaryText.withValues(alpha: 0.2)),
          Expanded(
                child: BlocSelector<CellsBloc, CellsState, (List<CellModel>, String?)>(
                  selector: (state) => (state.cells, state.selectedCellId),
                  builder: (context, data) {
                    final (cells, selectedCellId) = data;
                    final selectedId = cells.any((cell) => cell.id == selectedCellId) ? selectedCellId : null;
                    return ListView.separated(
                      padding: isMobile ? const EdgeInsets.all(8) : const EdgeInsets.fromLTRB(12, 16, 12, 16),
                      itemCount: cells.length,
                      separatorBuilder: (context, index) => SizedBox(height: isMobile ? 8 : 16),
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
                padding: const EdgeInsets.all(12),
                child: Text(
                  context.l10n.unlockMoreCells,
                  style: context.styles.helperText,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
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
        borderRadius: BorderRadius.circular(8),
        child: AppBorderContainer(
          isActive: isSelected,
          inactiveColor: context.color.background.withValues(alpha: 0.3),
          activeColor: context.color.primary.withValues(alpha: 0.25),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cell.name.localize(l10n), style: context.styles.cellName(isLocked: cell.isLocked)),
              if (!cell.isLocked) ...[
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${l10n.level}: ${cell.level}', style: context.styles.compactValue),
                    Row(
                      children: [
                        Icon(Icons.arrow_upward, color: context.color.green, size: 10),
                        const SizedBox(width: 2),
                        Text(
                          '${cell.energyPerSecond ?? '0.0'} / ${l10n.sec}',
                          style: context.styles.compactAccentValue,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                BlocSelector<SettingsBloc, SettingsState, bool>(
                  selector: (state) => state.isScientificNotation,
                  builder: (context, isScientific) {
                    final nextLevel = cell.nextLevelConfig;
                    return Row(
                      children: [
                        Icon(Icons.battery_charging_full, color: context.color.primaryText, size: 10),
                        const SizedBox(width: 4),
                        Text(
                          nextLevel == null
                              ? l10n.maxLvl
                              : '${l10n.nextLvl}: ${nextLevel.energyRequired.format(useScientific: isScientific)}',
                          style: context.styles.compactSupporting,
                        ),
                      ],
                    );
                  },
                ),
              ],
              if (cell.isLocked) ...[
                const SizedBox(height: 6),
                StatusBadge(text: '${l10n.unlockAt}: ${cell.getUnlockRequirementFormatted()}'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
