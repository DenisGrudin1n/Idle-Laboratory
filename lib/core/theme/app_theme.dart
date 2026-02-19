import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/theme/app_color.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get defaultTheme => _base(
    AppColor(
      primary: DefaultColor.primary,
      secondary: DefaultColor.secondary,
      accent: DefaultColor.accent,
      primaryText: DefaultColor.primaryText,
      background: DefaultColor.background,
      drawerBackground: DefaultColor.drawerBackground,
      titleText: DefaultColor.titleText,
      green: DefaultColor.green,
    ),
  );

  static ThemeData _base(AppColor color) {
    return ThemeData(
      useMaterial3: false,
      extensions: <ThemeExtension<dynamic>>[color],
      scaffoldBackgroundColor: color.background,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: color.primary),
      ),
    );
  }
}
