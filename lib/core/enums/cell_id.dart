/// Unique identifiers for all cells in the game
enum CellId {
  basicEnergyCell('basic_energy_cell'),
  heatCell('heat_cell'),
  iceCell('ice_cell'),
  darkMatterCell('dark_matter_cell');

  const CellId(this.id);

  final String id;

  /// Get CellId from string id
  static CellId? fromString(String id) {
    for (final cellId in CellId.values) {
      if (cellId.id == id) {
        return cellId;
      }
    }
    return null;
  }
}
