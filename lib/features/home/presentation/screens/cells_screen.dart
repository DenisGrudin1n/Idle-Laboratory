import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/main_navigation_tab.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/cell_id_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/storage/storage_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/story_lore/story_lore_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/controllers/tutorial_controller.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/cells/cell_content.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/crafting/crafting_content.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/main_navigation_bar.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/settings_toggle.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/story_lore_flow.dart';

class CellsScreen extends StatefulWidget {
  const CellsScreen({super.key});

  @override
  State<CellsScreen> createState() => _CellsScreenState();
}

class _CellsScreenState extends State<CellsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      playPrologueThenTutorial(context);
    });
  }

  Widget _buildContent(MainNavigationTab selectedTab) => switch (selectedTab) {
    MainNavigationTab.cells => const CellContent(),
    MainNavigationTab.crafting => const CraftingContent(),
    MainNavigationTab.settings => const SettingsToggle(),
    MainNavigationTab.statistics => const SizedBox.shrink(),
    MainNavigationTab.achievements => const SizedBox.shrink(),
  };

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    return MultiBlocListener(
      listeners: [
        BlocListener<CellsBloc, CellsState>(
          listenWhen: (prev, curr) {
            final prevCell = CellId.darkMatterCell.findIn(prev.cells);
            final currCell = CellId.darkMatterCell.findIn(curr.cells);
            if (prevCell == null || currCell == null) return false;
            return prevCell.isLocked && !currCell.isLocked;
          },
          listener: (context, state) {
            context.read<StoryLoreBloc>().add(const StoryLoreEvent.darkMatterUnlocked());
          },
        ),
        BlocListener<CellsBloc, CellsState>(
          listenWhen: (prev, curr) {
            final cellId = CellId.darkMatterCell.id;
            const max = GameBalance.maxAccelerationLevel;
            final prevLevel = prev.productionByCellId[cellId]?.accelerationLevel ?? 1;
            final currLevel = curr.productionByCellId[cellId]?.accelerationLevel ?? 1;
            return prevLevel < max && currLevel >= max;
          },
          listener: (context, state) {
            context.read<StoryLoreBloc>().add(const StoryLoreEvent.darkMatterProductionMaxed());
          },
        ),
        BlocListener<StorageBloc, StorageState>(
          listenWhen: (prev, curr) =>
              curr.lastAddedMaterial == ResearchMaterialId.bloodDrop &&
              curr.lastAddedTimestamp != prev.lastAddedTimestamp &&
              (prev.inventory[ResearchMaterialId.bloodDrop] ?? 0) == 0,
          listener: (context, state) {
            context.read<StoryLoreBloc>().add(const StoryLoreEvent.bloodDropCrafted());
          },
        ),
        BlocListener<StorageBloc, StorageState>(
          listenWhen: (prev, curr) =>
              curr.lastAddedMaterial == ResearchMaterialId.abyssalHeart &&
              curr.lastAddedTimestamp != prev.lastAddedTimestamp &&
              (prev.inventory[ResearchMaterialId.abyssalHeart] ?? 0) == 0,
          listener: (context, state) {
            context.read<StoryLoreBloc>().add(const StoryLoreEvent.abyssalHeartCrafted());
          },
        ),
        BlocListener<StoryLoreBloc, StoryLoreState>(
          listenWhen: (prev, curr) => curr.pendingBeat != null && prev.pendingBeat != curr.pendingBeat,
          listener: (context, state) {
            final beat = state.pendingBeat!;
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (!context.mounted) return;
              await playStoryLoreBeat(context, beat);
              if (!context.mounted) return;
              context.read<StoryLoreBloc>().add(const StoryLoreEvent.beatDismissed());
            });
          },
        ),
        BlocListener<StorageBloc, StorageState>(
          listenWhen: (prev, curr) =>
              curr.lastAddedMaterial == ResearchMaterialId.bloodstoneOfDominion &&
              curr.lastAddedTimestamp != prev.lastAddedTimestamp,
          listener: (context, state) {
            context.read<StoryLoreBloc>().add(const StoryLoreEvent.bloodstoneCrafted());
          },
        ),
        BlocListener<StoryLoreBloc, StoryLoreState>(
          listenWhen: (prev, curr) => curr.pendingEndingPlay && !prev.pendingEndingPlay,
          listener: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (!context.mounted) return;
              await playStoryEndingSequence(context);
              if (!context.mounted) return;
              context.read<StoryLoreBloc>().add(const StoryLoreEvent.endingSequenceCompleted());
            });
          },
        ),
        BlocListener<NavigationBloc, NavigationState>(
          listenWhen: (prev, curr) => prev.mainTab != curr.mainTab,
          listener: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state.mainTab == MainNavigationTab.cells) {
                TutorialController.showTabTutorial(context, cellsTab: state.cellsTab);
              } else if (state.mainTab == MainNavigationTab.crafting) {
                TutorialController.showTabTutorial(context, craftingTab: state.craftingTab);
              }
            });
          },
        ),
      ],
      child: BlocSelector<NavigationBloc, NavigationState, MainNavigationTab>(
        selector: (state) => state.mainTab,
        builder: (context, selectedTab) => Scaffold(
          backgroundColor: color.background,
          body: SafeArea(
            child: BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
              selector: (state) => state.appVersion,
              builder: (context, appVersion) {
                final isMobile = appVersion == AppVersionEnum.mobile;
                final mainNavigationBarPadding = isMobile
                    ? const EdgeInsets.only(top: 12)
                    : const EdgeInsets.only(top: 24, left: 24, bottom: 24);
                final contentPadding = isMobile
                    ? const EdgeInsets.only(top: 12)
                    : const EdgeInsets.only(top: 24, right: 24, bottom: 24);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RepaintBoundary(
                      child: Padding(
                        padding: mainNavigationBarPadding,
                        child: MainNavigationBar(
                          selectedTab: selectedTab,
                          onTabSelected: (tab) =>
                              context.read<NavigationBloc>().add(NavigationEvent.mainTabChanged(tab)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RepaintBoundary(
                        child: Padding(padding: contentPadding, child: _buildContent(selectedTab)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
