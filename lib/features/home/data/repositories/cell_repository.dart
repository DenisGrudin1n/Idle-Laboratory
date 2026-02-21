import 'package:idle_laboratory/core/enums/enums.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model.dart';

/// Repository for managing cell data
class CellRepository {
  const CellRepository();

  /// Returns the list of available cells
  List<CellModel> getAvailableCells() => const <CellModel>[
    CellModel(
      id: 'basic_energy_cell',
      name: CellName.basicEnergyCell,
      type: CellType.energy,
      level: 3,
      isLocked: false,
      requiredLevel: null,
      energyPerSecond: '1',
    ),
    CellModel(
      id: 'heat_cell',
      name: CellName.heatCell,
      type: CellType.energy,
      level: 0,
      isLocked: true,
      requiredLevel: 2,
    ),
    CellModel(
      id: 'ice_cell',
      name: CellName.iceCell,
      type: CellType.energy,
      level: 0,
      isLocked: true,
      requiredLevel: 4,
    ),
    CellModel(
      id: 'dark_matter_cell',
      name: CellName.darkMatterCell,
      type: CellType.energy,
      level: 0,
      isLocked: true,
      requiredLevel: 6,
    ),
  ];
}
