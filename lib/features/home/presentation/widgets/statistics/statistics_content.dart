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

class StatisticsContent extends StatefulWidget {
  const StatisticsContent({super.key});

  @override
  State<StatisticsContent> createState() => _StatisticsContentState();
}

class _StatisticsContentState extends State<StatisticsContent> {
  final _scrollController = ScrollController();
  StatisticsBloc? _statisticsBloc;
  var _watching = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bloc = context.read<StatisticsBloc>();
    if (_watching && identical(_statisticsBloc, bloc)) return;
    _statisticsBloc?.add(const StatisticsEvent.setWatching(watching: false));
    _statisticsBloc = bloc;
    _watching = true;
    bloc.add(const StatisticsEvent.setWatching(watching: true));
  }

  @override
  void dispose() {
    _statisticsBloc?.add(const StatisticsEvent.setWatching(watching: false));
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isMobile = appVersion == AppVersionEnum.mobile;
        final gap = SizedBox(height: isMobile ? 16 : 24);

        return SectionCard(
          padding: EdgeInsets.all(isMobile ? 12 : 20),
          child: BlocSelector<SettingsBloc, SettingsState, bool>(
            selector: (state) => state.isScientificNotation,
            builder: (context, useScientific) {
              return AppScrollbar(
                controller: _scrollController,
                child: ListView(
                  controller: _scrollController,
                  children: [
                    _TimeSection(isMobile: isMobile),
                    gap,
                    _EnergySection(isMobile: isMobile, useScientific: useScientific),
                    gap,
                    _CellsSection(isMobile: isMobile, useScientific: useScientific),
                    gap,
                    _ProductionSection(isMobile: isMobile, useScientific: useScientific),
                    gap,
                    _CraftingSection(isMobile: isMobile, useScientific: useScientific),
                    gap,
                    _PrestigeSection(isMobile: isMobile, useScientific: useScientific),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

typedef _TimeView = ({
  int playTime,
  int sessions,
  int longest,
  int? firstLaunch,
});

class _TimeSection extends StatelessWidget {
  const _TimeSection({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocSelector<StatisticsBloc, StatisticsState, _TimeView>(
      selector: (state) => (
        playTime: state.stats.totalPlayTimeSeconds,
        sessions: state.stats.sessionsStarted,
        longest: state.stats.longestSessionSeconds,
        firstLaunch: state.stats.firstLaunchEpochMs,
      ),
      builder: (context, view) {
        return StatisticsSection(
          title: l10n.statsSectionTime,
          isMobile: isMobile,
          children: [
            StatisticsRow(
              label: l10n.statsTotalPlayTime,
              value: StatisticsFormatters.duration(view.playTime),
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsSessionsStarted,
              value: '${view.sessions}',
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsLongestSession,
              value: StatisticsFormatters.duration(view.longest),
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsFirstLaunchDate,
              value: StatisticsFormatters.dateFromEpochMs(view.firstLaunch),
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsDaysSinceFirstLaunch,
              value: '${StatisticsFormatters.daysSince(view.firstLaunch)}',
              isMobile: isMobile,
            ),
          ],
        );
      },
    );
  }
}

typedef _EnergyView = ({
  BigNumber lifetimeGenerated,
  BigNumber lifetimeSpent,
  BigNumber peakEnergy,
  BigNumber peakEps,
  BigNumber currentEnergy,
  BigNumber currentEps,
  BigNumber thisRun,
});

class _EnergySection extends StatelessWidget {
  const _EnergySection({required this.isMobile, required this.useScientific});

  final bool isMobile;
  final bool useScientific;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocSelector<StatisticsBloc, StatisticsState, _EnergyView>(
      selector: (state) => (
        lifetimeGenerated: state.stats.lifetimeEnergyGenerated,
        lifetimeSpent: state.stats.lifetimeEnergySpent,
        peakEnergy: state.stats.peakEnergy,
        peakEps: state.stats.peakEps,
        currentEnergy: state.currentEnergy,
        currentEps: state.currentEps,
        thisRun: state.stats.energyEarnedThisPrestigeRun,
      ),
      builder: (context, view) {
        return StatisticsSection(
          title: l10n.statsSectionEnergy,
          isMobile: isMobile,
          children: [
            StatisticsRow(
              label: l10n.statsLifetimeEnergyGenerated,
              value: StatisticsFormatters.bigNumber(view.lifetimeGenerated, useScientific: useScientific),
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsLifetimeEnergySpent,
              value: StatisticsFormatters.bigNumber(view.lifetimeSpent, useScientific: useScientific),
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsPeakEnergy,
              value: StatisticsFormatters.bigNumber(view.peakEnergy, useScientific: useScientific),
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsPeakEps,
              value: StatisticsFormatters.bigNumber(view.peakEps, useScientific: useScientific),
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsCurrentEnergy,
              value: StatisticsFormatters.bigNumber(view.currentEnergy, useScientific: useScientific),
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsCurrentEps,
              value: StatisticsFormatters.bigNumber(view.currentEps, useScientific: useScientific),
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsEnergyThisPrestigeRun,
              value: StatisticsFormatters.bigNumber(view.thisRun, useScientific: useScientific),
              isMobile: isMobile,
            ),
          ],
        );
      },
    );
  }
}

typedef _CellsView = ({
  BigNumber lifetimeProduced,
  Map<String, BigNumber> byType,
  int levelUps,
  int totalLevels,
  int peakLevels,
});

class _CellsSection extends StatelessWidget {
  const _CellsSection({required this.isMobile, required this.useScientific});

  final bool isMobile;
  final bool useScientific;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocSelector<StatisticsBloc, StatisticsState, _CellsView>(
      selector: (state) => (
        lifetimeProduced: state.stats.lifetimeCellsProduced,
        byType: state.stats.lifetimeCellsProducedByType,
        levelUps: state.stats.lifetimeCellLevelUps,
        totalLevels: state.totalCellLevels,
        peakLevels: state.stats.peakTotalCellLevels,
      ),
      builder: (context, view) {
        return StatisticsSection(
          title: l10n.statsSectionCells,
          isMobile: isMobile,
          children: [
            StatisticsExpandableRow(
              label: l10n.statsLifetimeCellsProduced,
              value: StatisticsFormatters.bigNumber(view.lifetimeProduced, useScientific: useScientific),
              isMobile: isMobile,
              children: [
                for (final cellId in CellId.values)
                  StatisticsRow(
                    label: cellId.cellName.localize(l10n),
                    value: StatisticsFormatters.bigNumber(
                      view.byType[cellId.id] ?? BigNumber.zero(),
                      useScientific: useScientific,
                    ),
                    isMobile: isMobile,
                  ),
              ],
            ),
            StatisticsRow(
              label: l10n.statsLifetimeCellLevelUps,
              value: '${view.levelUps}',
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsTotalCellLevels,
              value: '${view.totalLevels} / ${view.peakLevels}',
              isMobile: isMobile,
            ),
          ],
        );
      },
    );
  }
}

typedef _ProductionView = ({
  BigNumber lifetimeGenerated,
  Map<String, BigNumber> byType,
  int levelUps,
  int totalLevels,
  int peakLevels,
});

class _ProductionSection extends StatelessWidget {
  const _ProductionSection({required this.isMobile, required this.useScientific});

  final bool isMobile;
  final bool useScientific;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocSelector<StatisticsBloc, StatisticsState, _ProductionView>(
      selector: (state) => (
        lifetimeGenerated: state.stats.lifetimeProductionGenerated,
        byType: state.stats.lifetimeProductionGeneratedByType,
        levelUps: state.stats.lifetimeProductionLevelUps,
        totalLevels: state.totalProductionLevels,
        peakLevels: state.stats.peakTotalProductionLevels,
      ),
      builder: (context, view) {
        return StatisticsSection(
          title: l10n.statsSectionProduction,
          isMobile: isMobile,
          children: [
            StatisticsExpandableRow(
              label: l10n.statsLifetimeProductionGenerated,
              value: StatisticsFormatters.bigNumber(view.lifetimeGenerated, useScientific: useScientific),
              isMobile: isMobile,
              children: [
                for (final cellId in CellId.values)
                  StatisticsRow(
                    label: cellId.cellName.localize(l10n),
                    value: StatisticsFormatters.bigNumber(
                      view.byType[cellId.id] ?? BigNumber.zero(),
                      useScientific: useScientific,
                    ),
                    isMobile: isMobile,
                  ),
              ],
            ),
            StatisticsRow(
              label: l10n.statsLifetimeProductionLevelUps,
              value: '${view.levelUps}',
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsTotalProductionLevels,
              value: '${view.totalLevels} / ${view.peakLevels}',
              isMobile: isMobile,
            ),
          ],
        );
      },
    );
  }
}

typedef _CraftingView = ({
  int craftsCompleted,
  int materialsCrafted,
  Map<String, int> byType,
  BigNumber craftEnergySpent,
  int craftDurationSeconds,
});

class _CraftingSection extends StatelessWidget {
  const _CraftingSection({required this.isMobile, required this.useScientific});

  final bool isMobile;
  final bool useScientific;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocSelector<StatisticsBloc, StatisticsState, _CraftingView>(
      selector: (state) {
        final stats = state.stats;
        return (
          craftsCompleted: stats.lifetimeCraftsCompleted,
          materialsCrafted: stats.lifetimeMaterialsCrafted,
          byType: stats.lifetimeMaterialsCraftedByType,
          craftEnergySpent: stats.lifetimeCraftEnergySpent,
          craftDurationSeconds: stats.lifetimeCraftDurationSeconds,
        );
      },
      builder: (context, view) {
        return StatisticsSection(
          title: l10n.statsSectionCrafting,
          isMobile: isMobile,
          children: [
            StatisticsRow(
              label: l10n.statsLifetimeCraftsCompleted,
              value: '${view.craftsCompleted}',
              isMobile: isMobile,
            ),
            StatisticsExpandableRow(
              label: l10n.statsLifetimeMaterialsCrafted,
              value: '${view.materialsCrafted}',
              isMobile: isMobile,
              children: [
                for (final material in ResearchMaterialId.values)
                  StatisticsRow(
                    label: material.displayName(l10n),
                    value: '${view.byType[material.name] ?? 0}',
                    isMobile: isMobile,
                  ),
              ],
            ),
            StatisticsRow(
              label: l10n.statsLifetimeCraftEnergySpent,
              value: StatisticsFormatters.bigNumber(view.craftEnergySpent, useScientific: useScientific),
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsLifetimeCraftTime,
              value: StatisticsFormatters.duration(view.craftDurationSeconds),
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsResearchTreeCompletion,
              value: StatisticsFormatters.percent(
                view.byType.values.where((c) => c > 0).length,
                ResearchMaterialId.values.length,
              ),
              isMobile: isMobile,
            ),
          ],
        );
      },
    );
  }
}

typedef _PrestigeView = ({
  int count,
  BigNumber currentMultiplier,
  BigNumber highestMultiplier,
  BigNumber energyAtLast,
  BigNumber bestRun,
});

class _PrestigeSection extends StatelessWidget {
  const _PrestigeSection({required this.isMobile, required this.useScientific});

  final bool isMobile;
  final bool useScientific;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocSelector<StatisticsBloc, StatisticsState, _PrestigeView>(
      selector: (state) => (
        count: state.prestigeCount,
        currentMultiplier: state.currentPrestigeMultiplier,
        highestMultiplier: state.stats.highestPrestigeMultiplier,
        energyAtLast: state.stats.energyAtLastPrestige,
        bestRun: state.stats.bestPrestigeRunEnergy,
      ),
      builder: (context, view) {
        return StatisticsSection(
          title: l10n.statsSectionPrestige,
          isMobile: isMobile,
          children: [
            StatisticsRow(
              label: l10n.statsPrestigeCount,
              value: '${view.count}',
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsCurrentPrestigeMultiplier,
              value: StatisticsFormatters.bigNumber(view.currentMultiplier, useScientific: useScientific),
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsHighestPrestigeMultiplier,
              value: StatisticsFormatters.bigNumber(view.highestMultiplier, useScientific: useScientific),
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsEnergyAtLastPrestige,
              value: StatisticsFormatters.bigNumber(view.energyAtLast, useScientific: useScientific),
              isMobile: isMobile,
            ),
            StatisticsRow(
              label: l10n.statsBestPrestigeRun,
              value: StatisticsFormatters.bigNumber(view.bestRun, useScientific: useScientific),
              isMobile: isMobile,
            ),
          ],
        );
      },
    );
  }
}
