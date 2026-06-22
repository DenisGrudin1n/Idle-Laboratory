import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';

/// Centered modal shell: dimmed barrier + [SectionCard] panel. Content is supplied by the caller.
class AppDialog extends StatelessWidget {
  const AppDialog({required this.child, this.maxWidth, this.padding, this.borderRadius, this.insetPadding, super.key});

  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final EdgeInsets? insetPadding;

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    double? maxWidth,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    EdgeInsets? insetPadding,
  }) => showDialog<T>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (_) => AppDialog(
      maxWidth: maxWidth,
      padding: padding,
      borderRadius: borderRadius,
      insetPadding: insetPadding,
      child: child,
    ),
  );

  @override
  Widget build(BuildContext context) => BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
    selector: (state) => state.appVersion,
    builder: (context, appVersion) {
      final isMobile = appVersion == AppVersionEnum.mobile;
      final dialogMaxWidth = maxWidth ?? (isMobile ? 300.w : 400.w);

      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: insetPadding ?? EdgeInsets.symmetric(horizontal: 28.w, vertical: 28.h),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: dialogMaxWidth),
          child: SectionCard(
            borderRadius: borderRadius ?? BorderRadius.circular(14.r),
            padding: padding ?? EdgeInsets.all(isMobile ? 12.w : 16.w),
            child: child,
          ),
        ),
      );
    },
  );
}
