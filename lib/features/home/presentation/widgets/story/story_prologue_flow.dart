import 'package:flutter/material.dart';
import 'package:idle_laboratory/features/home/presentation/controllers/tutorial_controller.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/prologue_dialog.dart';

/// Opening sequence: kind-magician prologue, then coach-mark tutorial.
///
/// Currently runs on every launch for playtesting (same as the tutorial).
Future<void> playPrologueThenTutorial(BuildContext context) async {
  await PrologueDialog.show(context);
  if (!context.mounted) return;
  TutorialController.showTutorial(context);
}
