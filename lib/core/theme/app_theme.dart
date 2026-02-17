import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/theme/app_color.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _base(
    AppColor(
      primary: LightColor.primary,
      secondary: LightColor.secondary,
      accent: LightColor.accent,
      primaryText: LightColor.primaryText,
    ),
  );

  static ThemeData get dark => _base(
    AppColor(
      primary: DarkColor.primary,
      secondary: DarkColor.secondary,
      accent: DarkColor.accent,
      primaryText: DarkColor.primaryText,
    ),
  );

  static ThemeData _base(AppColor color) {
    return ThemeData(
      useMaterial3: false,
      extensions: <ThemeExtension<dynamic>>[color],
      scaffoldBackgroundColor: color.accent,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: color.primary),
      ),
    );
  }
}
