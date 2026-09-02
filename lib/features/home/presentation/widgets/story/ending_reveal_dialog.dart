import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/constants/story_constants.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/enums/magician_emotion.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/app_color.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/magician_sprite.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/scaled_lore_text.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/story_dialog_layout.dart';

/// Evil-magician reveal shown after the apocalypse beat.
class EndingRevealDialog extends StatelessWidget {
  const EndingRevealDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showGeneralDialog<void>(
      context: context,
      barrierLabel: 'EndingReveal',
      barrierColor: context.color.darkMatterSingularityColor.withValues(alpha: 0.72),
      transitionDuration: const Duration(milliseconds: 550),
      pageBuilder: (context, animation, secondaryAnimation) => const EndingRevealDialog(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(scale: Tween<double>(begin: 0.92, end: 1).animate(curved), child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = context.color;
    final size = MediaQuery.sizeOf(context);

    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isMobile = appVersion == AppVersionEnum.mobile;
        final metrics = StoryDialogMetrics.forVersion(appVersion);
        final dialog = StoryDialogLayout.constraints(size: size, appVersion: appVersion);
        final spriteSize = isMobile ? 150.0 : 210.0;

        return SafeArea(
          child: Center(
            child: SizedBox(
              width: dialog.maxWidth,
              height: dialog.maxHeight,
              child: Material(
                color: DefaultColor.clear,
                child: SectionCard(
                  borderRadius: BorderRadius.circular(metrics.borderRadius),
                  padding: EdgeInsets.all(metrics.cardPadding),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: MagicianSprite(emotion: MagicianEmotion.evil, size: spriteSize),
                            ),
                            SizedBox(width: isMobile ? 12 : 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    l10n.endingRevealTitle,
                                    style: context.styles.sectionTitle.copyWith(fontSize: isMobile ? 16 : 20),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: metrics.titleBodyGap),
                                  Expanded(
                                    child: LoreBodyText(text: l10n.endingRevealDesc, fontSize: isMobile ? 14 : 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: metrics.buttonTopGap),
                      Align(
                        child: SizedBox(
                          width: dialog.maxWidth * StoryConstants.loreContinueButtonWidthFactor,
                          child: Material(
                            color: color.titleText,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: isMobile ? 12 : 14),
                                child: Text(
                                  l10n.endingRevealContinue,
                                  textAlign: TextAlign.center,
                                  style: context.styles.buttonLabel.copyWith(
                                    color: color.background,
                                    fontSize: isMobile ? 13 : 15,
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
