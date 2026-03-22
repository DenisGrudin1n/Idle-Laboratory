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
    required this.sectionBorder,
    required this.sectionGradient,
    required this.cellBodyGradient,
    required this.cellTopCapGradient,
    required this.cellBottomCapGradient,
    required this.cellTopRimGradient,
    required this.cellBottomRimGradient,
    required this.energyFillGradient,
    required this.energyGlowGradient,
    required this.energyLightningColor,
    required this.energyParticleColor1,
    required this.energyParticleColor2,
    required this.heatFillGradient,
    required this.heatGlowGradient,
    required this.heatChunkColor,
    required this.heatEmberColor1,
    required this.heatEmberColor2,
  });

  final Color primary;
  final Color secondary;
  final Color accent;
  final Color primaryText;
  final Color background;
  final Color drawerBackground;
  final Color titleText;
  final Color green;
  final Color sectionBorder;
  final LinearGradient sectionGradient;
  final LinearGradient cellBodyGradient;
  final LinearGradient cellTopRimGradient;
  final LinearGradient cellBottomRimGradient;
  final LinearGradient energyFillGradient;
  final LinearGradient heatFillGradient;
  final RadialGradient cellTopCapGradient;
  final RadialGradient cellBottomCapGradient;
  final RadialGradient energyGlowGradient;
  final RadialGradient heatGlowGradient;
  final Color energyLightningColor;
  final Color energyParticleColor1;
  final Color energyParticleColor2;
  final Color heatChunkColor;
  final Color heatEmberColor1;
  final Color heatEmberColor2;

  @override
  AppColor copyWith({
    Color? primary,
    Color? secondary,
    Color? accent,
    Color? primaryText,
    Color? background,
    Color? drawerBackground,
    Color? titleText,
    Color? green,
    Color? sectionBorder,
    LinearGradient? sectionGradient,
    LinearGradient? cellBodyGradient,
    LinearGradient? cellTopRimGradient,
    LinearGradient? cellBottomRimGradient,
    LinearGradient? energyFillGradient,
    LinearGradient? heatFillGradient,
    RadialGradient? cellTopCapGradient,
    RadialGradient? cellBottomCapGradient,
    RadialGradient? energyGlowGradient,
    RadialGradient? heatGlowGradient,
    Color? energyLightningColor,
    Color? energyParticleColor1,
    Color? energyParticleColor2,
    Color? heatChunkColor,
    Color? heatEmberColor1,
    Color? heatEmberColor2,
  }) => AppColor(
    primary: primary ?? this.primary,
    secondary: secondary ?? this.secondary,
    accent: accent ?? this.accent,
    primaryText: primaryText ?? this.primaryText,
    background: background ?? this.background,
    drawerBackground: drawerBackground ?? this.drawerBackground,
    titleText: titleText ?? this.titleText,
    green: green ?? this.green,
    sectionBorder: sectionBorder ?? this.sectionBorder,
    sectionGradient: sectionGradient ?? this.sectionGradient,
    cellBodyGradient: cellBodyGradient ?? this.cellBodyGradient,
    cellTopCapGradient: cellTopCapGradient ?? this.cellTopCapGradient,
    cellBottomCapGradient: cellBottomCapGradient ?? this.cellBottomCapGradient,
    cellTopRimGradient: cellTopRimGradient ?? this.cellTopRimGradient,
    cellBottomRimGradient: cellBottomRimGradient ?? this.cellBottomRimGradient,
    energyFillGradient: energyFillGradient ?? this.energyFillGradient,
    energyGlowGradient: energyGlowGradient ?? this.energyGlowGradient,
    energyLightningColor: energyLightningColor ?? this.energyLightningColor,
    energyParticleColor1: energyParticleColor1 ?? this.energyParticleColor1,
    energyParticleColor2: energyParticleColor2 ?? this.energyParticleColor2,
    heatFillGradient: heatFillGradient ?? this.heatFillGradient,
    heatGlowGradient: heatGlowGradient ?? this.heatGlowGradient,
    heatChunkColor: heatChunkColor ?? this.heatChunkColor,
    heatEmberColor1: heatEmberColor1 ?? this.heatEmberColor1,
    heatEmberColor2: heatEmberColor2 ?? this.heatEmberColor2,
  );

  @override
  AppColor lerp(ThemeExtension<AppColor>? other, double t) {
    if (other is! AppColor) return this;
    return AppColor(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      background: Color.lerp(background, other.background, t)!,
      drawerBackground: Color.lerp(drawerBackground, other.drawerBackground, t)!,
      titleText: Color.lerp(titleText, other.titleText, t)!,
      green: Color.lerp(green, other.green, t)!,
      sectionBorder: Color.lerp(sectionBorder, other.sectionBorder, t)!,
      sectionGradient: LinearGradient.lerp(sectionGradient, other.sectionGradient, t)!,
      cellBodyGradient: LinearGradient.lerp(cellBodyGradient, other.cellBodyGradient, t)!,
      cellTopCapGradient: RadialGradient.lerp(cellTopCapGradient, other.cellTopCapGradient, t)!,
      cellBottomCapGradient: RadialGradient.lerp(cellBottomCapGradient, other.cellBottomCapGradient, t)!,
      cellTopRimGradient: LinearGradient.lerp(cellTopRimGradient, other.cellTopRimGradient, t)!,
      cellBottomRimGradient: LinearGradient.lerp(cellBottomRimGradient, other.cellBottomRimGradient, t)!,
      energyFillGradient: LinearGradient.lerp(energyFillGradient, other.energyFillGradient, t)!,
      energyGlowGradient: RadialGradient.lerp(energyGlowGradient, other.energyGlowGradient, t)!,
      energyLightningColor: Color.lerp(energyLightningColor, other.energyLightningColor, t)!,
      energyParticleColor1: Color.lerp(energyParticleColor1, other.energyParticleColor1, t)!,
      energyParticleColor2: Color.lerp(energyParticleColor2, other.energyParticleColor2, t)!,
      heatFillGradient: LinearGradient.lerp(heatFillGradient, other.heatFillGradient, t)!,
      heatGlowGradient: RadialGradient.lerp(heatGlowGradient, other.heatGlowGradient, t)!,
      heatChunkColor: Color.lerp(heatChunkColor, other.heatChunkColor, t)!,
      heatEmberColor1: Color.lerp(heatEmberColor1, other.heatEmberColor1, t)!,
      heatEmberColor2: Color.lerp(heatEmberColor2, other.heatEmberColor2, t)!,
    );
  }
}

