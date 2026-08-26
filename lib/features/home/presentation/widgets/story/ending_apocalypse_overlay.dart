import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/research_material_id_ext.dart';
import 'package:idle_laboratory/core/theme/app_color.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/cached_asset_image.dart';

/// Full-screen bloodstone surge → blackout before the ending lore.
///
/// Stays on solid black after the animation so the reveal dialog can open
/// without flashing the game UI. [play] resolves when black is reached; the
/// caller must [Navigator.pop] this route when the next beat is ready.
class EndingApocalypseOverlay extends StatefulWidget {
  const EndingApocalypseOverlay({
    required this.onReachedBlack,
    this.flareDuration = const Duration(milliseconds: 1600),
    this.flashDuration = const Duration(milliseconds: 320),
    this.darkDuration = const Duration(milliseconds: 950),
    super.key,
  });

  final VoidCallback onReachedBlack;
  final Duration flareDuration;
  final Duration flashDuration;
  final Duration darkDuration;

  /// Plays the sequence and completes once the screen is fully black.
  static Future<void> play(
    BuildContext context, {
    Duration flareDuration = const Duration(milliseconds: 1600),
    Duration flashDuration = const Duration(milliseconds: 320),
    Duration darkDuration = const Duration(milliseconds: 950),
  }) {
    final completer = Completer<void>();

    unawaited(
      Navigator.of(context, rootNavigator: true).push<void>(
        PageRouteBuilder<void>(
          transitionDuration: Duration.zero,
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return EndingApocalypseOverlay(
              flareDuration: flareDuration,
              flashDuration: flashDuration,
              darkDuration: darkDuration,
              onReachedBlack: () {
                if (!completer.isCompleted) completer.complete();
              },
            );
          },
        ),
      ),
    );

    return completer.future;
  }

  @override
  State<EndingApocalypseOverlay> createState() => _EndingApocalypseOverlayState();
}

class _EndingApocalypseOverlayState extends State<EndingApocalypseOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _flare;
  late final AnimationController _flash;
  late final AnimationController _dark;
  bool _notified = false;

  static final String? _bloodstoneAsset = ResearchMaterialId.bloodstoneOfDominion.materialAssetPath;

  @override
  void initState() {
    super.initState();
    _flare = AnimationController(vsync: this, duration: widget.flareDuration);
    _flash = AnimationController(vsync: this, duration: widget.flashDuration);
    _dark = AnimationController(vsync: this, duration: widget.darkDuration);
    _runSequence();
  }

  Future<void> _runSequence() async {
    await _flare.forward();
    if (!mounted) return;
    await _flash.forward();
    if (!mounted) return;
    await _dark.forward();
    if (!mounted) return;
    await Future<void>.delayed(const Duration(milliseconds: 280));
    if (!mounted || _notified) return;
    _notified = true;
    widget.onReachedBlack();
  }

  @override
  void dispose() {
    _flare.dispose();
    _flash.dispose();
    _dark.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final asset = _bloodstoneAsset;
    final color = context.color;
    final black = color.darkMatterSingularityColor;
    final crimson = Color.lerp(black, color.bloodFillGradient.colors.last, 0.55)!;
    final flashStart = color.bloodParticleColor1;
    final flashEnd = color.bloodFillGradient.colors.last;

    return AbsorbPointer(
      child: AnimatedBuilder(
        animation: Listenable.merge([_flare, _flash, _dark]),
        builder: (context, _) {
          final flareT = Curves.easeInCubic.transform(_flare.value);
          final flashT = Curves.easeOut.transform(_flash.value);
          final darkT = Curves.easeIn.transform(_dark.value);

          final stoneSize = size.shortestSide * (0.22 + flareT * 1.65);
          final pulse = 1 + math.sin(flareT * math.pi * 5) * 0.045 * flareT;

          return Stack(
            fit: StackFit.expand,
            children: [
              ColoredBox(
                color: Color.lerp(
                  black,
                  crimson,
                  flareT * 0.85,
                )!.withValues(alpha: 0.4 + flareT * 0.45),
              ),
              if (_dark.value < 1)
                CustomPaint(
                  painter: _BloodGlowPainter(
                    progress: flareT,
                    colors: color,
                  ),
                ),
              if (asset != null && _dark.value < 1)
                Center(
                  child: Transform.scale(
                    scale: pulse,
                    child: Opacity(
                      opacity: (0.6 + flareT * 0.4).clamp(0.0, 1.0),
                      child: ShaderMask(
                        blendMode: BlendMode.dstIn,
                        shaderCallback: (bounds) {
                          return const RadialGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.58, 0.78],
                          ).createShader(bounds);
                        },
                        child: CachedAssetImage(
                          asset: asset,
                          width: stoneSize,
                          height: stoneSize,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.medium,
                        ),
                      ),
                    ),
                  ),
                ),
              if (flashT > 0 && darkT < 0.9)
                ColoredBox(
                  color: Color.lerp(
                    flashStart,
                    flashEnd,
                    flashT,
                  )!.withValues(alpha: flashT * (1 - darkT)),
                ),
              ColoredBox(color: black.withValues(alpha: darkT)),
            ],
          );
        },
      ),
    );
  }
}

class _BloodGlowPainter extends CustomPainter {
  _BloodGlowPainter({required this.progress, required this.colors});

  final double progress;
  final AppColor colors;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radius = size.shortestSide * (0.22 + progress * 1.15);
    final deep = Color.lerp(
      colors.darkMatterSingularityColor,
      colors.bloodFillGradient.colors.last,
      0.45,
    )!;

    final aura = Paint()
      ..shader = RadialGradient(
        colors: [
          colors.bloodCellColor.withValues(alpha: 0.65 * progress),
          colors.bloodFillGradient.colors[1].withValues(alpha: 0.42 * progress),
          deep.withValues(alpha: 0.28 * progress),
          Colors.transparent,
        ],
        stops: const [0.0, 0.32, 0.65, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 1.55));
    canvas.drawCircle(center, radius * 1.55, aura);
  }

  @override
  bool shouldRepaint(covariant _BloodGlowPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.colors != colors;
}
