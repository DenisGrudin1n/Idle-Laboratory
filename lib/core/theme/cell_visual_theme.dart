import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';

/// Visual theme for a specific cell type's container and energy effects.
///
/// Defines all colors, gradients, and visual parameters needed to render
/// a cell's 3D container and animated energy fill with unique styling.
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

  /// Factory: Energy cell theme (blue electric)
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

  /// Factory: Heat cell theme (red/orange lava)
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

  // ── Cell container (3D jar) ──────────────────────────────────────────────
  final LinearGradient cellBodyGradient;
  final RadialGradient cellTopCapGradient;
  final RadialGradient cellBottomCapGradient;
  final LinearGradient cellTopRimGradient;
  final LinearGradient cellBottomRimGradient;

  // ── Energy fill & glow ───────────────────────────────────────────────────
  final LinearGradient energyFillGradient;
  final RadialGradient energyGlowGradient;

  // ── Visual effects ───────────────────────────────────────────────────────
  /// Primary color for the main effect (e.g., lightning color, lava chunk color)
  final Color effectPrimaryColor;

  /// First accent color for secondary effects (e.g., particles, sparks)
  final Color effectSecondaryColor1;

  /// Second accent color for secondary effects
  final Color effectSecondaryColor2;

  /// Type of visual effect to render in the energy fill
  final CellEffectType effectType;
}

/// Defines the type of animated effect rendered in the energy fill
enum CellEffectType {
  /// Electric lightning bolts (energy cell)
  lightning,

  /// Floating lava chunks / dirt pieces (heat cell)
  lavaChunks,
}

/// Extension to get the appropriate visual theme for a cell ID
extension CellVisualThemeExtension on CellId {
  /// Returns the visual theme for this cell type
  CellVisualTheme getVisualTheme({
    required CellVisualTheme energyTheme,
    required CellVisualTheme heatTheme,
  }) {
    switch (this) {
      case CellId.basicEnergyCell:
        return energyTheme;
      case CellId.heatCell:
        return heatTheme;
      case CellId.iceCell:
      case CellId.darkMatterCell:
        // TODO: Implement ice and dark matter themes
        return energyTheme; // Fallback for now
    }
  }
}
