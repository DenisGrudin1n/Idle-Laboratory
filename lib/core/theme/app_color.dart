import 'package:flutter/material.dart';

class AppColor extends ThemeExtension<AppColor> {
  AppColor({
    // ── Base UI ────────────────────────────────────────────────────────────
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.primaryText,
    required this.background,
    required this.drawerBackground,
    required this.titleText,
    required this.green,
    required this.sectionBorder,
    // ── Section card ───────────────────────────────────────────────────────
    required this.sectionGradient,
    // ── Energy cell container (3-D jar body) ───────────────────────────────
    required this.cellBodyGradient,
    required this.cellTopCapGradient,
    required this.cellBottomCapGradient,
    required this.cellTopRimGradient,
    required this.cellBottomRimGradient,
    // ── Energy fill effects ────────────────────────────────────────────────
    required this.energyFillGradient,
    required this.energyGlowGradient,
    required this.energyLightningColor,
    required this.energyParticleColor1,
    required this.energyParticleColor2,
    // ── Heat cell fill effects ─────────────────────────────────────────────
    required this.heatFillGradient,
    required this.heatGlowGradient,
    required this.heatChunkColor,
    required this.heatEmberColor1,
    required this.heatEmberColor2,
  });

  // ── Base UI ──────────────────────────────────────────────────────────────
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color primaryText;
  final Color background;
  final Color drawerBackground;
  final Color titleText;
  final Color green;

  /// Dark border used on all section cards.
  final Color sectionBorder;

  // ── Section card ─────────────────────────────────────────────────────────
  /// Top-to-bottom gradient applied to every section card body.
  final LinearGradient sectionGradient;

  // ── Energy cell container ────────────────────────────────────────────────
  /// Side-lit left→right gradient for the cylindrical jar body.
  final LinearGradient cellBodyGradient;

  /// Radial gradient for the top ellipse cap (faces the light source).
  final RadialGradient cellTopCapGradient;

  /// Radial gradient for the bottom ellipse cap (recedes into shadow).
  final RadialGradient cellBottomCapGradient;

  /// Top-to-bottom gradient for the top metallic rim.
  final LinearGradient cellTopRimGradient;

  /// Top-to-bottom gradient for the bottom metallic rim.
  final LinearGradient cellBottomRimGradient;

  // ── Energy fill effects ───────────────────────────────────────────────────
  /// Top-to-bottom gradient for the liquid energy fill.
  final LinearGradient energyFillGradient;

  /// Radial gradient for the glow at the top of the energy fill surface.
  final RadialGradient energyGlowGradient;

  /// Base color for electric lightning bolts.
  final Color energyLightningColor;

  /// First particle color (lighter).
  final Color energyParticleColor1;

  /// Second particle color (darker).
  final Color energyParticleColor2;

  // ── Heat cell fill effects ────────────────────────────────────────────────
  /// Top-to-bottom gradient for molten lava fill.
  final LinearGradient heatFillGradient;

  /// Radial gradient for the glow at the top of the lava surface.
  final RadialGradient heatGlowGradient;

  /// Color for floating lava chunks / dirt pieces.
  final Color heatChunkColor;

  /// First ember/spark color (brighter).
  final Color heatEmberColor1;

  /// Second ember/spark color (darker orange).
  final Color heatEmberColor2;

  @override
  ThemeExtension<AppColor> copyWith({
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
    RadialGradient? cellTopCapGradient,
    RadialGradient? cellBottomCapGradient,
    LinearGradient? cellTopRimGradient,
    LinearGradient? cellBottomRimGradient,
    LinearGradient? energyFillGradient,
    RadialGradient? energyGlowGradient,
    Color? energyLightningColor,
    Color? energyParticleColor1,
    Color? energyParticleColor2,
    LinearGradient? heatFillGradient,
    RadialGradient? heatGlowGradient,
    Color? heatChunkColor,
    Color? heatEmberColor1,
    Color? heatEmberColor2,
  }) {
    return AppColor(
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
      cellBottomCapGradient:
          cellBottomCapGradient ?? this.cellBottomCapGradient,
      cellTopRimGradient: cellTopRimGradient ?? this.cellTopRimGradient,
      cellBottomRimGradient:
          cellBottomRimGradient ?? this.cellBottomRimGradient,
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
  }

  @override
  ThemeExtension<AppColor> lerp(
    covariant ThemeExtension<AppColor>? other,
    double t,
  ) {
    if (other is! AppColor) {
      return this;
    }

    return AppColor(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      background: Color.lerp(background, other.background, t)!,
      drawerBackground: Color.lerp(
        drawerBackground,
        other.drawerBackground,
        t,
      )!,
      titleText: Color.lerp(titleText, other.titleText, t)!,
      green: Color.lerp(green, other.green, t)!,
      sectionBorder: Color.lerp(sectionBorder, other.sectionBorder, t)!,
      sectionGradient: LinearGradient.lerp(
        sectionGradient,
        other.sectionGradient,
        t,
      )!,
      cellBodyGradient: LinearGradient.lerp(
        cellBodyGradient,
        other.cellBodyGradient,
        t,
      )!,
      cellTopCapGradient: RadialGradient.lerp(
        cellTopCapGradient,
        other.cellTopCapGradient,
        t,
      )!,
      cellBottomCapGradient: RadialGradient.lerp(
        cellBottomCapGradient,
        other.cellBottomCapGradient,
        t,
      )!,
      cellTopRimGradient: LinearGradient.lerp(
        cellTopRimGradient,
        other.cellTopRimGradient,
        t,
      )!,
      cellBottomRimGradient: LinearGradient.lerp(
        cellBottomRimGradient,
        other.cellBottomRimGradient,
        t,
      )!,
      energyFillGradient: LinearGradient.lerp(
        energyFillGradient,
        other.energyFillGradient,
        t,
      )!,
      energyGlowGradient: RadialGradient.lerp(
        energyGlowGradient,
        other.energyGlowGradient,
        t,
      )!,
      energyLightningColor: Color.lerp(
        energyLightningColor,
        other.energyLightningColor,
        t,
      )!,
      energyParticleColor1: Color.lerp(
        energyParticleColor1,
        other.energyParticleColor1,
        t,
      )!,
      energyParticleColor2: Color.lerp(
        energyParticleColor2,
        other.energyParticleColor2,
        t,
      )!,
      heatFillGradient: LinearGradient.lerp(
        heatFillGradient,
        other.heatFillGradient,
        t,
      )!,
      heatGlowGradient: RadialGradient.lerp(
        heatGlowGradient,
        other.heatGlowGradient,
        t,
      )!,
      heatChunkColor: Color.lerp(heatChunkColor, other.heatChunkColor, t)!,
      heatEmberColor1: Color.lerp(heatEmberColor1, other.heatEmberColor1, t)!,
      heatEmberColor2: Color.lerp(heatEmberColor2, other.heatEmberColor2, t)!,
    );
  }
}

/// Default dark-lab colour palette.
class DefaultColor {
  DefaultColor._();

