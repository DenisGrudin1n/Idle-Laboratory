import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';

class CellVisualTheme {
  const CellVisualTheme({
    required this.cellBodyGradient,
    required this.cellTopCapGradient,
    required this.cellBottomCapGradient,
    required this.cellTopRimGradient,
    required this.cellBottomRimGradient,
    required this.energyFillGradient,
    required this.energyGlowGradient,
    required this.effectPrimaryColor,
    required this.effectSecondaryColor1,
    required this.effectSecondaryColor2,
    required this.effectType,
  });

  factory CellVisualTheme.energy({
    required LinearGradient cellBodyGradient,
    required RadialGradient cellTopCapGradient,
    required RadialGradient cellBottomCapGradient,
    required LinearGradient cellTopRimGradient,
    required LinearGradient cellBottomRimGradient,
    required LinearGradient energyFillGradient,
    required RadialGradient energyGlowGradient,
    required Color lightningColor,
    required Color particleColor1,
    required Color particleColor2,
  }) => CellVisualTheme(
    cellBodyGradient: cellBodyGradient,
    cellTopCapGradient: cellTopCapGradient,
    cellBottomCapGradient: cellBottomCapGradient,
    cellTopRimGradient: cellTopRimGradient,
    cellBottomRimGradient: cellBottomRimGradient,
    energyFillGradient: energyFillGradient,
    energyGlowGradient: energyGlowGradient,
    effectPrimaryColor: lightningColor,
    effectSecondaryColor1: particleColor1,
    effectSecondaryColor2: particleColor2,
    effectType: CellEffectType.lightning,
  );

  factory CellVisualTheme.heat({
    required LinearGradient cellBodyGradient,
    required RadialGradient cellTopCapGradient,
    required RadialGradient cellBottomCapGradient,
    required LinearGradient cellTopRimGradient,
    required LinearGradient cellBottomRimGradient,
    required LinearGradient lavaFillGradient,
    required RadialGradient lavaGlowGradient,
    required Color lavaChunkColor,
    required Color emberColor1,
    required Color emberColor2,
  }) => CellVisualTheme(
    cellBodyGradient: cellBodyGradient,
    cellTopCapGradient: cellTopCapGradient,
    cellBottomCapGradient: cellBottomCapGradient,
    cellTopRimGradient: cellTopRimGradient,
    cellBottomRimGradient: cellBottomRimGradient,
    energyFillGradient: lavaFillGradient,
    energyGlowGradient: lavaGlowGradient,
    effectPrimaryColor: lavaChunkColor,
    effectSecondaryColor1: emberColor1,
    effectSecondaryColor2: emberColor2,
    effectType: CellEffectType.lavaChunks,
  );

  final LinearGradient cellBodyGradient;
  final LinearGradient cellTopRimGradient;
  final LinearGradient cellBottomRimGradient;
  final LinearGradient energyFillGradient;
  final RadialGradient cellTopCapGradient;
  final RadialGradient cellBottomCapGradient;
  final RadialGradient energyGlowGradient;
  final Color effectPrimaryColor;
  final Color effectSecondaryColor1;
  final Color effectSecondaryColor2;
  final CellEffectType effectType;
}

enum CellEffectType { lightning, lavaChunks }

extension CellVisualThemeExtension on CellId {
  CellVisualTheme getVisualTheme({
    required CellVisualTheme energyTheme,
    required CellVisualTheme heatTheme,
  }) => switch (this) {
    CellId.heatCell => heatTheme,
    _ => energyTheme,
  };
}
