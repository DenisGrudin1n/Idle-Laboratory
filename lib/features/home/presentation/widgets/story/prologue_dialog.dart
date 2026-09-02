import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/constants/story_constants.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/enums/magician_emotion.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/app_color.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/utils/app_scroll_behavior.dart';
import 'package:idle_laboratory/core/widgets/magician_sprite.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/story_lore/story_lore_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/scaled_lore_text.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/story_dialog_layout.dart';

/// Kind-magician opening beat shown before the coach-mark tutorial.
///
/// Two swipeable pages: introduction, then the Bloodstone goal framed as hope.
class PrologueDialog extends StatefulWidget {
  const PrologueDialog({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      PageRouteBuilder<void>(
        opaque: false,
        barrierLabel: 'Prologue',
        barrierColor: context.color.darkMatterSingularityColor.withValues(alpha: 0.78),
        transitionDuration: const Duration(milliseconds: 3800),
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (context, animation, secondaryAnimation) {
          return const PrologueDialog();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return _PrologueEntrance(animation: animation, child: child);
        },
      ),
    );
  }

  @override
  State<PrologueDialog> createState() => _PrologueDialogState();
}

class _PrologueDialogState extends State<PrologueDialog> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onPrimary(bool isLastPage) async {
    if (!isLastPage) {
      context.read<StoryLoreBloc>().add(const StoryLoreEvent.prologueNextPage());
      await _pageController.nextPage(duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic);
      return;
    }
    if (mounted) Navigator.of(context).pop();
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
        final dialogConstraints = StoryDialogLayout.constraints(size: size, appVersion: appVersion);

