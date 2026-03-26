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
    required this.iceFillGradient,
    required this.iceGlowGradient,
    required this.iceCrystalColor,
    required this.iceParticleColor1,
    required this.iceParticleColor2,
    required this.steamFillGradient,
    required this.steamGlowGradient,
    required this.steamVaporColor,
    required this.steamParticleColor1,
    required this.steamParticleColor2,
    required this.lightFillGradient,
    required this.lightGlowGradient,
    required this.lightBeamColor,
    required this.lightParticleColor1,
    required this.lightParticleColor2,
    required this.molecularFillGradient,
    required this.molecularGlowGradient,
    required this.molecularAtomColor,
    required this.molecularBondColor,
    required this.molecularParticleColor1,
    required this.molecularParticleColor2,
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
  final LinearGradient iceFillGradient;
  final LinearGradient steamFillGradient;
  final LinearGradient lightFillGradient;
  final LinearGradient molecularFillGradient;
  final RadialGradient cellTopCapGradient;
  final RadialGradient cellBottomCapGradient;
  final RadialGradient energyGlowGradient;
  final RadialGradient heatGlowGradient;
  final RadialGradient iceGlowGradient;
  final RadialGradient steamGlowGradient;
  final RadialGradient lightGlowGradient;
  final RadialGradient molecularGlowGradient;
  final Color energyLightningColor;
  final Color energyParticleColor1;
  final Color energyParticleColor2;
  final Color heatChunkColor;
  final Color heatEmberColor1;
  final Color heatEmberColor2;
  final Color iceCrystalColor;
  final Color iceParticleColor1;
  final Color iceParticleColor2;
  final Color steamVaporColor;
  final Color steamParticleColor1;
  final Color steamParticleColor2;
  final Color lightBeamColor;
  final Color lightParticleColor1;
  final Color lightParticleColor2;
  final Color molecularAtomColor;
  final Color molecularBondColor;
  final Color molecularParticleColor1;
  final Color molecularParticleColor2;

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
    LinearGradient? iceFillGradient,
    LinearGradient? steamFillGradient,
    LinearGradient? lightFillGradient,
    LinearGradient? molecularFillGradient,
    RadialGradient? cellTopCapGradient,
    RadialGradient? cellBottomCapGradient,
    RadialGradient? energyGlowGradient,
    RadialGradient? heatGlowGradient,
    RadialGradient? iceGlowGradient,
    RadialGradient? steamGlowGradient,
    RadialGradient? lightGlowGradient,
    RadialGradient? molecularGlowGradient,
    Color? energyLightningColor,
    Color? energyParticleColor1,
    Color? energyParticleColor2,
    Color? heatChunkColor,
    Color? heatEmberColor1,
    Color? heatEmberColor2,
    Color? iceCrystalColor,
    Color? iceParticleColor1,
    Color? iceParticleColor2,
    Color? steamVaporColor,
    Color? steamParticleColor1,
    Color? steamParticleColor2,
    Color? lightBeamColor,
    Color? lightParticleColor1,
    Color? lightParticleColor2,
    Color? molecularAtomColor,
    Color? molecularBondColor,
    Color? molecularParticleColor1,
    Color? molecularParticleColor2,
  }) =>
      AppColor(
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
        iceFillGradient: iceFillGradient ?? this.iceFillGradient,
        iceGlowGradient: iceGlowGradient ?? this.iceGlowGradient,
        iceCrystalColor: iceCrystalColor ?? this.iceCrystalColor,
        iceParticleColor1: iceParticleColor1 ?? this.iceParticleColor1,
        iceParticleColor2: iceParticleColor2 ?? this.iceParticleColor2,
        steamFillGradient: steamFillGradient ?? this.steamFillGradient,
        steamGlowGradient: steamGlowGradient ?? this.steamGlowGradient,
        steamVaporColor: steamVaporColor ?? this.steamVaporColor,
        steamParticleColor1: steamParticleColor1 ?? this.steamParticleColor1,
        steamParticleColor2: steamParticleColor2 ?? this.steamParticleColor2,
        lightFillGradient: lightFillGradient ?? this.lightFillGradient,
        lightGlowGradient: lightGlowGradient ?? this.lightGlowGradient,
        lightBeamColor: lightBeamColor ?? this.lightBeamColor,
        lightParticleColor1: lightParticleColor1 ?? this.lightParticleColor1,
        lightParticleColor2: lightParticleColor2 ?? this.lightParticleColor2,
        molecularFillGradient: molecularFillGradient ?? this.molecularFillGradient,
        molecularGlowGradient: molecularGlowGradient ?? this.molecularGlowGradient,
        molecularAtomColor: molecularAtomColor ?? this.molecularAtomColor,
        molecularBondColor: molecularBondColor ?? this.molecularBondColor,
        molecularParticleColor1: molecularParticleColor1 ?? this.molecularParticleColor1,
        molecularParticleColor2: molecularParticleColor2 ?? this.molecularParticleColor2,
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
      iceFillGradient: LinearGradient.lerp(iceFillGradient, other.iceFillGradient, t)!,
      iceGlowGradient: RadialGradient.lerp(iceGlowGradient, other.iceGlowGradient, t)!,
      iceCrystalColor: Color.lerp(iceCrystalColor, other.iceCrystalColor, t)!,
      iceParticleColor1: Color.lerp(iceParticleColor1, other.iceParticleColor1, t)!,
      iceParticleColor2: Color.lerp(iceParticleColor2, other.iceParticleColor2, t)!,
      steamFillGradient: LinearGradient.lerp(steamFillGradient, other.steamFillGradient, t)!,
      steamGlowGradient: RadialGradient.lerp(steamGlowGradient, other.steamGlowGradient, t)!,
      steamVaporColor: Color.lerp(steamVaporColor, other.steamVaporColor, t)!,
      steamParticleColor1: Color.lerp(steamParticleColor1, other.steamParticleColor1, t)!,
      steamParticleColor2: Color.lerp(steamParticleColor2, other.steamParticleColor2, t)!,
      lightFillGradient: LinearGradient.lerp(lightFillGradient, other.lightFillGradient, t)!,
      lightGlowGradient: RadialGradient.lerp(lightGlowGradient, other.lightGlowGradient, t)!,
      lightBeamColor: Color.lerp(lightBeamColor, other.lightBeamColor, t)!,
      lightParticleColor1: Color.lerp(lightParticleColor1, other.lightParticleColor1, t)!,
      lightParticleColor2: Color.lerp(lightParticleColor2, other.lightParticleColor2, t)!,
      molecularFillGradient: LinearGradient.lerp(molecularFillGradient, other.molecularFillGradient, t)!,
      molecularGlowGradient: RadialGradient.lerp(molecularGlowGradient, other.molecularGlowGradient, t)!,
      molecularAtomColor: Color.lerp(molecularAtomColor, other.molecularAtomColor, t)!,
      molecularBondColor: Color.lerp(molecularBondColor, other.molecularBondColor, t)!,
      molecularParticleColor1: Color.lerp(molecularParticleColor1, other.molecularParticleColor1, t)!,
      molecularParticleColor2: Color.lerp(molecularParticleColor2, other.molecularParticleColor2, t)!,
    );
  }
}

