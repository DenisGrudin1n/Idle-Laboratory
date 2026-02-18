import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/cubits/cubits.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BlocBuilder<EnergyCubit, EnergyState>(
                builder: (BuildContext context, EnergyState state) {
                  return BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (BuildContext context, SettingsState settingsState) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: context.color.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: context.color.primary,
                            width: 2.w,
                          ),
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
                              state.currentEnergy.format(
                                useScientific:
                                    settingsState.isScientificNotation,
                              ),
                              style: TextStyle(
                                color: context.color.primaryText,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '${state.energyPerSecond.format(useScientific: settingsState.isScientificNotation)} ${l10n.perSecond}',
                              style: TextStyle(
                                color: context.color.primaryText,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 16.h),
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (BuildContext context, SettingsState state) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.color.secondary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: context.color.secondary,
                        width: 2.w,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          l10n.scientificNotation,
                          style: TextStyle(
                            color: context.color.primaryText,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<SettingsCubit>()
                                .toggleScientificNotation();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: state.isScientificNotation
                                  ? context.color.primary
                                  : context.color.secondary,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              state.isScientificNotation ? l10n.on : l10n.off,
                              style: TextStyle(
                                color: context.color.primaryText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
