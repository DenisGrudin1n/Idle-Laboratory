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
      );
}
