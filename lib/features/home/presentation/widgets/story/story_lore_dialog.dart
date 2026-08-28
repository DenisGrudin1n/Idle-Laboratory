import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/constants/overlay_constants.dart';
import 'package:idle_laboratory/core/constants/story_constants.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/enums/story_beat_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/story_beat_id_ext.dart';
import 'package:idle_laboratory/core/theme/app_color.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/magician_sprite.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/scaled_lore_text.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/story_dialog_layout.dart';

/// Single-page mid-game lore modal (greedy arc).
class StoryLoreDialog extends StatelessWidget {
  const StoryLoreDialog({required this.beat, super.key});

  final StoryBeatId beat;

  static Future<void> show(BuildContext context, {required StoryBeatId beat}) {
    return showGeneralDialog<void>(
      context: context,
      barrierLabel: 'StoryLore',
      barrierColor: OverlayConstants.dimBarrier(),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) {
        return StoryLoreDialog(beat: beat);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(scale: Tween<double>(begin: 0.94, end: 1).animate(curved), child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = context.color;
    final size = MediaQuery.sizeOf(context);
    final title = beat.title(l10n);
    final description = beat.description(l10n);
    final emotion = beat.emotion;

    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isMobile = appVersion == AppVersionEnum.mobile;
        final dialogConstraints = StoryDialogLayout.loreBeatConstraints(size: size, appVersion: appVersion);
        final dialogWidth = dialogConstraints.maxWidth;
        final buttonWidth = dialogWidth * StoryConstants.loreContinueButtonWidthFactor;
        final spriteSize = isMobile ? 108.0 : 140.0;
        final gap = isMobile ? 10.0 : 14.0;
        final cardPadding = isMobile ? 12.0 : 14.0;
        final titleBodyGap = isMobile ? 10.0 : 12.0;
        final continueTopGap = isMobile ? 26.0 : 30.0;

        final isLandscape = size.width > size.height;
        final maxDialogHeight = size.height * (isLandscape ? 0.82 : 0.78);

        final textInset = EdgeInsets.only(
          left: beat.mageOnLeft ? spriteSize + gap : 0,
          right: beat.mageOnLeft ? 0 : spriteSize + gap,
        );

        return SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: dialogConstraints.maxWidth, maxHeight: maxDialogHeight),
              child: SingleChildScrollView(
                child: Material(
                  color: DefaultColor.clear,
                  child: SectionCard(
                    borderRadius: BorderRadius.circular(14),
                    padding: EdgeInsets.all(cardPadding),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: textInset,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: context.styles.sectionTitle.copyWith(fontSize: isMobile ? 15 : 18),
                                  ),
                                  SizedBox(height: titleBodyGap),
                                  ScaledLoreText(text: description, maxSize: isMobile ? 13.5 : 15),
                                ],
                              ),
                            ),
                            SizedBox(height: continueTopGap),
                            Align(
                              child: SizedBox(
                                width: buttonWidth,
                                child: Material(
                                  color: color.titleText,
                                  borderRadius: BorderRadius.circular(10),
                                  child: InkWell(
                                    onTap: () => Navigator.of(context).pop(),
                                    borderRadius: BorderRadius.circular(10),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: isMobile ? 10 : 12),
                                      child: Text(
                                        l10n.storyLoreContinue,
                                        textAlign: TextAlign.center,
                                        style: context.styles.buttonLabel.copyWith(
                                          color: color.background,
                                          fontSize: isMobile ? 13 : 14,
                                          letterSpacing: 1.1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          left: beat.mageOnLeft ? 0 : null,
                          right: beat.mageOnLeft ? null : 0,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: MagicianSprite(emotion: emotion, size: spriteSize, flipped: beat.mageOnLeft),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
