import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/theme/app_color.dart';
import 'package:idle_laboratory/core/theme/cell_visual_theme.dart';

extension ThemeExt on BuildContext {
  AppColor get color => Theme.of(this).extension<AppColor>()!;

  /// Returns the appropriate [CellVisualTheme] for a given [CellId]
  CellVisualTheme getCellTheme(CellId cellId) {
    final colors = color;

    return cellId.getVisualTheme(
      energyTheme: CellVisualTheme.energy(
        cellBodyGradient: colors.cellBodyGradient,
        cellTopCapGradient: colors.cellTopCapGradient,
        cellBottomCapGradient: colors.cellBottomCapGradient,
        cellTopRimGradient: colors.cellTopRimGradient,
        cellBottomRimGradient: colors.cellBottomRimGradient,
        energyFillGradient: colors.energyFillGradient,
        energyGlowGradient: colors.energyGlowGradient,
        lightningColor: colors.energyLightningColor,
        particleColor1: colors.energyParticleColor1,
        particleColor2: colors.energyParticleColor2,
      ),
      heatTheme: CellVisualTheme.heat(
        cellBodyGradient: colors.cellBodyGradient,
        cellTopCapGradient: colors.cellTopCapGradient,
        cellBottomCapGradient: colors.cellBottomCapGradient,
        cellTopRimGradient: colors.cellTopRimGradient,
        cellBottomRimGradient: colors.cellBottomRimGradient,
        lavaFillGradient: colors.heatFillGradient,
        lavaGlowGradient: colors.heatGlowGradient,
        lavaChunkColor: colors.heatChunkColor,
        emberColor1: colors.heatEmberColor1,
        emberColor2: colors.heatEmberColor2,
      ),
    );
  }
}
