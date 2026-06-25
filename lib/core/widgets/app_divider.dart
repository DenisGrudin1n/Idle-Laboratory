import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({this.height, this.thickness, this.indent, this.endIndent, this.color, super.key});

  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isMobile = appVersion == AppVersionEnum.mobile;

        final effectiveThickness = thickness ?? (isMobile ? 1.0 : 1.5);
        final effectiveHeight = height ?? (isMobile ? 1.0 : 1.5);

        return Divider(
          height: effectiveHeight,
          thickness: effectiveThickness,
          indent: indent,
          endIndent: endIndent,
          color: color,
        );
      },
    );
  }
}
