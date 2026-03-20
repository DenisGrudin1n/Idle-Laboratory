import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/cell_name.dart';
import 'package:idle_laboratory/core/enums/cell_type.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CellRepository {
  const CellRepository();

  List<CellModel> getAvailableCells() => <CellModel>[
    CellModel(
      id: CellId.basicEnergyCell.id,
      name: CellName.basicEnergyCell,
      type: CellType.energy,
      level: 1,
      isLocked: false,
      energyPerSecond: '1.00',
    ),
    CellModel(
      id: CellId.heatCell.id,
      name: CellName.heatCell,
      type: CellType.energy,
      level: 1,
      isLocked: true,
    ),
    CellModel(
      id: CellId.iceCell.id,
      name: CellName.iceCell,
      type: CellType.energy,
      level: 1,
      isLocked: true,
    ),
    CellModel(
      id: CellId.darkMatterCell.id,
      name: CellName.darkMatterCell,
      type: CellType.energy,
      level: 1,
      isLocked: true,
    ),
  ];
}
