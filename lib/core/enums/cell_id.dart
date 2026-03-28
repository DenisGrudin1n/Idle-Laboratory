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

  static CellId? fromString(String id) {
    for (final cellId in CellId.values) if (cellId.id == id) return cellId;
    return null;
  }
}