class DefaultColor {
  DefaultColor._();

  static const primary = Color(0xFFB8BAC9);
  static const secondary = Color(0xFF8B7FA1);
  static const accent = Color(0xFFA87489);
  static const primaryText = Color(0xFFB8BAC9);
  static const background = Color(0xFF4F5263);
  static const drawerBackground = Color(0xFF3D4153);
  static const titleText = Color(0xFFE8E9EE);
  static const green = Color(0xFF9DBF99);
  static const sectionBorder = Color(0xFF3A3F50);

  static const sectionGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [drawerBackground, Color(0xFF363A4A)],
  );

  static const cellBodyGradient = LinearGradient(
    colors: [Color(0xFF5A637A), Color(0xFF3D4460), Color(0xFF282E42), Color(0xFF353C55)],
    stops: [0, 0.35, 0.75, 1],
  );

  static const cellTopCapGradient = RadialGradient(
    center: Alignment(-0.3, -0.4),
    colors: [Color(0xFF6E7A99), Color(0xFF454E68), Color(0xFF2C3348)],
    stops: [0, 0.5, 1],
  );

  static const cellBottomCapGradient = RadialGradient(colors: [Color(0xFF3A4259), Color(0xFF1E2333)]);

  static const cellTopRimGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF7A849E), Color(0xFF4E5870), Color(0xFF333B52)],
  );

  static const cellBottomRimGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF3A4259), Color(0xFF4E5870), Color(0xFF5C6680)],
  );

  static const energyFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF227BB0), Color(0xFF0D5F93), Color(0xFF094A74)],
  );

  static const energyGlowGradient = RadialGradient(colors: [Color(0xFF3192C0), Color(0xFF0D5F93), Colors.transparent]);
  static const energyLightningColor = Color(0xFF3D9DC8);
  static const energyParticleColor1 = Color(0xFF56AECF);
  static const energyParticleColor2 = Color(0xFF1F82B5);

  static const heatFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFF6B35), Color(0xFFD73502), Color(0xFF8B1F00)],
  );

  static const heatGlowGradient = RadialGradient(colors: [Color(0xFFFFA500), Color(0xFFD73502), Colors.transparent]);
  static const heatChunkColor = Color(0xFF3D2416);
  static const heatEmberColor1 = Color(0xFFFFB84D);
  static const heatEmberColor2 = Color(0xFFFF7A33);
}
