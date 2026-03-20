import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/extensions/build_context_ext.dart';
import 'package:idle_laboratory/core/theme/theme_ext.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/settings/settings_bloc.dart';

class SettingsToggle extends StatelessWidget {
  const SettingsToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final useScientific = context.select(
      (SettingsBloc bloc) => bloc.state.isScientificNotation,
    );

    return Container(
      margin: EdgeInsets.all(16.w),
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: context.color.drawerBackground,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l10n.scientificNotation,
            style: TextStyle(
              color: context.color.primaryText,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            onTap: () => context.read<SettingsBloc>().add(
              const SettingsEvent.toggleScientificNotation(),
            ),
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: useScientific
                    ? context.color.primary
                    : context.color.background,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                useScientific ? l10n.on : l10n.off,
                style: TextStyle(
                  color: context.color.primaryText,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
