import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/energy/energy_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/settings/settings_bloc.dart';

class EnergyDisplay extends StatelessWidget {
  const EnergyDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final energyState = context.select((EnergyBloc bloc) => bloc.state);
    final useScientific = context.select(
      (SettingsBloc bloc) => bloc.state.isScientificNotation,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            energyState.currentEnergy.format(useScientific: useScientific),
            style: TextStyle(
              color: context.color.titleText,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),
          Text(
            '+${energyState.energyPerSecond.format(useScientific: useScientific)} ${l10n.perSecond}',
            style: TextStyle(
              color: context.color.green,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
