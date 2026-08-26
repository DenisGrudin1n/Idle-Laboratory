import 'package:flutter/material.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/ending_apocalypse_overlay.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/ending_reveal_dialog.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/to_be_continued_screen.dart';

/// Presentation-only cutscene sequence (Navigator overlays). No domain services.
Future<void> playStoryEndingSequence(BuildContext context) async {
  await EndingApocalypseOverlay.play(context);
  if (!context.mounted) return;

  await EndingRevealDialog.show(context);
  if (!context.mounted) return;

  // Drop the black apocalypse layer before the epilogue screen.
  Navigator.of(context, rootNavigator: true).pop();
  if (!context.mounted) return;

  await ToBeContinuedScreen.show(context);
}
