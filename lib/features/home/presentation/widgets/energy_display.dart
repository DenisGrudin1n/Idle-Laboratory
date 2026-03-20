import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/lib.dart';

class EnergyDisplay extends StatelessWidget {
  const EnergyDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;

    final EnergyState energyState = context.select(
      (EnergyCubit cubit) => cubit.state,
    );

    final bool useScientific = context.select(
      (SettingsCubit cubit) => cubit.state.isScientificNotation,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
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
