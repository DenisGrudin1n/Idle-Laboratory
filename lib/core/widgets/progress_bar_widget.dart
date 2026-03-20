import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';

/// A reusable progress bar widget with percentage display.
///
/// Displays a linear progress indicator with customizable colors and an
/// overlay showing the progress percentage. Used for prestige progress,
/// upgrade progress, etc.
///
/// Example:
/// ```dart
/// ProgressBarWidget(
///   progress: 0.75,
///   height: 8.h,
///   progressColor: Colors.green,
/// )
/// ```
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

  /// Progress value from 0.0 to 1.0
  final double progress;

  /// Height of the progress bar. Defaults to 8.h
  final double? height;

  /// Background color of the progress bar. Defaults to theme's background color
  final Color? backgroundColor;

  /// Color of the progress indicator. Defaults to theme's primary color (or green if >= 1.0)
  final Color? progressColor;

  /// Whether to show percentage text overlay. Defaults to true
  final bool showPercentage;

  /// Border radius of the progress bar. Defaults to 6.r
  final double? borderRadius;

  /// Font size of the percentage text. Defaults to 9.sp
  final double? percentageFontSize;

  /// Shadow color for percentage text. Defaults to theme's background color
  final Color? percentageShadowColor;

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final isUnlocked = progress >= 1.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 6.r),
      child: SizedBox(
        height: height ?? 8.h,
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: (height ?? 8.h) * 1.5,
              child: LinearProgressIndicator(
                value: clampedProgress,
                backgroundColor: backgroundColor ?? context.color.background,
                valueColor: AlwaysStoppedAnimation<Color>(
                  progressColor ??
                      (isUnlocked
                          ? context.color.green
                          : context.color.primary),
                ),
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
                      shadows: <Shadow>[
                        Shadow(
                          color:
                              percentageShadowColor ?? context.color.background,
                          blurRadius: 4,
                        ),
                        Shadow(
                          color:
                              percentageShadowColor ?? context.color.background,
                          blurRadius: 4,
                        ),
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
