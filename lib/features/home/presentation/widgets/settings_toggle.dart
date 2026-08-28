import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/story_beat_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/settings/settings_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/story_lore/story_lore_bloc.dart';

class SettingsToggle extends StatelessWidget {
  const SettingsToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        BlocSelector<SettingsBloc, SettingsState, bool>(
          selector: (state) => state.isScientificNotation,
          builder: (context, isScientific) => Container(
            constraints: const BoxConstraints(minHeight: 40),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: context.color.drawerBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.l10n.scientificNotation, style: context.styles.bodyLabel),
                InkWell(
                  onTap: () => context.read<SettingsBloc>().add(const SettingsEvent.toggleScientificNotation()),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isScientific ? context.color.primary : context.color.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(isScientific ? context.l10n.on : context.l10n.off, style: context.styles.buttonLabel),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (kDebugMode) ...[
          const SizedBox(height: 16),
          _DebugStoryBeatButton(
            label: context.l10n.debugStoryBeatDarkMatterUnlock,
            beat: StoryBeatId.darkMatterUnlocked,
          ),
          const SizedBox(height: 8),
          _DebugStoryBeatButton(
            label: context.l10n.debugStoryBeatDarkMatterProductionMax,
            beat: StoryBeatId.darkMatterProductionMaxed,
          ),
          const SizedBox(height: 8),
          _DebugStoryBeatButton(
            label: context.l10n.debugStoryBeatBloodDrop,
            beat: StoryBeatId.firstBloodDrop,
          ),
          const SizedBox(height: 8),
          _DebugStoryBeatButton(
            label: context.l10n.debugStoryBeatAbyssalHeart,
            beat: StoryBeatId.abyssalHeartCrafted,
          ),
          const SizedBox(height: 16),
          const _DebugCraftBloodstoneButton(),
        ],
      ],
    );
  }
}

class _DebugStoryBeatButton extends StatelessWidget {
  const _DebugStoryBeatButton({required this.label, required this.beat});

  final String label;
  final StoryBeatId beat;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.color.drawerBackground,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () => context.read<StoryLoreBloc>().add(StoryLoreEvent.debugShow(beat)),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Text(label, style: context.styles.bodyLabel),
        ),
      ),
    );
  }
}

class _DebugCraftBloodstoneButton extends StatelessWidget {
  const _DebugCraftBloodstoneButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.color.drawerBackground,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () => context.read<StoryLoreBloc>().add(const StoryLoreEvent.debugReplayEnding()),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Text(context.l10n.debugCraftBloodstone, style: context.styles.bodyLabel),
        ),
      ),
    );
  }
}
