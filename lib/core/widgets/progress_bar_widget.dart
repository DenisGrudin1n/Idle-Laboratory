import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({
    required this.progress,
    this.height,
    this.backgroundColor,
    this.progressColor,
    this.showPercentage = true,
    this.borderRadius,
    this.percentageFontSize,
    this.percentageShadowColor,
    super.key,
  });

  final double progress;
  final double? height;
  final double? borderRadius;
  final double? percentageFontSize;
  final Color? backgroundColor;
  final Color? progressColor;
  final Color? percentageShadowColor;
  final bool showPercentage;

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final isUnlocked = progress >= 1.0;

    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isMobile = appVersion == AppVersionEnum.mobile;
        final h = height ?? (isMobile ? 12.0 : 20.0);

        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
          child: SizedBox(
            height: h,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: LinearProgressIndicator(
                    value: clampedProgress,
                    backgroundColor: backgroundColor ?? context.color.background,
                    valueColor: AlwaysStoppedAnimation(
                      progressColor ?? (isUnlocked ? context.color.green : context.color.primary),
                    ),
                  ),
                ),
                if (showPercentage)
                  Text(
                    '${(progress * 100).toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: context.color.titleText,
                      fontSize: percentageFontSize ?? (isMobile ? 9 : 11),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(color: percentageShadowColor ?? context.color.background, blurRadius: 4),
                        Shadow(color: percentageShadowColor ?? context.color.background, blurRadius: 4),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
