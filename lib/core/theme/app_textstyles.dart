import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/core/theme/app_color.dart';

class AppTextStyles {
  const AppTextStyles(this.context);

  final BuildContext context;

  AppColor get _color => Theme.of(context).extension<AppColor>()!;

  TextStyle get sectionHeaderTitle =>
      TextStyle(color: _color.titleText, fontSize: 16.sp, fontWeight: FontWeight.bold);

  TextStyle get sectionHeaderDescription =>
      TextStyle(color: _color.primaryText.withValues(alpha: 0.6), fontSize: 10.sp);

  TextStyle get sectionTitle =>
      TextStyle(color: _color.titleText, fontSize: 14.sp, fontWeight: FontWeight.bold);

  TextStyle get helperText =>
      TextStyle(color: _color.primaryText, fontSize: 10.sp, fontWeight: FontWeight.w400);

  TextStyle get successText =>
      TextStyle(color: _color.green, fontSize: 11.sp, fontWeight: FontWeight.w500);

  TextStyle get energyValue =>
      TextStyle(color: _color.titleText, fontSize: 20.sp, fontWeight: FontWeight.bold);

  TextStyle get bodyLabel =>
      TextStyle(color: _color.primaryText, fontSize: 12.sp, fontWeight: FontWeight.w500);

  TextStyle get buttonLabel =>
      TextStyle(color: _color.primaryText, fontSize: 12.sp, fontWeight: FontWeight.bold);

  TextStyle navigationLabel({required bool isActive}) =>
      TextStyle(color: _color.primaryText, fontSize: 12.sp, fontWeight: isActive ? FontWeight.w600 : FontWeight.w400);

  TextStyle cellName({required bool isLocked}) => TextStyle(
        color: isLocked ? _color.primaryText : _color.titleText,
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
      );

  TextStyle get compactValue =>
      TextStyle(color: _color.primaryText, fontSize: 9.sp, fontWeight: FontWeight.w400);

  TextStyle get compactAccentValue =>
      TextStyle(color: _color.green, fontSize: 9.sp, fontWeight: FontWeight.w500);

  TextStyle get compactSupporting =>
      TextStyle(color: _color.primaryText, fontSize: 9.sp, fontWeight: FontWeight.w500);

  TextStyle get productionRate =>
      TextStyle(color: _color.primaryText.withValues(alpha: 0.8), fontSize: 9.sp, fontWeight: FontWeight.w600);

  TextStyle get productionAmount =>
      TextStyle(color: _color.titleText, fontSize: 10.sp, fontWeight: FontWeight.bold);

  TextStyle get productionButtonLabel =>
      TextStyle(color: _color.titleText, fontSize: 8.sp, fontWeight: FontWeight.w700);

  TextStyle get productionButtonCost =>
      TextStyle(color: _color.green, fontSize: 8.sp, fontWeight: FontWeight.w600);

  TextStyle get prestigeMultiplier =>
      TextStyle(color: _color.primary, fontSize: 10.sp, fontWeight: FontWeight.w500);

  TextStyle prestigeBonus({required bool isUnlocked}) => TextStyle(
        color: isUnlocked ? _color.green : _color.primaryText.withValues(alpha: 0.5),
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
      );
}
