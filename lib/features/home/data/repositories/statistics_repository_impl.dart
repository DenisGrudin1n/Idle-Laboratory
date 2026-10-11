import 'dart:convert';

import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/core/exceptions/game_exceptions.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/data/repositories/statistics_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/statistics_model/statistics_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: StatisticsRepository)
class StatisticsRepositoryImpl implements StatisticsRepository {
  const StatisticsRepositoryImpl(this._dataSource);

  final LocalStorageDataSource _dataSource;

  @override
  Future<StatisticsModel?> getStatistics() => guardAsync(() async {
        final raw = _dataSource.getString(StorageKeys.statisticsState);
        if (raw == null) return null;
        return StatisticsModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
      });

  @override
  Future<void> saveStatistics(StatisticsModel statistics) => guardAsync(() async {
        await _dataSource.setString(StorageKeys.statisticsState, jsonEncode(statistics.toJson()));
      });

  @override
  Future<void> clearAll() => guardAsync(() => _dataSource.remove(StorageKeys.statisticsState));
}
