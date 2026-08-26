import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/research_material_id_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/cached_asset_image.dart';

/// Full-screen epilogue after the evil-magician reveal.
class ToBeContinuedScreen extends StatelessWidget {
  const ToBeContinuedScreen({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push<void>(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) => const ToBeContinuedScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = context.color;
    final media = MediaQuery.of(context);
    final isLandscape = media.size.width > media.size.height;
    final stoneSize = media.size.shortestSide * (isLandscape ? 0.28 : 0.26);
    final backdrop = color.darkMatterFillGradient.colors.first;
    final deep = color.darkMatterFillGradient.colors[1];
    final bloodTint = Color.lerp(
      color.bloodFillGradient.colors.last,
      backdrop,
      0.55,
    )!;

    return Scaffold(
      backgroundColor: backdrop,
      body: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.15),
                radius: 0.95,
                colors: [bloodTint, backdrop, deep],
                stops: const [0.0, 0.45, 1.0],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isLandscape ? 40 : 28,
                vertical: isLandscape ? 16 : 24,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _MaskedBloodstone(size: stoneSize),
                        SizedBox(height: isLandscape ? 16 : 24),
                        Text(
                          l10n.endingToBeContinuedTitle,
                          style: context.styles.sectionTitle.copyWith(
                            fontSize: isLandscape ? 26 : 30,
                            letterSpacing: 1.4,
                            height: 1.15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: isLandscape ? 12 : 16),
                        Flexible(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: isLandscape ? 520 : 360,
                            ),
                            child: _ScaledEpilogueText(
                              text: l10n.endingToBeContinuedDesc,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: color.titleText,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: isLandscape ? 12 : 14,
                          ),
                          child: Text(
                            l10n.endingToBeContinuedClose,
                            textAlign: TextAlign.center,
                            style: context.styles.buttonLabel.copyWith(
                              color: color.background,
                              fontSize: isLandscape ? 13 : 15,
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
        ],
      ),
    );
  }
}

class _MaskedBloodstone extends StatelessWidget {
  const _MaskedBloodstone({required this.size});

  final double size;

  static final String? _asset = ResearchMaterialId.bloodstoneOfDominion.materialAssetPath;

  @override
  Widget build(BuildContext context) {
    final asset = _asset;
    if (asset == null) return SizedBox(height: size);

    return SizedBox(
      width: size,
      height: size,
      child: ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (bounds) {
          return const RadialGradient(
            colors: [Colors.white, Colors.white, Colors.transparent],
            stops: [0.0, 0.58, 0.78],
          ).createShader(bounds);
        },
        child: CachedAssetImage(
          asset: asset,
          width: size,
          height: size,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.medium,
        ),
      ),
    );
  }
}

/// Picks the largest epilogue font size that still fits the available box.
class _ScaledEpilogueText extends StatelessWidget {
  const _ScaledEpilogueText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final baseColor = context.color.primaryText.withValues(alpha: 0.88);

    return LayoutBuilder(
      builder: (context, constraints) {
        const minSize = 12.0;
        const maxSize = 16.0;
        var fontSize = minSize;

        for (var size = maxSize; size >= minSize; size -= 0.5) {
          final painter = TextPainter(
            text: TextSpan(
              text: text,
              style: TextStyle(fontSize: size, height: 1.5, color: baseColor),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: constraints.maxWidth);

          if (painter.height <= constraints.maxHeight) {
            fontSize = size;
            break;
          }
        }

        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Text(
              text,
              style: TextStyle(fontSize: fontSize, height: 1.5, color: baseColor),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
