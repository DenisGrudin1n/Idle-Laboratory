import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
///
/// Landscape-friendly: sprite beside lore that scales to fill space;
/// CONTINUE pinned at bottom with high-contrast label.
class EndingRevealDialog extends StatelessWidget {
  const EndingRevealDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showGeneralDialog<void>(
      context: context,
      barrierLabel: 'EndingReveal',
      barrierColor: context.color.darkMatterSingularityColor.withValues(alpha: 0.72),
      transitionDuration: const Duration(milliseconds: 550),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const EndingRevealDialog();
      },
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
        final isLandscape = size.width > size.height;
        final dialogConstraints = StoryDialogLayout.constraints(
          size: size,
          appVersion: appVersion,
        );

        return SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: dialogConstraints,
              child: SizedBox(
                width: dialogConstraints.maxWidth,
                child: Material(
                  color: DefaultColor.clear,
                  child: SectionCard(
                    borderRadius: BorderRadius.circular(14),
                    padding: EdgeInsets.all(isMobile ? 12 : 16),
                    child: Column(
                      children: [
                        Expanded(
                          child: isLandscape
                              ? _LandscapeRevealBody(isMobile: isMobile)
                              : _PortraitRevealBody(isMobile: isMobile),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
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

class _PortraitRevealBody extends StatelessWidget {
  const _PortraitRevealBody({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final spriteSize = isMobile ? 150.0 : 210.0;

    return Column(
      children: [
        MagicianSprite(emotion: MagicianEmotion.evil, size: spriteSize),
        const SizedBox(height: 8),
        Text(
          l10n.endingRevealTitle,
          style: context.styles.sectionTitle.copyWith(fontSize: isMobile ? 16 : 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Expanded(child: ScaledLoreText(text: l10n.endingRevealDesc, centered: true)),
      ],
    );
  }
}

class _LandscapeRevealBody extends StatelessWidget {
  const _LandscapeRevealBody({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final spriteSize = isMobile ? 200.0 : 260.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(child: MagicianSprite(emotion: MagicianEmotion.evil, size: spriteSize)),
        SizedBox(width: isMobile ? 12 : 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.endingRevealTitle,
                style: context.styles.sectionTitle.copyWith(fontSize: isMobile ? 17 : 22),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ScaledLoreText(
                  text: l10n.endingRevealDesc,
                  maxSize: isMobile ? 15.5 : 17,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
