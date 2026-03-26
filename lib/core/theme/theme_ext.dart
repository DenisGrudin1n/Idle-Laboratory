import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/theme/app_color.dart';
import 'package:idle_laboratory/core/theme/cell_visual_theme.dart';

extension ThemeExt on BuildContext {
  AppColor get color => Theme.of(this).extension<AppColor>()!;

  CellVisualTheme getCellTheme(CellId cellId) => cellId.getVisualTheme(
    energyTheme: CellVisualTheme.energy(
      cellBodyGradient: color.cellBodyGradient,
      cellTopCapGradient: color.cellTopCapGradient,
      cellBottomCapGradient: color.cellBottomCapGradient,
      cellTopRimGradient: color.cellTopRimGradient,
      cellBottomRimGradient: color.cellBottomRimGradient,
      energyFillGradient: color.energyFillGradient,
      energyGlowGradient: color.energyGlowGradient,
      lightningColor: color.energyLightningColor,
      particleColor1: color.energyParticleColor1,
      particleColor2: color.energyParticleColor2,
    ),
    heatTheme: CellVisualTheme.heat(
      cellBodyGradient: color.cellBodyGradient,
      cellTopCapGradient: color.cellTopCapGradient,
      cellBottomCapGradient: color.cellBottomCapGradient,
      cellTopRimGradient: color.cellTopRimGradient,
      cellBottomRimGradient: color.cellBottomRimGradient,
      lavaFillGradient: color.heatFillGradient,
      lavaGlowGradient: color.heatGlowGradient,
      lavaChunkColor: color.heatChunkColor,
      emberColor1: color.heatEmberColor1,
      emberColor2: color.heatEmberColor2,
    ),
    iceTheme: CellVisualTheme.ice(
      cellBodyGradient: color.cellBodyGradient,
      cellTopCapGradient: color.cellTopCapGradient,
      cellBottomCapGradient: color.cellBottomCapGradient,
      cellTopRimGradient: color.cellTopRimGradient,
      cellBottomRimGradient: color.cellBottomRimGradient,
      iceFillGradient: color.iceFillGradient,
      iceGlowGradient: color.iceGlowGradient,
      iceCrystalColor: color.iceCrystalColor,
      iceParticleColor1: color.iceParticleColor1,
      iceParticleColor2: color.iceParticleColor2,
    ),
    steamTheme: CellVisualTheme.steam(
      cellBodyGradient: color.cellBodyGradient,
      cellTopCapGradient: color.cellTopCapGradient,
      cellBottomCapGradient: color.cellBottomCapGradient,
      cellTopRimGradient: color.cellTopRimGradient,
      cellBottomRimGradient: color.cellBottomRimGradient,
      steamFillGradient: color.steamFillGradient,
      steamGlowGradient: color.steamGlowGradient,
      steamVaporColor: color.steamVaporColor,
      steamParticleColor1: color.steamParticleColor1,
      steamParticleColor2: color.steamParticleColor2,
    ),
    lightTheme: CellVisualTheme.light(
      cellBodyGradient: color.cellBodyGradient,
      cellTopCapGradient: color.cellTopCapGradient,
      cellBottomCapGradient: color.cellBottomCapGradient,
      cellTopRimGradient: color.cellTopRimGradient,
      cellBottomRimGradient: color.cellBottomRimGradient,
      lightFillGradient: color.lightFillGradient,
      lightGlowGradient: color.lightGlowGradient,
      lightBeamColor: color.lightBeamColor,
      lightParticleColor1: color.lightParticleColor1,
      lightParticleColor2: color.lightParticleColor2,
    ),
    molecularTheme: CellVisualTheme.molecular(
      cellBodyGradient: color.cellBodyGradient,
      cellTopCapGradient: color.cellTopCapGradient,
      cellBottomCapGradient: color.cellBottomCapGradient,
      cellTopRimGradient: color.cellTopRimGradient,
      cellBottomRimGradient: color.cellBottomRimGradient,
      molecularFillGradient: color.molecularFillGradient,
      molecularGlowGradient: color.molecularGlowGradient,
      molecularAtomColor: color.molecularAtomColor,
      molecularParticleColor1: color.molecularParticleColor1,
      molecularParticleColor2: color.molecularParticleColor2,
    ),
  );
}