        return SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: dialogConstraints,
              child: SizedBox(
                width: dialogConstraints.maxWidth,
                height: dialogConstraints.maxHeight,
                child: Material(
                  color: DefaultColor.clear,
                  child: SectionCard(
                    borderRadius: BorderRadius.circular(metrics.borderRadius),
                    padding: EdgeInsets.all(metrics.cardPadding),
                    child: Column(
                      children: [
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: const AppMouseDragScrollBehavior(),
                            child: PageView(
                              controller: _pageController,
                              onPageChanged: (page) =>
                                  context.read<StoryLoreBloc>().add(StoryLoreEvent.prologuePageChanged(page)),
                              children: [
                                _ProloguePage(
                                  isMobile: isMobile,
                                  titleBodyGap: metrics.titleBodyGap,
                                  title: l10n.prologueStep1Title,
                                  body: l10n.prologueStep1Desc,
                                ),
                                _ProloguePage(
                                  isMobile: isMobile,
                                  titleBodyGap: metrics.titleBodyGap,
                                  title: l10n.prologueStep2Title,
                                  body: l10n.prologueStep2Desc,
                                  spriteOnRight: true,
                                  flipSprite: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: metrics.contentDotsGap),
                        BlocSelector<StoryLoreBloc, StoryLoreState, int>(
                          selector: (state) => state.prologuePageIndex,
                          builder: (context, pageIndex) {
                            return _StepDots(step: pageIndex, total: StoryConstants.prologuePageCount);
                          },
                        ),
                        SizedBox(height: metrics.buttonTopGap),
                        BlocSelector<StoryLoreBloc, StoryLoreState, bool>(
                          selector: (state) => state.isPrologueLastPage,
                          builder: (context, isLastPage) {
                            final cta = isLastPage ? l10n.prologueBegin : l10n.prologueNext;
                            return SizedBox(
                              width: double.infinity,
                              child: Material(
                                color: color.titleText,
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  onTap: () => _onPrimary(isLastPage),
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: isMobile ? 12 : 14),
                                    child: Text(
                                      cta,
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
                            );
                          },
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

class _ProloguePage extends StatelessWidget {
  const _ProloguePage({
    required this.isMobile,
    required this.titleBodyGap,
    required this.title,
    required this.body,
    this.spriteOnRight = false,
    this.flipSprite = false,
  });

  final bool isMobile;
  final double titleBodyGap;
  final String title;
  final String body;
  final bool spriteOnRight;
  final bool flipSprite;

  @override
  Widget build(BuildContext context) {
    final spriteSize = isMobile ? 140.0 : 200.0;
    final sprite = MagicianSprite(emotion: MagicianEmotion.kind, size: spriteSize, flipped: flipSprite);
    final textColumn = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: context.styles.sectionTitle.copyWith(fontSize: isMobile ? 16 : 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: titleBodyGap),
          Expanded(
            child: LoreBodyText(text: body, fontSize: isMobile ? 14 : 16, scrollbarOnRight: !spriteOnRight),
          ),
        ],
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: spriteOnRight
          ? [textColumn, SizedBox(width: isMobile ? 12 : 20), Center(child: sprite)]
          : [Center(child: sprite), SizedBox(width: isMobile ? 12 : 20), textColumn],
    );
  }
}

class _StepDots extends StatelessWidget {
  const _StepDots({required this.step, required this.total});

  final int step;
  final int total;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        final active = index == step;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 14 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: active ? color.titleText : color.primaryText.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

/// Lab-magic entrance: even blue haze across the screen, then modal, then haze fades.
class _PrologueEntrance extends StatelessWidget {
  const _PrologueEntrance({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    // Fade in → hold → modal → fade out.
    final chemicalAppear = CurvedAnimation(
      parent: animation,
      curve: const Interval(0, 0.42, curve: Curves.easeOut),
    );
    final chemicalMotion = CurvedAnimation(parent: animation, curve: const Interval(0, 0.5));
    final modal = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.5, 0.62, curve: Curves.easeOutCubic),
    );
    final chemicalFade = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.64, 1, curve: Curves.easeIn),
    );
    final lift = Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero).animate(modal);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final chemicalOpacity = (chemicalAppear.value * (1 - chemicalFade.value)).clamp(0.0, 1.0);
        return Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: _PrologueAuraPainter(progress: chemicalMotion.value, opacity: chemicalOpacity, colors: color),
              child: const SizedBox.expand(),
            ),
            FadeTransition(
              opacity: modal,
              child: SlideTransition(
                position: lift,
                child: ScaleTransition(scale: Tween<double>(begin: 0.96, end: 1).animate(modal), child: child),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PrologueAuraPainter extends CustomPainter {
  _PrologueAuraPainter({required this.progress, required this.opacity, required this.colors});

  final double progress;
  final double opacity;
  final AppColor colors;

  @override
  void paint(Canvas canvas, Size size) {
    if (opacity <= 0.01) return;

    // Soften / desaturate theme blues so the haze stays calm, not neon.
    final muted = colors.darkMatterSingularityColor;
    final blueSoft = Color.lerp(colors.iceParticleColor1, muted, 0.42)!;
    final blueMid = Color.lerp(colors.plasmaParticleColor1, muted, 0.48)!;
    final blueDeep = Color.lerp(colors.plasmaParticleColor2, muted, 0.35)!;
    final blueAccent = Color.lerp(colors.magneticParticleColor1, muted, 0.45)!;

    // Start nearly full-screen; only a tiny coverage grow.
    final coverage = 0.94 + 0.06 * progress;
    final height = size.height * coverage;
    final width = size.width * coverage;
    final left = (size.width - width) * 0.5;
    final top = (size.height - height) * 0.5;
    final field = Rect.fromLTWH(left, top, width, height);
    final a = opacity;

    // Even wash — no radial circle.
    canvas.drawRect(field, Paint()..color = blueDeep.withValues(alpha: 0.08 * a * (0.88 + 0.12 * progress)));

    // Soft vertical haze (lab mist), edge-to-edge.
    final vertical = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          blueSoft.withValues(alpha: 0.14 * a),
          blueMid.withValues(alpha: 0.07 * a),
          blueDeep.withValues(alpha: 0.05 * a),
          blueAccent.withValues(alpha: 0.08 * a),
        ],
        stops: const [0.0, 0.35, 0.7, 1.0],
      ).createShader(field);
    canvas.drawRect(field, vertical);

    // Soft horizontal wash so wide screens stay even (still no circle).
    final horizontal = Paint()
      ..shader = LinearGradient(
        colors: [
          blueMid.withValues(alpha: 0.05 * a),
          blueSoft.withValues(alpha: 0.02 * a),
          blueMid.withValues(alpha: 0.05 * a),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(field);
    canvas.drawRect(field, horizontal);

    final bubblePaint = Paint()..style = PaintingStyle.fill;
    final rng = math.Random(11);
    for (var i = 0; i < 36; i++) {
      final drift = ((progress * 0.85) + i * 0.037) % 1.0;
      final x = field.left + field.width * (0.03 + rng.nextDouble() * 0.94);
      final y = field.top + field.height * ((0.08 + rng.nextDouble() * 0.84 + drift * 0.12) % 1.0);
      final r = (2.5 + rng.nextDouble() * 7.5) * (0.95 + progress * 0.08);
      final tone = switch (i % 3) {
        0 => blueMid,
        1 => blueAccent,
        _ => blueSoft,
      };
      bubblePaint.color = tone.withValues(alpha: (0.16 * a).clamp(0.0, 1.0));
      canvas.drawCircle(Offset(x, y), r, bubblePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _PrologueAuraPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.opacity != opacity || oldDelegate.colors != colors;
}
