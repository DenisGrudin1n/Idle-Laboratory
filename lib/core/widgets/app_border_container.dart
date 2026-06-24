import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';

class AppBorderContainer extends StatelessWidget {
  const AppBorderContainer({
    required this.child,
    this.isActive = false,
    this.padding,
    this.margin,
    this.alignment,
    this.borderRadius,
    this.activeColor,
    this.inactiveColor,
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.borderWidth,
    this.clipBehavior = Clip.none,
    super.key,
  });

  final Widget child;
  final bool isActive;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final double? borderRadius;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;
  final double? borderWidth;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isMobile = appVersion == AppVersionEnum.mobile;

        final effectiveBorderRadius = borderRadius ?? (isMobile ? 8.0 : 12.0);
        final effectiveBorderWidth = borderWidth ?? (isMobile ? 1.0 : 2.0);

        final color = isActive
            ? (activeColor ?? context.color.primary.withValues(alpha: 0.3))
            : (inactiveColor ?? Colors.transparent);

        final borderColor = isActive
            ? (activeBorderColor ?? context.color.primary)
            : (inactiveBorderColor ?? Colors.transparent);

        return Container(
          alignment: alignment,
          margin: margin,
          padding: padding,
          clipBehavior: clipBehavior,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
            border: Border.all(color: borderColor, width: effectiveBorderWidth),
          ),
          child: child,
        );
      },
    );
  }
}
