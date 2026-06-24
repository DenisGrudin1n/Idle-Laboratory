import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';

class EnergyIcon extends StatelessWidget {
  const EnergyIcon({this.sizeMultiplier = 1.0, super.key});
  final double sizeMultiplier;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        final isDesk = appVersion == AppVersionEnum.desk;
        final isTablet = appVersion == AppVersionEnum.tablet;
        final size = isDesk
            ? 17
            : isTablet
            ? 14
            : 11;
        return Icon(Icons.bolt, color: context.color.green, size: size * sizeMultiplier);
      },
    );
  }
}
