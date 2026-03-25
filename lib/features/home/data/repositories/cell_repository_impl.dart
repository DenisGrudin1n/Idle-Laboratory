import 'dart:convert';
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
          energyPerSecond: '2.50',
        ),
        _createLockedCell(CellId.iceCell, CellName.iceCell),
        _createLockedCell(CellId.steamCell, CellName.steamCell),
        _createLockedCell(CellId.lightCell, CellName.lightCell),
        _createLockedCell(CellId.molecularCell, CellName.molecularCell),
        _createLockedCell(CellId.bacterialCell, CellName.bacterialCell),
        _createLockedCell(CellId.bloodCell, CellName.bloodCell),
        _createLockedCell(CellId.bioCell, CellName.bioCell),
        _createLockedCell(CellId.radiationCell, CellName.radiationCell),
        _createLockedCell(CellId.plasmaCell, CellName.plasmaCell),
        _createLockedCell(CellId.darkMatterCell, CellName.darkMatterCell),
      ];

  CellModel _createLockedCell(CellId id, CellName name) => CellModel(
        id: id.id,
        name: name,
        type: CellType.energy,
        level: 1,
        isLocked: true,
      );

  @override
  Future<List<CellModel>?> getSavedCells() => guardAsync(() async {
        final json = _dataSource.getString(StorageKeys.cellsData);
        if (json == null) return null;
        final list = jsonDecode(json) as List;
        return list.map((item) => CellModel.fromJson(item as Map<String, dynamic>)).toList();
      });

  @override
  Future<void> saveCells(List<CellModel> cells) => guardAsync(() async {
        final json = jsonEncode(cells.map((cell) => cell.toJson()).toList());
        await _dataSource.setString(StorageKeys.cellsData, json);
      });

  @override
  Future<void> clearAll() => guardAsync(() => _dataSource.remove(StorageKeys.cellsData));
}
