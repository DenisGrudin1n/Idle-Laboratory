import 'dart:convert';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/cell_name.dart';
import 'package:idle_laboratory/core/enums/cell_type.dart';
import 'package:idle_laboratory/core/exceptions/game_exceptions.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/data/repositories/cell_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model/cell_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CellRepository)
class CellRepositoryImpl implements CellRepository {
  const CellRepositoryImpl(this._dataSource);
  final LocalStorageDataSource _dataSource;

  @override
  List<CellModel> getDefaultCells() => [
    _createCell(CellId.basicEnergyCell, CellName.basicEnergyCell, isLocked: false),
    _createCell(CellId.heatCell, CellName.heatCell),
    _createCell(CellId.iceCell, CellName.iceCell),
    _createCell(CellId.steamCell, CellName.steamCell),
    _createCell(CellId.magneticCell, CellName.magneticCell),
    _createCell(CellId.lightCell, CellName.lightCell),
    _createCell(CellId.crystallineCell, CellName.crystallineCell),
    _createCell(CellId.molecularCell, CellName.molecularCell),
    _createCell(CellId.bacterialCell, CellName.bacterialCell),
    _createCell(CellId.geneticCell, CellName.geneticCell),
    _createCell(CellId.bloodCell, CellName.bloodCell),
    _createCell(CellId.bioCell, CellName.bioCell),
    _createCell(CellId.radiationCell, CellName.radiationCell),
    _createCell(CellId.nuclearCell, CellName.nuclearCell),
    _createCell(CellId.plasmaCell, CellName.plasmaCell),
    _createCell(CellId.darkMatterCell, CellName.darkMatterCell),
  ];

  CellModel _createCell(CellId id, CellName name, {bool isLocked = true}) {
    const initialLevel = 1;
    final initialEPS = GameBalance.calculateLevelEPS(id.order, initialLevel);
    return CellModel(
      id: id.id,
      name: name,
      type: CellType.energy,
      level: initialLevel,
      isLocked: isLocked,
      energyPerSecond: initialEPS.format(),
    );
  }

  @override
  Future<List<CellModel>?> getSavedCells() => guardAsync(() async {
        final json = _dataSource.getString(StorageKeys.cellsData);
        if (json == null) return null;
        final list = jsonDecode(json) as List;
        final cells = <CellModel>[];
        for (final item in list) {
          try {
            cells.add(CellModel.fromJson(item as Map<String, dynamic>));
          } catch (e) {
            // Silently ignore individual cell load failures to allow others to load
          }
        }
        return cells.isEmpty ? null : cells;
      });

  @override
  Future<void> saveCells(List<CellModel> cells) => guardAsync(() async {
    final json = jsonEncode(cells.map((cell) => cell.toJson()).toList());
    await _dataSource.setString(StorageKeys.cellsData, json);
  });

  @override
  Future<void> clearAll() => guardAsync(() => _dataSource.remove(StorageKeys.cellsData));
}
