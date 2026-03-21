import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

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
    final h = height ?? 8.h;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 6.r),
      child: SizedBox(
        height: h,
        child: Stack(
          children: [
            SizedBox(
              height: h * 1.5,
              child: LinearProgressIndicator(
                value: clampedProgress,
                backgroundColor: backgroundColor ?? context.color.background,
                valueColor: AlwaysStoppedAnimation(progressColor ?? (isUnlocked ? context.color.green : context.color.primary)),
              ),
            ),
            if (showPercentage)
              Positioned.fill(
                child: Center(
                  child: Text(
                    '${(progress * 100).toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: context.color.titleText,
                      fontSize: percentageFontSize ?? 9.sp,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(color: percentageShadowColor ?? context.color.background, blurRadius: 4),
                        Shadow(color: percentageShadowColor ?? context.color.background, blurRadius: 4),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
