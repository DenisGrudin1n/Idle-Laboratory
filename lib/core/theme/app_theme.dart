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
          sectionBorder: DefaultColor.sectionBorder,
          sectionGradient: DefaultColor.sectionGradient,
          cellBodyGradient: DefaultColor.cellBodyGradient,
          cellTopCapGradient: DefaultColor.cellTopCapGradient,
          cellBottomCapGradient: DefaultColor.cellBottomCapGradient,
          cellTopRimGradient: DefaultColor.cellTopRimGradient,
          cellBottomRimGradient: DefaultColor.cellBottomRimGradient,
          energyFillGradient: DefaultColor.energyFillGradient,
          energyGlowGradient: DefaultColor.energyGlowGradient,
          energyLightningColor: DefaultColor.energyLightningColor,
          energyParticleColor1: DefaultColor.energyParticleColor1,
          energyParticleColor2: DefaultColor.energyParticleColor2,
          heatFillGradient: DefaultColor.heatFillGradient,
          heatGlowGradient: DefaultColor.heatGlowGradient,
          heatChunkColor: DefaultColor.heatChunkColor,
          heatEmberColor1: DefaultColor.heatEmberColor1,
          heatEmberColor2: DefaultColor.heatEmberColor2,
          iceFillGradient: DefaultColor.iceFillGradient,
          iceGlowGradient: DefaultColor.iceGlowGradient,
          iceCrystalColor: DefaultColor.iceCrystalColor,
          iceParticleColor1: DefaultColor.iceParticleColor1,
          iceParticleColor2: DefaultColor.iceParticleColor2,
          steamFillGradient: DefaultColor.steamFillGradient,
          steamGlowGradient: DefaultColor.steamGlowGradient,
          steamVaporColor: DefaultColor.steamVaporColor,
          steamParticleColor1: DefaultColor.steamParticleColor1,
          steamParticleColor2: DefaultColor.steamParticleColor2,
        ),
      );

  static ThemeData _base(AppColor color) => ThemeData(
        useMaterial3: false,
        extensions: [color],
        scaffoldBackgroundColor: color.background,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: color.primary),
        ),
      );
}
