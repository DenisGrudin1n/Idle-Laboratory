import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/constants/story_constants.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/extensions/research_material_id_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/core/widgets/cached_asset_image.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/scaled_lore_text.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/story_dialog_layout.dart';

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
    final size = MediaQuery.sizeOf(context);
    final isLandscape = size.width > size.height;
    final stoneSize = size.shortestSide * (isLandscape ? 0.28 : 0.26);
    final backdrop = color.darkMatterFillGradient.colors.first;
    final deep = color.darkMatterFillGradient.colors[1];
    final bloodTint = Color.lerp(color.bloodFillGradient.colors.last, backdrop, 0.55)!;

    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final metrics = StoryDialogMetrics.forVersion(appVersion);
        final isMobile = appVersion == AppVersionEnum.mobile;

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
                  padding: EdgeInsets.symmetric(horizontal: isLandscape ? 40 : 28, vertical: isLandscape ? 16 : 24),
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
                            SizedBox(height: metrics.titleBodyGap),
                            Flexible(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: isLandscape ? 520 : 360),
                                child: LoreBodyText(
                                  text: l10n.endingToBeContinuedDesc,
                                  fontSize: isLandscape ? 14 : 15,
                                  centered: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: metrics.buttonTopGap),
                      Align(
                        child: SizedBox(
                          width: size.width * StoryConstants.loreContinueButtonWidthFactor,
                          child: Material(
                            color: color.titleText,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: isMobile ? 12 : 14),
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