class DefaultColor {
  DefaultColor._();

  static const primary = Color(0xFFB8BAC9);
  static const secondary = Color(0xFF8B7FA1);
  static const accent = Color(0xFFA87489);
  static const primaryText = Color(0xFFB8BAC9);
  static const background = Color(0xFF454856);
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

  static const iceFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFE0F7FA), Color(0xFF80DEEA), Color(0xFF00ACC1)],
  );

  static const iceGlowGradient = RadialGradient(colors: [Color(0xFFB2EBF2), Color(0xFF00ACC1), Colors.transparent]);
  static const iceCrystalColor = Colors.white;
  static const iceParticleColor1 = Color(0xFFE0F7FA);
  static const iceParticleColor2 = Color(0xFF80DEEA);

  static const steamFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFE0E0E0), Color(0xFF9E9E9E)],
  );

  static const steamGlowGradient = RadialGradient(colors: [Color(0xFFF5F5F5), Color(0xFF9E9E9E), Colors.transparent]);
  static const steamVaporColor = Color.fromARGB(255, 125, 125, 125);
  static const steamParticleColor1 = Color(0xFFFAFAFA);
  static const steamParticleColor2 = Color(0xFFE0E0E0);

  static const lightFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFF3E5F5), Color(0xFFE1BEE7)], // Pure White to Pale Violet
  );

  static const lightGlowGradient = RadialGradient(colors: [Colors.white, Color(0xFFCE93D8), Colors.transparent]);
  static const lightBeamColor = Colors.white;
  static const lightParticleColor1 = Colors.white;
  static const lightParticleColor2 = Color(0xFFB39DDB); // Deep Lavender

  static const molecularFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFE1BEE7), Color(0xFFBA68C8), Color(0xFF8E24AA)],
  );

  static const molecularGlowGradient = RadialGradient(colors: [Color(0xFFE1BEE7), Color(0xFF8E24AA), Colors.transparent]);
  static const molecularAtomColor = Color(0xFFB2EBF2);
  static const molecularBondColor = Color(0xB3FFFFFF);
  static const molecularParticleColor1 = Color(0xFFCE93D8);
  static const molecularParticleColor2 = Color(0xFF80CBC4);
}
