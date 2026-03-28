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

  factory CellVisualTheme.ice({
    required LinearGradient cellBodyGradient,
    required RadialGradient cellTopCapGradient,
    required RadialGradient cellBottomCapGradient,
    required LinearGradient cellTopRimGradient,
    required LinearGradient cellBottomRimGradient,
    required LinearGradient iceFillGradient,
    required RadialGradient iceGlowGradient,
    required Color iceCrystalColor,
    required Color iceParticleColor1,
    required Color iceParticleColor2,
  }) => CellVisualTheme(
    cellBodyGradient: cellBodyGradient,
    cellTopCapGradient: cellTopCapGradient,
    cellBottomCapGradient: cellBottomCapGradient,
    cellTopRimGradient: cellTopRimGradient,
    cellBottomRimGradient: cellBottomRimGradient,
    energyFillGradient: iceFillGradient,
    energyGlowGradient: iceGlowGradient,
    effectPrimaryColor: iceCrystalColor,
    effectSecondaryColor1: iceParticleColor1,
    effectSecondaryColor2: iceParticleColor2,
    effectType: CellEffectType.iceCubes,
  );

  factory CellVisualTheme.steam({
    required LinearGradient cellBodyGradient,
    required RadialGradient cellTopCapGradient,
    required RadialGradient cellBottomCapGradient,
    required LinearGradient cellTopRimGradient,
    required LinearGradient cellBottomRimGradient,
    required LinearGradient steamFillGradient,
    required RadialGradient steamGlowGradient,
    required Color steamVaporColor,
    required Color steamParticleColor1,
    required Color steamParticleColor2,
  }) => CellVisualTheme(
    cellBodyGradient: cellBodyGradient,
    cellTopCapGradient: cellTopCapGradient,
    cellBottomCapGradient: cellBottomCapGradient,
    cellTopRimGradient: cellTopRimGradient,
    cellBottomRimGradient: cellBottomRimGradient,
    energyFillGradient: steamFillGradient,
    energyGlowGradient: steamGlowGradient,
    effectPrimaryColor: steamVaporColor,
    effectSecondaryColor1: steamParticleColor1,
    effectSecondaryColor2: steamParticleColor2,
    effectType: CellEffectType.risingVapor,
  );

  factory CellVisualTheme.light({
    required LinearGradient cellBodyGradient,
    required RadialGradient cellTopCapGradient,
    required RadialGradient cellBottomCapGradient,
    required LinearGradient cellTopRimGradient,
    required LinearGradient cellBottomRimGradient,
    required LinearGradient lightFillGradient,
    required RadialGradient lightGlowGradient,
    required Color lightBeamColor,
    required Color lightParticleColor1,
    required Color lightParticleColor2,
  }) => CellVisualTheme(
    cellBodyGradient: cellBodyGradient,
    cellTopCapGradient: cellTopCapGradient,
    cellBottomCapGradient: cellBottomCapGradient,
    cellTopRimGradient: cellTopRimGradient,
    cellBottomRimGradient: cellBottomRimGradient,
    energyFillGradient: lightFillGradient,
    energyGlowGradient: lightGlowGradient,
    effectPrimaryColor: lightBeamColor,
    effectSecondaryColor1: lightParticleColor1,
    effectSecondaryColor2: lightParticleColor2,
    effectType: CellEffectType.lightBeams,
  );

  factory CellVisualTheme.molecular({
    required LinearGradient cellBodyGradient,
    required RadialGradient cellTopCapGradient,
    required RadialGradient cellBottomCapGradient,
    required LinearGradient cellTopRimGradient,
    required LinearGradient cellBottomRimGradient,
    required LinearGradient molecularFillGradient,
    required RadialGradient molecularGlowGradient,
    required Color molecularAtomColor,
    required Color molecularParticleColor1,
    required Color molecularParticleColor2,
  }) => CellVisualTheme(
    cellBodyGradient: cellBodyGradient,
    cellTopCapGradient: cellTopCapGradient,
    cellBottomCapGradient: cellBottomCapGradient,
    cellTopRimGradient: cellTopRimGradient,
    cellBottomRimGradient: cellBottomRimGradient,
    energyFillGradient: molecularFillGradient,
    energyGlowGradient: molecularGlowGradient,
    effectPrimaryColor: molecularAtomColor,
    effectSecondaryColor1: molecularParticleColor1,
    effectSecondaryColor2: molecularParticleColor2,
    effectType: CellEffectType.molecularBonds,
  );

  factory CellVisualTheme.bacterial({
    required LinearGradient cellBodyGradient,
    required RadialGradient cellTopCapGradient,
    required RadialGradient cellBottomCapGradient,
    required LinearGradient cellTopRimGradient,
    required LinearGradient cellBottomRimGradient,
    required LinearGradient bacterialFillGradient,
    required RadialGradient bacterialGlowGradient,
    required Color bacterialOrganismColor,
    required Color bacterialParticleColor1,
    required Color bacterialParticleColor2,
  }) => CellVisualTheme(
    cellBodyGradient: cellBodyGradient,
    cellTopCapGradient: cellTopCapGradient,
    cellBottomCapGradient: cellBottomCapGradient,
    cellTopRimGradient: cellTopRimGradient,
    cellBottomRimGradient: cellBottomRimGradient,
    energyFillGradient: bacterialFillGradient,
    energyGlowGradient: bacterialGlowGradient,
    effectPrimaryColor: bacterialOrganismColor,
    effectSecondaryColor1: bacterialParticleColor1,
    effectSecondaryColor2: bacterialParticleColor2,
    effectType: CellEffectType.bacterialColony,
  );

  factory CellVisualTheme.blood({
    required LinearGradient cellBodyGradient,
    required RadialGradient cellTopCapGradient,
    required RadialGradient cellBottomCapGradient,
    required LinearGradient cellTopRimGradient,
    required LinearGradient cellBottomRimGradient,
    required LinearGradient bloodFillGradient,
    required RadialGradient bloodGlowGradient,
    required Color bloodCellColor,
    required Color bloodParticleColor1,
    required Color bloodParticleColor2,
  }) => CellVisualTheme(
    cellBodyGradient: cellBodyGradient,
    cellTopCapGradient: cellTopCapGradient,
    cellBottomCapGradient: cellBottomCapGradient,
    cellTopRimGradient: cellTopRimGradient,
    cellBottomRimGradient: cellBottomRimGradient,
    energyFillGradient: bloodFillGradient,
    energyGlowGradient: bloodGlowGradient,
    effectPrimaryColor: bloodCellColor,
    effectSecondaryColor1: bloodParticleColor1,
    effectSecondaryColor2: bloodParticleColor2,
    effectType: CellEffectType.bloodFlow,
  );

  factory CellVisualTheme.bio({
    required LinearGradient cellBodyGradient,
    required RadialGradient cellTopCapGradient,
    required RadialGradient cellBottomCapGradient,
    required LinearGradient cellTopRimGradient,
    required LinearGradient cellBottomRimGradient,
    required LinearGradient bioFillGradient,
    required RadialGradient bioGlowGradient,
    required Color bioSporeColor,
    required Color bioParticleColor1,
    required Color bioParticleColor2,
  }) => CellVisualTheme(
    cellBodyGradient: cellBodyGradient,
    cellTopCapGradient: cellTopCapGradient,
    cellBottomCapGradient: cellBottomCapGradient,
    cellTopRimGradient: cellTopRimGradient,
    cellBottomRimGradient: cellBottomRimGradient,
    energyFillGradient: bioFillGradient,
    energyGlowGradient: bioGlowGradient,
    effectPrimaryColor: bioSporeColor,
    effectSecondaryColor1: bioParticleColor1,
    effectSecondaryColor2: bioParticleColor2,
    effectType: CellEffectType.bioOrganic,
  );

  factory CellVisualTheme.radiation({
    required LinearGradient cellBodyGradient,
    required RadialGradient cellTopCapGradient,
    required RadialGradient cellBottomCapGradient,
    required LinearGradient cellTopRimGradient,
    required LinearGradient cellBottomRimGradient,
    required LinearGradient radiationFillGradient,
    required RadialGradient radiationGlowGradient,
    required Color radiationWaveColor,
    required Color radiationParticleColor1,
    required Color radiationParticleColor2,
  }) => CellVisualTheme(
    cellBodyGradient: cellBodyGradient,
    cellTopCapGradient: cellTopCapGradient,
    cellBottomCapGradient: cellBottomCapGradient,
    cellTopRimGradient: cellTopRimGradient,
    cellBottomRimGradient: cellBottomRimGradient,
    energyFillGradient: radiationFillGradient,
    energyGlowGradient: radiationGlowGradient,
    effectPrimaryColor: radiationWaveColor,
    effectSecondaryColor1: radiationParticleColor1,
    effectSecondaryColor2: radiationParticleColor2,
    effectType: CellEffectType.radiationDecay,
  );

  factory CellVisualTheme.plasma({
    required LinearGradient cellBodyGradient,
    required RadialGradient cellTopCapGradient,
    required RadialGradient cellBottomCapGradient,
    required LinearGradient cellTopRimGradient,
    required LinearGradient cellBottomRimGradient,
    required LinearGradient plasmaFillGradient,
    required RadialGradient plasmaGlowGradient,
    required Color filamentColor,
    required Color particleColor1,
    required Color particleColor2,
  }) => CellVisualTheme(
    cellBodyGradient: cellBodyGradient,
    cellTopCapGradient: cellTopCapGradient,
    cellBottomCapGradient: cellBottomCapGradient,
    cellTopRimGradient: cellTopRimGradient,
    cellBottomRimGradient: cellBottomRimGradient,
    energyFillGradient: plasmaFillGradient,
    energyGlowGradient: plasmaGlowGradient,
    effectPrimaryColor: filamentColor,
    effectSecondaryColor1: particleColor1,
    effectSecondaryColor2: particleColor2,
    effectType: CellEffectType.plasmaFilament,
  );

  factory CellVisualTheme.darkMatter({
    required LinearGradient cellBodyGradient,
    required RadialGradient cellTopCapGradient,
    required RadialGradient cellBottomCapGradient,
    required LinearGradient cellTopRimGradient,
    required LinearGradient cellBottomRimGradient,
    required LinearGradient darkMatterFillGradient,
    required RadialGradient darkMatterGlowGradient,
    required Color singularityColor,
    required Color particleColor1,
    required Color particleColor2,
  }) => CellVisualTheme(
    cellBodyGradient: cellBodyGradient,
    cellTopCapGradient: cellTopCapGradient,
    cellBottomCapGradient: cellBottomCapGradient,
    cellTopRimGradient: cellTopRimGradient,
    cellBottomRimGradient: cellBottomRimGradient,
    energyFillGradient: darkMatterFillGradient,
    energyGlowGradient: darkMatterGlowGradient,
    effectPrimaryColor: singularityColor,
    effectSecondaryColor1: particleColor1,
    effectSecondaryColor2: particleColor2,
    effectType: CellEffectType.darkMatterSingularity,
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

enum CellEffectType {
  lightning,
  lavaChunks,
  iceCubes,
  risingVapor,
  lightBeams,
  molecularBonds,
  bacterialColony,
  bloodFlow,
  bioOrganic,
  radiationDecay,
  plasmaFilament,
  darkMatterSingularity,
}

extension CellVisualThemeExtension on CellId {
  CellVisualTheme getVisualTheme({
    required CellVisualTheme energyTheme,
    required CellVisualTheme heatTheme,
    required CellVisualTheme iceTheme,
    required CellVisualTheme steamTheme,
    required CellVisualTheme lightTheme,
    required CellVisualTheme molecularTheme,
    required CellVisualTheme bacterialTheme,
    required CellVisualTheme bloodTheme,
    required CellVisualTheme bioTheme,
    required CellVisualTheme radiationTheme,
    required CellVisualTheme plasmaTheme,
    required CellVisualTheme darkMatterTheme,
  }) => switch (this) {
    CellId.heatCell => heatTheme,
    CellId.iceCell => iceTheme,
    CellId.steamCell => steamTheme,
    CellId.lightCell => lightTheme,
    CellId.molecularCell => molecularTheme,
    CellId.bacterialCell => bacterialTheme,
    CellId.bloodCell => bloodTheme,
    CellId.bioCell => bioTheme,
    CellId.radiationCell => radiationTheme,
    CellId.plasmaCell => plasmaTheme,
    CellId.darkMatterCell => darkMatterTheme,
    _ => energyTheme,
  };
}