  // ── Base UI ───────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFFB8BAC9);
  static const Color secondary = Color(0xFF8B7FA1);
  static const Color accent = Color(0xFFA87489);
  static const Color primaryText = Color(0xFFB8BAC9);
  static const Color background = Color(0xFF4F5263);
  static const Color drawerBackground = Color(0xFF3D4153);
  static const Color titleText = Color(0xFFE8E9EE);
  static const Color green = Color(0xFF9DBF99);
  static const Color sectionBorder = Color(0xFF3A3F50);

  // ── Section card ──────────────────────────────────────────────────────────
  static const LinearGradient sectionGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[drawerBackground, Color(0xFF363A4A)],
  );

  // ── Energy cell container ──────────────────────────────────────────────────
  static const LinearGradient cellBodyGradient = LinearGradient(
    colors: <Color>[
      Color(0xFF5A637A), // lit left edge
      Color(0xFF3D4460), // midpoint
      Color(0xFF282E42), // dark right edge
      Color(0xFF353C55), // slight bounce-light on far right
    ],
    stops: <double>[0, 0.35, 0.75, 1],
  );

  static const RadialGradient cellTopCapGradient = RadialGradient(
    center: Alignment(-0.3, -0.4),
    colors: <Color>[
      Color(0xFF6E7A99), // specular highlight
      Color(0xFF454E68),
      Color(0xFF2C3348),
    ],
    stops: <double>[0, 0.5, 1],
  );

  static const RadialGradient cellBottomCapGradient = RadialGradient(
    colors: <Color>[Color(0xFF3A4259), Color(0xFF1E2333)],
  );

  static const LinearGradient cellTopRimGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xFF7A849E), // top highlight
      Color(0xFF4E5870),
      Color(0xFF333B52),
    ],
  );

  static const LinearGradient cellBottomRimGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xFF3A4259),
      Color(0xFF4E5870),
      Color(0xFF5C6680), // bottom highlight
    ],
  );

  // ── Energy fill effects ───────────────────────────────────────────────────
  // Blues shifted slightly darker & more teal for a richer gradient.
  static const LinearGradient energyFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xFF227BB0), // top — slightly darker than before
      Color(0xFF0D5F93), // mid
      Color(0xFF094A74), // bottom
    ],
  );

  static const RadialGradient energyGlowGradient = RadialGradient(
    colors: <Color>[
      Color(0xFF3192C0), // slightly darker teal-blue glow
      Color(0xFF0D5F93),
      Colors.transparent,
    ],
  );

  // Lightning slightly darker: was 0xFF5CB3E0, now 0xFF3D9DC8
  static const Color energyLightningColor = Color(0xFF3D9DC8);

  // Particles shifted slightly darker
  static const Color energyParticleColor1 = Color(0xFF56AECF); // was 6DC4E8
  static const Color energyParticleColor2 = Color(0xFF1F82B5); // was 2E99CF

  // ── Heat cell fill effects ────────────────────────────────────────────────
  // Red/orange/yellow lava gradient
  static const LinearGradient heatFillGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xFFFF6B35), // bright molten orange top
      Color(0xFFD73502), // deep orange-red mid
      Color(0xFF8B1F00), // dark crimson bottom
    ],
  );

  static const RadialGradient heatGlowGradient = RadialGradient(
    colors: <Color>[
      Color(0xFFFFA500), // bright amber glow
      Color(0xFFD73502),
      Colors.transparent,
    ],
  );

  // Lava chunk (dark dirty rock with ember glow)
  static const Color heatChunkColor = Color(0xFF3D2416); // dark brown/charcoal

  // Embers/sparks - bright orange/yellow
  static const Color heatEmberColor1 = Color(0xFFFFB84D); // bright golden
  static const Color heatEmberColor2 = Color(0xFFFF7A33); // orange spark
}
