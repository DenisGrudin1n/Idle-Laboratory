import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/story_beat_id.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/story_lore/story_lore_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/controllers/tutorial_controller.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/ending_apocalypse_overlay.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/ending_reveal_dialog.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/prologue_dialog.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/story_lore_dialog.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/to_be_continued_screen.dart';

/// Opening sequence: kind-magician prologue, then coach-mark tutorial.
Future<void> playPrologueThenTutorial(BuildContext context) async {
  context.read<StoryLoreBloc>().add(const StoryLoreEvent.prologueReset());
  await PrologueDialog.show(context);
  if (!context.mounted) return;
  TutorialController.showTutorial(context);
}

/// Shows a single mid-game lore beat modal.
Future<void> playStoryLoreBeat(BuildContext context, StoryBeatId beat) {
  return StoryLoreDialog.show(context, beat: beat);
}

/// Full ending cutscene: apocalypse → evil reveal → epilogue screen.
Future<void> playStoryEndingSequence(BuildContext context) async {
  await EndingApocalypseOverlay.play(context);
  if (!context.mounted) return;

  await EndingRevealDialog.show(context);
  if (!context.mounted) return;

  Navigator.of(context, rootNavigator: true).pop();
  if (!context.mounted) return;

  await ToBeContinuedScreen.show(context);
}
