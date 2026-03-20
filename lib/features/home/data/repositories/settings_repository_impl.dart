import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/core/exceptions/game_exceptions.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/data/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._dataSource);

  final LocalStorageDataSource _dataSource;

  @override
  Future<bool?> getUseScientificNotation() async {
    try {
      return _dataSource.getBool(StorageKeys.useScientificNotation);
    } catch (error, stackTrace) {
      throw GameException(
        'Failed to load settings',
        error.toString(),
        stackTrace,
      );
    }
  }

  @override
  Future<void> saveUseScientificNotation(bool useScientific) async {
    try {
      await _dataSource.setBool(
        StorageKeys.useScientificNotation,
        useScientific,
      );
    } catch (error, stackTrace) {
      throw GameException(
        'Failed to save settings',
        error.toString(),
        stackTrace,
      );
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await _dataSource.remove(StorageKeys.useScientificNotation);
    } catch (error, stackTrace) {
      throw GameException(
        'Failed to clear settings',
        error.toString(),
        stackTrace,
      );
    }
  }
}
