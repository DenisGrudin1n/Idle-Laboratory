import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/theme/app_color.dart';

extension ThemeExtension on BuildContext {
  AppColor get color => Theme.of(this).extension<AppColor>()!;
}
