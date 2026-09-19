import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/cell_id_ext.dart';
import 'package:idle_laboratory/core/extensions/research_material_l10n_ext.dart';
import 'package:idle_laboratory/core/extensions/statistics_formatters_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/core/widgets/app_scrollbar.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/settings/settings_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/statistics/statistics_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/statistics/statistics_expandable_row.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/statistics/statistics_row.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/statistics/statistics_section.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

class StatisticsContent extends StatefulWidget {
  const StatisticsContent({super.key});

  @override
  State<StatisticsContent> createState() => _StatisticsContentState();
}

class _StatisticsContentState extends State<StatisticsContent> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isMobile = appVersion == AppVersionEnum.mobile;

        return SectionCard(
          padding: EdgeInsets.all(isMobile ? 12 : 20),
          child: BlocSelector<SettingsBloc, SettingsState, bool>(
            selector: (state) => state.isScientificNotation,
            builder: (context, useScientific) {
              return BlocBuilder<StatisticsBloc, StatisticsState>(
                builder: (context, state) {
                  return AppScrollbar(
                    controller: _scrollController,
                    child: ListView(
                      controller: _scrollController,
                      children: _buildSections(
                        context.l10n,
                        state: state,
                        isMobile: isMobile,
                        useScientific: useScientific,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  List<Widget> _buildSections(
    AppLocalizations l10n, {
    required StatisticsState state,
    required bool isMobile,
    required bool useScientific,
  }) {
    final stats = state.stats;
    final gap = SizedBox(height: isMobile ? 16 : 24);

    return [
      StatisticsSection(
        title: l10n.statsSectionTime,
        isMobile: isMobile,
        children: [
          StatisticsRow(
            label: l10n.statsTotalPlayTime,
            value: StatisticsFormatters.duration(stats.totalPlayTimeSeconds),
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsSessionsStarted,
            value: '${stats.sessionsStarted}',
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsLongestSession,
            value: StatisticsFormatters.duration(stats.longestSessionSeconds),
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsFirstLaunchDate,
            value: StatisticsFormatters.dateFromEpochMs(stats.firstLaunchEpochMs),
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsDaysSinceFirstLaunch,
            value: '${StatisticsFormatters.daysSince(stats.firstLaunchEpochMs)}',
            isMobile: isMobile,
          ),
        ],
      ),
      gap,
      StatisticsSection(
        title: l10n.statsSectionEnergy,
        isMobile: isMobile,
        children: [
          StatisticsRow(
            label: l10n.statsLifetimeEnergyGenerated,
            value: StatisticsFormatters.bigNumber(stats.lifetimeEnergyGenerated, useScientific: useScientific),
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsLifetimeEnergySpent,
            value: StatisticsFormatters.bigNumber(stats.lifetimeEnergySpent, useScientific: useScientific),
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsPeakEnergy,
            value: StatisticsFormatters.bigNumber(stats.peakEnergy, useScientific: useScientific),
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsPeakEps,
            value: StatisticsFormatters.bigNumber(stats.peakEps, useScientific: useScientific),
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsCurrentEnergy,
            value: StatisticsFormatters.bigNumber(state.currentEnergy, useScientific: useScientific),
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsCurrentEps,
            value: StatisticsFormatters.bigNumber(state.currentEps, useScientific: useScientific),
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsEnergyThisPrestigeRun,
            value: StatisticsFormatters.bigNumber(stats.energyEarnedThisPrestigeRun, useScientific: useScientific),
            isMobile: isMobile,
          ),
        ],
      ),
      gap,
      StatisticsSection(
        title: l10n.statsSectionCells,
        isMobile: isMobile,
        children: [
          StatisticsExpandableRow(
            label: l10n.statsLifetimeCellsProduced,
            value: StatisticsFormatters.bigNumber(stats.lifetimeCellsProduced, useScientific: useScientific),
            isMobile: isMobile,
            children: [
              for (final cellId in CellId.values)
                StatisticsRow(
                  label: cellId.cellName.localize(l10n),
                  value: StatisticsFormatters.bigNumber(
                    stats.lifetimeCellsProducedByType[cellId.id] ?? BigNumber.zero(),
                    useScientific: useScientific,
                  ),
                  isMobile: isMobile,
                ),
            ],
          ),
          StatisticsRow(
            label: l10n.statsLifetimeCellLevelUps,
            value: '${stats.lifetimeCellLevelUps}',
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsTotalCellLevels,
            value: '${state.totalCellLevels} / ${stats.peakTotalCellLevels}',
            isMobile: isMobile,
          ),
        ],
      ),
      gap,
      StatisticsSection(
        title: l10n.statsSectionProduction,
        isMobile: isMobile,
        children: [
          StatisticsExpandableRow(
            label: l10n.statsLifetimeProductionGenerated,
            value: StatisticsFormatters.bigNumber(stats.lifetimeProductionGenerated, useScientific: useScientific),
            isMobile: isMobile,
            children: [
              for (final cellId in CellId.values)
                StatisticsRow(
                  label: cellId.cellName.localize(l10n),
                  value: StatisticsFormatters.bigNumber(
                    stats.lifetimeProductionGeneratedByType[cellId.id] ?? BigNumber.zero(),
                    useScientific: useScientific,
                  ),
                  isMobile: isMobile,
                ),
            ],
          ),
          StatisticsRow(
            label: l10n.statsLifetimeProductionLevelUps,
            value: '${stats.lifetimeProductionLevelUps}',
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsTotalProductionLevels,
            value: '${state.totalProductionLevels} / ${stats.peakTotalProductionLevels}',
            isMobile: isMobile,
          ),
        ],
      ),
      gap,
      StatisticsSection(
        title: l10n.statsSectionCrafting,
        isMobile: isMobile,
        children: [
          StatisticsRow(
            label: l10n.statsLifetimeCraftsCompleted,
            value: '${stats.lifetimeCraftsCompleted}',
            isMobile: isMobile,
          ),
          StatisticsExpandableRow(
            label: l10n.statsLifetimeMaterialsCrafted,
            value: '${stats.lifetimeMaterialsCrafted}',
            isMobile: isMobile,
            children: [
              for (final material in ResearchMaterialId.values)
                StatisticsRow(
                  label: material.displayName(l10n),
                  value: '${stats.lifetimeMaterialsCraftedByType[material.name] ?? 0}',
                  isMobile: isMobile,
                ),
            ],
          ),
          StatisticsRow(
            label: l10n.statsLifetimeCraftEnergySpent,
            value: StatisticsFormatters.bigNumber(stats.lifetimeCraftEnergySpent, useScientific: useScientific),
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsLifetimeCraftTime,
            value: StatisticsFormatters.duration(stats.lifetimeCraftDurationSeconds),
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsResearchTreeCompletion,
            value: StatisticsFormatters.percent(
              stats.lifetimeMaterialsCraftedByType.values.where((c) => c > 0).length,
              ResearchMaterialId.values.length,
            ),
            isMobile: isMobile,
          ),
        ],
      ),
      gap,
      StatisticsSection(
        title: l10n.statsSectionPrestige,
        isMobile: isMobile,
        children: [
          StatisticsRow(
            label: l10n.statsPrestigeCount,
            value: '${state.prestigeCount}',
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsCurrentPrestigeMultiplier,
            value: StatisticsFormatters.bigNumber(state.currentPrestigeMultiplier, useScientific: useScientific),
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsHighestPrestigeMultiplier,
            value: StatisticsFormatters.bigNumber(stats.highestPrestigeMultiplier, useScientific: useScientific),
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsEnergyAtLastPrestige,
            value: StatisticsFormatters.bigNumber(stats.energyAtLastPrestige, useScientific: useScientific),
            isMobile: isMobile,
          ),
          StatisticsRow(
            label: l10n.statsBestPrestigeRun,
            value: StatisticsFormatters.bigNumber(stats.bestPrestigeRunEnergy, useScientific: useScientific),
            isMobile: isMobile,
          ),
        ],
      ),
    ];
  }
}
