import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/core/exceptions/game_exceptions.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/data/repositories/settings_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._dataSource);
  final LocalStorageDataSource _dataSource;

  @override
  Future<bool?> getUseScientificNotation() => guardAsync(() => _dataSource.getBool(StorageKeys.useScientificNotation));

  @override
  Future<void> saveUseScientificNotation({required bool useScientific}) =>
      guardAsync(() => _dataSource.setBool(StorageKeys.useScientificNotation, value: useScientific));

  @override
  Future<void> clearAll() => guardAsync(() => _dataSource.remove(StorageKeys.useScientificNotation));
}
