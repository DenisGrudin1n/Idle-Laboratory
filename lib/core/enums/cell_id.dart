enum CellId {
  basicEnergyCell('basic_energy_cell'),
  heatCell('heat_cell'),
  iceCell('ice_cell'),
  steamCell('steam_cell'),
  lightCell('light_cell'),
  molecularCell('molecular_cell'),
  bacterialCell('bacterial_cell'),
  bloodCell('blood_cell'),
  bioCell('bio_cell'),
  radiationCell('radiation_cell'),
  plasmaCell('plasma_cell'),
  darkMatterCell('dark_matter_cell');

  const CellId(this.id);
  final String id;

  int get order => switch (this) {
    CellId.basicEnergyCell => 0,
    CellId.heatCell => 1,
    CellId.iceCell => 2,
    CellId.steamCell => 3,
    CellId.lightCell => 4,
    CellId.molecularCell => 5,
    CellId.bacterialCell => 6,
    CellId.bloodCell => 7,
    CellId.bioCell => 8,
    CellId.radiationCell => 9,
    CellId.plasmaCell => 10,
    CellId.darkMatterCell => 11,
  };

  static CellId? fromString(String id) {
    for (final cellId in CellId.values) if (cellId.id == id) return cellId;
    return null;
  }
}
