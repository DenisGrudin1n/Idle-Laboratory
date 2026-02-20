import 'package:idle_laboratory/core/enums/enums.dart';

class CellModel {
  const CellModel({
    required this.id,
    required this.name,
    required this.type,
    required this.level,
    required this.isLocked,
    required this.requiredLevel,
    this.energyPerSecond,
  });

  final String id;
  final CellName name;
  final CellType type;
  final int level;
  final bool isLocked;
  final int? requiredLevel;
  final String? energyPerSecond;

  static const List<CellModel> availableCells = <CellModel>[
    CellModel(
      id: 'basic_energy_cell',
      name: CellName.basicEnergyCell,
      type: CellType.energy,
      level: 3,
      isLocked: false,
      requiredLevel: null,
      energyPerSecond: '+2',
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
