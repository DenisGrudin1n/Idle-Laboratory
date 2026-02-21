import 'package:idle_laboratory/core/enums/enums.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';

/// Repository for managing cell data
class CellRepository {
  const CellRepository();

  /// Returns the list of available cells with initial configuration
  List<CellModel> getAvailableCells() => <CellModel>[
    CellModel(
      id: CellId.basicEnergyCell.id,
      name: CellName.basicEnergyCell,
      type: CellType.energy,
      level: 1,
      isLocked: false,
      requiredLevel: null,
      energyPerSecond: '1',
    ),
    CellModel(
      id: CellId.heatCell.id,
      name: CellName.heatCell,
      type: CellType.energy,
      level: 1,
      isLocked: true,
      requiredLevel: null,
      energyPerSecond: null,
    ),
    CellModel(
      id: CellId.iceCell.id,
      name: CellName.iceCell,
      type: CellType.energy,
      level: 1,
      isLocked: true,
      requiredLevel: null,
      energyPerSecond: null,
    ),
    CellModel(
      id: CellId.darkMatterCell.id,
      name: CellName.darkMatterCell,
      type: CellType.energy,
      level: 1,
      isLocked: true,
      requiredLevel: null,
      energyPerSecond: null,
    ),
  ];
}
