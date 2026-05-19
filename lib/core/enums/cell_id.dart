enum CellId {
  basicEnergyCell('basic_energy_cell'),
  heatCell('heat_cell'),
  iceCell('ice_cell'),
  steamCell('steam_cell'),
  magneticCell('magnetic_cell'),
  lightCell('light_cell'),
  crystallineCell('crystalline_cell'),
  molecularCell('molecular_cell'),
  bacterialCell('bacterial_cell'),
  geneticCell('genetic_cell'),
  bloodCell('blood_cell'),
  bioCell('bio_cell'),
  radiationCell('radiation_cell'),
  nuclearCell('nuclear_cell'),
  plasmaCell('plasma_cell'),
  darkMatterCell('dark_matter_cell');

  const CellId(this.id);
  final String id;

  int get order => switch (this) {
    CellId.basicEnergyCell => 0,
    CellId.heatCell => 1,
    CellId.iceCell => 2,
    CellId.steamCell => 3,
    CellId.magneticCell => 4,
    CellId.lightCell => 5,
    CellId.crystallineCell => 6,
    CellId.molecularCell => 7,
    CellId.bacterialCell => 8,
    CellId.geneticCell => 9,
    CellId.bloodCell => 10,
    CellId.bioCell => 11,
    CellId.radiationCell => 12,
    CellId.nuclearCell => 13,
    CellId.plasmaCell => 14,
    CellId.darkMatterCell => 15,
  };

  static CellId? fromString(String id) {
    for (final cellId in CellId.values) if (cellId.id == id) return cellId;
    return null;
  }
}
