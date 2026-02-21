import 'package:flutter/material.dart';

class AppColor extends ThemeExtension<AppColor> {
  AppColor({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.primaryText,
    required this.background,
    required this.drawerBackground,
    required this.titleText,
    required this.green,
  });

  final Color primary;
  final Color secondary;
  final Color accent;
  final Color primaryText;
  final Color background;
  final Color drawerBackground;
  final Color titleText;
  final Color green;

  @override
  ThemeExtension<AppColor> copyWith({
    Color? primary,
    Color? secondary,
    Color? accent,
    Color? primaryText,
    Color? background,
    Color? drawerBackground,
    Color? titleText,
    Color? green,
  }) {
    return AppColor(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent,
      primaryText: primaryText ?? this.primaryText,
      background: background ?? this.background,
      drawerBackground: drawerBackground ?? this.drawerBackground,
      titleText: titleText ?? this.titleText,
      green: green ?? this.green,
    );
  }

  @override
  ThemeExtension<AppColor> lerp(
    covariant ThemeExtension<AppColor>? other,
    double t,
  ) {
    if (other is! AppColor) {
      return this;
    }

    return AppColor(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      background: Color.lerp(background, other.background, t)!,
      drawerBackground: Color.lerp(
        drawerBackground,
        other.drawerBackground,
        t,
      )!,
      titleText: Color.lerp(titleText, other.titleText, t)!,
      green: Color.lerp(green, other.green, t)!,
    );
  }
}

class DefaultColor {
  DefaultColor._();
  static const Color primary = Color(0xFFB8BAC9); // Primary text/icon color
  static const Color secondary = Color(0xFF8B7FA1);
  static const Color accent = Color(0xFFA87489);
  static const Color primaryText = Color(0xFFB8BAC9); // Drawer text
  static const Color background = Color(0xFF6B6D7E); // Main background
  static const Color drawerBackground = Color(0xFF3D4153); // Drawer background
  static const Color titleText = Color(0xFFE8E9EE); // Title text color
  static const Color green = Color(0xFF9DBF99); // Green accent
}
