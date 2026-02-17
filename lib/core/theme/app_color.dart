import 'package:flutter/material.dart';

class AppColor extends ThemeExtension<AppColor> {
  AppColor({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.primaryText,
  });

  final Color primary;
  final Color secondary;
  final Color accent;
  final Color primaryText;

  @override
  ThemeExtension<AppColor> copyWith({
    Color? primary,
    Color? secondary,
    Color? accent,
    Color? primaryText,
  }) {
    return AppColor(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent,
      primaryText: primaryText ?? this.primaryText,
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
    );
  }
}

class LightColor {
  LightColor._();

  static const Color primary = Color(0xFF6750A4);
  static const Color secondary = Color(0xFF625B71);
  static const Color accent = Color(0xFF7D5260);
  static const Color primaryText = Color(0xFF1C1B1F);
}

class DarkColor {
  DarkColor._();

  static const Color primary = Color(0xFFD0BCFF);
  static const Color secondary = Color(0xFFCCC2DC);
  static const Color accent = Color(0xFFEFB8C8);
  static const Color primaryText = Color(0xFFE6E1E5);
}
