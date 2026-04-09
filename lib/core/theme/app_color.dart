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
    required this.bacterialFillGradient,
    required this.bacterialGlowGradient,
    required this.bacterialOrganismColor,
    required this.bacterialParticleColor1,
    required this.bacterialParticleColor2,
    required this.bloodFillGradient,
    required this.bloodGlowGradient,
    required this.bloodCellColor,
    required this.bloodParticleColor1,
    required this.bloodParticleColor2,
    required this.bioFillGradient,
    required this.bioGlowGradient,
    required this.bioSporeColor,
    required this.bioParticleColor1,
    required this.bioParticleColor2,
    required this.radiationFillGradient,
    required this.radiationGlowGradient,
    required this.radiationWaveColor,
    required this.radiationParticleColor1,
    required this.radiationParticleColor2,
    required this.plasmaFillGradient,
    required this.plasmaGlowGradient,
    required this.plasmaFilamentColor,
    required this.plasmaParticleColor1,
    required this.plasmaParticleColor2,
    required this.darkMatterFillGradient,
    required this.darkMatterGlowGradient,
    required this.darkMatterSingularityColor,
    required this.darkMatterParticleColor1,
    required this.darkMatterParticleColor2,
    required this.magneticFillGradient,
    required this.magneticGlowGradient,
    required this.magneticFieldLineColor,
    required this.magneticParticleColor1,
    required this.magneticParticleColor2,
    required this.crystallineFillGradient,
    required this.crystallineGlowGradient,
    required this.crystallineFacetColor,
    required this.crystallineParticleColor1,
    required this.crystallineParticleColor2,
    required this.geneticFillGradient,
    required this.geneticGlowGradient,
    required this.geneticHelixColor,
    required this.geneticParticleColor1,
    required this.geneticParticleColor2,
    required this.nuclearFillGradient,
    required this.nuclearGlowGradient,
    required this.nuclearCoreColor,
    required this.nuclearParticleColor1,
    required this.nuclearParticleColor2,
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
  final LinearGradient bacterialFillGradient;
  final LinearGradient bloodFillGradient;
  final LinearGradient bioFillGradient;
  final LinearGradient radiationFillGradient;
  final LinearGradient plasmaFillGradient;
  final LinearGradient darkMatterFillGradient;
  final LinearGradient magneticFillGradient;
  final LinearGradient crystallineFillGradient;
  final LinearGradient geneticFillGradient;
  final LinearGradient nuclearFillGradient;
  final RadialGradient cellTopCapGradient;
  final RadialGradient cellBottomCapGradient;
  final RadialGradient energyGlowGradient;
  final RadialGradient heatGlowGradient;
  final RadialGradient iceGlowGradient;
  final RadialGradient steamGlowGradient;
  final RadialGradient lightGlowGradient;
  final RadialGradient molecularGlowGradient;
  final RadialGradient bacterialGlowGradient;
  final RadialGradient bloodGlowGradient;
  final RadialGradient bioGlowGradient;
  final RadialGradient radiationGlowGradient;
  final RadialGradient plasmaGlowGradient;
  final RadialGradient darkMatterGlowGradient;
  final RadialGradient magneticGlowGradient;
  final RadialGradient crystallineGlowGradient;
  final RadialGradient geneticGlowGradient;
  final RadialGradient nuclearGlowGradient;
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
  final Color bacterialOrganismColor;
  final Color bacterialParticleColor1;
  final Color bacterialParticleColor2;
  final Color bloodCellColor;
  final Color bloodParticleColor1;
  final Color bloodParticleColor2;
  final Color bioSporeColor;
  final Color bioParticleColor1;
  final Color bioParticleColor2;
  final Color radiationWaveColor;
  final Color radiationParticleColor1;
  final Color radiationParticleColor2;
  final Color plasmaFilamentColor;
  final Color plasmaParticleColor1;
  final Color plasmaParticleColor2;
  final Color darkMatterSingularityColor;
  final Color darkMatterParticleColor1;
  final Color darkMatterParticleColor2;
  final Color magneticFieldLineColor;
  final Color magneticParticleColor1;
  final Color magneticParticleColor2;
  final Color crystallineFacetColor;
  final Color crystallineParticleColor1;
  final Color crystallineParticleColor2;
  final Color geneticHelixColor;
  final Color geneticParticleColor1;
  final Color geneticParticleColor2;
  final Color nuclearCoreColor;
  final Color nuclearParticleColor1;
  final Color nuclearParticleColor2;

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
    LinearGradient? bacterialFillGradient,
    LinearGradient? bloodFillGradient,
    LinearGradient? bioFillGradient,
    LinearGradient? radiationFillGradient,
    LinearGradient? plasmaFillGradient,
    LinearGradient? darkMatterFillGradient,
    LinearGradient? magneticFillGradient,
    LinearGradient? crystallineFillGradient,
    LinearGradient? geneticFillGradient,
    LinearGradient? nuclearFillGradient,
    RadialGradient? cellTopCapGradient,
    RadialGradient? cellBottomCapGradient,
    RadialGradient? energyGlowGradient,
    RadialGradient? heatGlowGradient,
    RadialGradient? iceGlowGradient,
    RadialGradient? steamGlowGradient,
    RadialGradient? lightGlowGradient,
    RadialGradient? molecularGlowGradient,
    RadialGradient? bacterialGlowGradient,
    RadialGradient? bloodGlowGradient,
    RadialGradient? bioGlowGradient,
    RadialGradient? radiationGlowGradient,
    RadialGradient? plasmaGlowGradient,
    RadialGradient? darkMatterGlowGradient,
    RadialGradient? magneticGlowGradient,
    RadialGradient? crystallineGlowGradient,
    RadialGradient? geneticGlowGradient,
    RadialGradient? nuclearGlowGradient,
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
    Color? bacterialOrganismColor,
    Color? bacterialParticleColor1,
    Color? bacterialParticleColor2,
    Color? bloodCellColor,
    Color? bloodParticleColor1,
    Color? bloodParticleColor2,
    Color? bioSporeColor,
    Color? bioParticleColor1,
    Color? bioParticleColor2,
    Color? radiationWaveColor,
    Color? radiationParticleColor1,
    Color? radiationParticleColor2,
    Color? plasmaFilamentColor,
    Color? plasmaParticleColor1,
    Color? plasmaParticleColor2,
    Color? darkMatterSingularityColor,
    Color? darkMatterParticleColor1,
    Color? darkMatterParticleColor2,
    Color? magneticFieldLineColor,
    Color? magneticParticleColor1,
    Color? magneticParticleColor2,
    Color? crystallineFacetColor,
    Color? crystallineParticleColor1,
    Color? crystallineParticleColor2,
    Color? geneticHelixColor,
    Color? geneticParticleColor1,
    Color? geneticParticleColor2,
    Color? nuclearCoreColor,
    Color? nuclearParticleColor1,
    Color? nuclearParticleColor2,
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
        bacterialFillGradient: bacterialFillGradient ?? this.bacterialFillGradient,
        bacterialGlowGradient: bacterialGlowGradient ?? this.bacterialGlowGradient,
        bacterialOrganismColor: bacterialOrganismColor ?? this.bacterialOrganismColor,
        bacterialParticleColor1: bacterialParticleColor1 ?? this.bacterialParticleColor1,
        bacterialParticleColor2: bacterialParticleColor2 ?? this.bacterialParticleColor2,
        bloodFillGradient: bloodFillGradient ?? this.bloodFillGradient,
        bloodGlowGradient: bloodGlowGradient ?? this.bloodGlowGradient,
        bloodCellColor: bloodCellColor ?? this.bloodCellColor,
        bloodParticleColor1: bloodParticleColor1 ?? this.bloodParticleColor1,
        bloodParticleColor2: bloodParticleColor2 ?? this.bloodParticleColor2,
        bioFillGradient: bioFillGradient ?? this.bioFillGradient,
        bioGlowGradient: bioGlowGradient ?? this.bioGlowGradient,
        bioSporeColor: bioSporeColor ?? this.bioSporeColor,
        bioParticleColor1: bioParticleColor1 ?? this.bioParticleColor1,
        bioParticleColor2: bioParticleColor2 ?? this.bioParticleColor2,
        radiationFillGradient: radiationFillGradient ?? this.radiationFillGradient,
        radiationGlowGradient: radiationGlowGradient ?? this.radiationGlowGradient,
        radiationWaveColor: radiationWaveColor ?? this.radiationWaveColor,
        radiationParticleColor1: radiationParticleColor1 ?? this.radiationParticleColor1,
        radiationParticleColor2: radiationParticleColor2 ?? this.radiationParticleColor2,
        plasmaFillGradient: plasmaFillGradient ?? this.plasmaFillGradient,
        plasmaGlowGradient: plasmaGlowGradient ?? this.plasmaGlowGradient,
        plasmaFilamentColor: plasmaFilamentColor ?? this.plasmaFilamentColor,
        plasmaParticleColor1: plasmaParticleColor1 ?? this.plasmaParticleColor1,
        plasmaParticleColor2: plasmaParticleColor2 ?? this.plasmaParticleColor2,
        darkMatterFillGradient: darkMatterFillGradient ?? this.darkMatterFillGradient,
        darkMatterGlowGradient: darkMatterGlowGradient ?? this.darkMatterGlowGradient,
        darkMatterSingularityColor: darkMatterSingularityColor ?? this.darkMatterSingularityColor,
        darkMatterParticleColor1: darkMatterParticleColor1 ?? this.darkMatterParticleColor1,
        darkMatterParticleColor2: darkMatterParticleColor2 ?? this.darkMatterParticleColor2,
        magneticFillGradient: magneticFillGradient ?? this.magneticFillGradient,
        magneticGlowGradient: magneticGlowGradient ?? this.magneticGlowGradient,
        crystallineFillGradient: crystallineFillGradient ?? this.crystallineFillGradient,
        crystallineGlowGradient: crystallineGlowGradient ?? this.crystallineGlowGradient,
        geneticFillGradient: geneticFillGradient ?? this.geneticFillGradient,
        geneticGlowGradient: geneticGlowGradient ?? this.geneticGlowGradient,
        nuclearFillGradient: nuclearFillGradient ?? this.nuclearFillGradient,
        nuclearGlowGradient: nuclearGlowGradient ?? this.nuclearGlowGradient,
        magneticFieldLineColor: magneticFieldLineColor ?? this.magneticFieldLineColor,
        magneticParticleColor1: magneticParticleColor1 ?? this.magneticParticleColor1,
        magneticParticleColor2: magneticParticleColor2 ?? this.magneticParticleColor2,
        crystallineFacetColor: crystallineFacetColor ?? this.crystallineFacetColor,
        crystallineParticleColor1: crystallineParticleColor1 ?? this.crystallineParticleColor1,
        crystallineParticleColor2: crystallineParticleColor2 ?? this.crystallineParticleColor2,
        geneticHelixColor: geneticHelixColor ?? this.geneticHelixColor,
        geneticParticleColor1: geneticParticleColor1 ?? this.geneticParticleColor1,
        geneticParticleColor2: geneticParticleColor2 ?? this.geneticParticleColor2,
        nuclearCoreColor: nuclearCoreColor ?? this.nuclearCoreColor,
        nuclearParticleColor1: nuclearParticleColor1 ?? this.nuclearParticleColor1,
        nuclearParticleColor2: nuclearParticleColor2 ?? this.nuclearParticleColor2,
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
      bacterialFillGradient: LinearGradient.lerp(bacterialFillGradient, other.bacterialFillGradient, t)!,
      bacterialGlowGradient: RadialGradient.lerp(bacterialGlowGradient, other.bacterialGlowGradient, t)!,
      bacterialOrganismColor: Color.lerp(bacterialOrganismColor, other.bacterialOrganismColor, t)!,
      bacterialParticleColor1: Color.lerp(bacterialParticleColor1, other.bacterialParticleColor1, t)!,
      bacterialParticleColor2: Color.lerp(bacterialParticleColor2, other.bacterialParticleColor2, t)!,
      bloodFillGradient: LinearGradient.lerp(bloodFillGradient, other.bloodFillGradient, t)!,
      bloodGlowGradient: RadialGradient.lerp(bloodGlowGradient, other.bloodGlowGradient, t)!,
      bloodCellColor: Color.lerp(bloodCellColor, other.bloodCellColor, t)!,
      bloodParticleColor1: Color.lerp(bloodParticleColor1, other.bloodParticleColor1, t)!,
      bloodParticleColor2: Color.lerp(bloodParticleColor2, other.bloodParticleColor2, t)!,
      bioFillGradient: LinearGradient.lerp(bioFillGradient, other.bioFillGradient, t)!,
      bioGlowGradient: RadialGradient.lerp(bioGlowGradient, other.bioGlowGradient, t)!,
      bioSporeColor: Color.lerp(bioSporeColor, other.bioSporeColor, t)!,
      bioParticleColor1: Color.lerp(bioParticleColor1, other.bioParticleColor1, t)!,
      bioParticleColor2: Color.lerp(bioParticleColor2, other.bioParticleColor2, t)!,
      radiationFillGradient: LinearGradient.lerp(radiationFillGradient, other.radiationFillGradient, t)!,
      radiationGlowGradient: RadialGradient.lerp(radiationGlowGradient, other.radiationGlowGradient, t)!,
      radiationWaveColor: Color.lerp(radiationWaveColor, other.radiationWaveColor, t)!,
      radiationParticleColor1: Color.lerp(radiationParticleColor1, other.radiationParticleColor1, t)!,
      radiationParticleColor2: Color.lerp(radiationParticleColor2, other.radiationParticleColor2, t)!,
      plasmaFillGradient: LinearGradient.lerp(plasmaFillGradient, other.plasmaFillGradient, t)!,
      plasmaGlowGradient: RadialGradient.lerp(plasmaGlowGradient, other.plasmaGlowGradient, t)!,
      plasmaFilamentColor: Color.lerp(plasmaFilamentColor, other.plasmaFilamentColor, t)!,
      plasmaParticleColor1: Color.lerp(plasmaParticleColor1, other.plasmaParticleColor1, t)!,
      plasmaParticleColor2: Color.lerp(plasmaParticleColor2, other.plasmaParticleColor2, t)!,
      darkMatterFillGradient: LinearGradient.lerp(darkMatterFillGradient, other.darkMatterFillGradient, t)!,
      darkMatterGlowGradient: RadialGradient.lerp(darkMatterGlowGradient, other.darkMatterGlowGradient, t)!,
      darkMatterSingularityColor: Color.lerp(darkMatterSingularityColor, other.darkMatterSingularityColor, t)!,
      darkMatterParticleColor1: Color.lerp(darkMatterParticleColor1, other.darkMatterParticleColor1, t)!,
      darkMatterParticleColor2: Color.lerp(darkMatterParticleColor2, other.darkMatterParticleColor2, t)!,
      magneticFillGradient: LinearGradient.lerp(magneticFillGradient, other.magneticFillGradient, t)!,
      magneticGlowGradient: RadialGradient.lerp(magneticGlowGradient, other.magneticGlowGradient, t)!,
      crystallineFillGradient: LinearGradient.lerp(crystallineFillGradient, other.crystallineFillGradient, t)!,
      crystallineGlowGradient: RadialGradient.lerp(crystallineGlowGradient, other.crystallineGlowGradient, t)!,
      geneticFillGradient: LinearGradient.lerp(geneticFillGradient, other.geneticFillGradient, t)!,
      geneticGlowGradient: RadialGradient.lerp(geneticGlowGradient, other.geneticGlowGradient, t)!,
      nuclearFillGradient: LinearGradient.lerp(nuclearFillGradient, other.nuclearFillGradient, t)!,
      nuclearGlowGradient: RadialGradient.lerp(nuclearGlowGradient, other.nuclearGlowGradient, t)!,
      magneticFieldLineColor: Color.lerp(magneticFieldLineColor, other.magneticFieldLineColor, t)!,
      magneticParticleColor1: Color.lerp(magneticParticleColor1, other.magneticParticleColor1, t)!,
      magneticParticleColor2: Color.lerp(magneticParticleColor2, other.magneticParticleColor2, t)!,
      crystallineFacetColor: Color.lerp(crystallineFacetColor, other.crystallineFacetColor, t)!,
      crystallineParticleColor1: Color.lerp(crystallineParticleColor1, other.crystallineParticleColor1, t)!,
      crystallineParticleColor2: Color.lerp(crystallineParticleColor2, other.crystallineParticleColor2, t)!,
      geneticHelixColor: Color.lerp(geneticHelixColor, other.geneticHelixColor, t)!,
      geneticParticleColor1: Color.lerp(geneticParticleColor1, other.geneticParticleColor1, t)!,
      geneticParticleColor2: Color.lerp(geneticParticleColor2, other.geneticParticleColor2, t)!,
      nuclearCoreColor: Color.lerp(nuclearCoreColor, other.nuclearCoreColor, t)!,
      nuclearParticleColor1: Color.lerp(nuclearParticleColor1, other.nuclearParticleColor1, t)!,
      nuclearParticleColor2: Color.lerp(nuclearParticleColor2, other.nuclearParticleColor2, t)!,
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
    colors: [Color(0xFFFFFFFF), Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
  );

  static const lightGlowGradient = RadialGradient(colors: [Colors.white, Color(0xFFCE93D8), Colors.transparent]);
  static const lightBeamColor = Colors.white;
  static const lightParticleColor1 = Colors.white;
  static const lightParticleColor2 = Color(0xFFB39DDB);

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

  static const bacterialFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFDCEDC8), Color(0xFF8BC34A), Color(0xFF558B2F)],
  );

  static const bacterialGlowGradient = RadialGradient(colors: [Color(0xFFDCEDC8), Color(0xFF558B2F), Colors.transparent]);
  static const bacterialOrganismColor = Color(0xFFAED581);
  static const bacterialParticleColor1 = Color(0xFFF1F8E9);
  static const bacterialParticleColor2 = Color(0xFFC5E1A5);

  static const bloodFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFCDD2), Color(0xFFEF5350), Color(0xFFB71C1C)],
  );

  static const bloodGlowGradient = RadialGradient(colors: [Color(0xFFFFEBEE), Color(0xFFB71C1C), Colors.transparent]);
  static const bloodCellColor = Color(0xFFD32F2F);
  static const bloodParticleColor1 = Color(0xFFFFEBEE);
  static const bloodParticleColor2 = Color(0xFFFFCDD2);

  static const bioFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF2E7D32), Color(0xFF388E3C), Color(0xFF4A148C)],
  );

  static const bioGlowGradient = RadialGradient(colors: [Color(0xFF18FFFF), Color(0xFF4A148C), Colors.transparent]);
  static const bioSporeColor = Color(0xFF18FFFF);
  static const bioParticleColor1 = Color(0xFFC6FF00);
  static const bioParticleColor2 = Color(0xFF2E7D32);

  static const radiationFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF76FF03), Color(0xFFC0CA33), Color(0xFF1B5E20)],
  );

  static const radiationGlowGradient = RadialGradient(colors: [Color(0xFFFFFF00), Color(0xFF6200EA), Colors.transparent]);
  static const radiationWaveColor = Color(0xFFFFFF00);
  static const radiationParticleColor1 = Color(0xFFFF00FF);
  static const radiationParticleColor2 = Color(0xFF76FF03);

  static const plasmaFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF00D2FF), Color(0xFF3A7BD5), Color(0xFF2E3192)],
  );

  static const plasmaGlowGradient = RadialGradient(colors: [Color(0xFF00D2FF), Color(0xFF2E3192), Colors.transparent]);
  static const plasmaFilamentColor = Color(0xFFFF00CC);
  static const plasmaParticleColor1 = Color(0xFF00D2FF);
  static const plasmaParticleColor2 = Color(0xFF3A7BD5);

  static const darkMatterFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1A1A1A), Color(0xFF0D0D0D), Color(0xFF000000)],
  );

  static const darkMatterGlowGradient = RadialGradient(colors: [Color(0xFF4A148C), Color(0xFF000000), Colors.transparent]);
  static const darkMatterSingularityColor = Color(0xFF000000);
  static const darkMatterParticleColor1 = Color(0xFFE1BEE7);
  static const darkMatterParticleColor2 = Color(0xFF4A148C);

  static const magneticFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1A237E), Color(0xFF3949AB), Color(0xFF0D47A1)],
  );

  static const magneticGlowGradient = RadialGradient(colors: [Color(0xFF5C6BC0), Color(0xFF1A237E), Colors.transparent]);
  static const magneticFieldLineColor = Color(0xFF82B1FF);
  static const magneticParticleColor1 = Color(0xFFB3E5FC);
  static const magneticParticleColor2 = Color(0xFF448AFF);

  static const crystallineFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFE8EAF6), Color(0xFF7E57C2), Color(0xFF4527A0)],
  );

  static const crystallineGlowGradient = RadialGradient(colors: [Color(0xFFD1C4E9), Color(0xFF4527A0), Colors.transparent]);
  static const crystallineFacetColor = Color(0xFFB39DDB);
  static const crystallineParticleColor1 = Color(0xFFEDE7F6);
  static const crystallineParticleColor2 = Color(0xFF9575CD);

  static const geneticFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFC8E6C9), Color(0xFF43A047), Color(0xFF1B5E20)],
  );

  static const geneticGlowGradient = RadialGradient(colors: [Color(0xFFA5D6A7), Color(0xFF1B5E20), Colors.transparent]);
  static const geneticHelixColor = Color(0xFF69F0AE);
  static const geneticParticleColor1 = Color(0xFFE8F5E9);
  static const geneticParticleColor2 = Color(0xFF00C853);

  static const nuclearFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFF59D), Color(0xFFFFA000), Color(0xFFE65100)],
  );

  static const nuclearGlowGradient = RadialGradient(colors: [Color(0xFFFFE082), Color(0xFFE65100), Colors.transparent]);
  static const nuclearCoreColor = Color(0xFFFFEB3B);
  static const nuclearParticleColor1 = Color(0xFFFFF8E1);
  static const nuclearParticleColor2 = Color(0xFFFF9800);
}
