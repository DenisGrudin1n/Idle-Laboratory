import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/data/repositories/settings_repository.dart';

/// Implementation of SettingsRepository using local storage.
///
/// Uses LocalStorageDataSource to persist app settings.
class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._dataSource);

  final LocalStorageDataSource _dataSource;

  @override
  Future<bool?> getUseScientificNotation() async {
    return _dataSource.getBool(StorageKeys.useScientificNotation);
  }

  @override
  Future<void> saveUseScientificNotation(bool useScientific) async {
    await _dataSource.setBool(
      StorageKeys.useScientificNotation,
      useScientific,
    );
  }

  @override
  Future<void> clearAll() async {
    await _dataSource.remove(StorageKeys.useScientificNotation);
  }
}
