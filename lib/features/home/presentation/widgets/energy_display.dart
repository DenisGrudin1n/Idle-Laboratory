import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../lib.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.color.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.color.primary, width: 2.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            l10n.energyUnits,
            style: TextStyle(
              color: context.color.primaryText,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            energyState.currentEnergy.format(useScientific: useScientific),
            style: TextStyle(
              color: context.color.primaryText,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${energyState.energyPerSecond.format(useScientific: useScientific)} ${l10n.perSecond}',
            style: TextStyle(
              color: context.color.primaryText,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
