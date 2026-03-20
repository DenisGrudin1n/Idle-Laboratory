import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/core/exceptions/game_exceptions.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/data/repositories/prestige_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PrestigeRepository)
class PrestigeRepositoryImpl implements PrestigeRepository {
  const PrestigeRepositoryImpl(this._dataSource);
  final LocalStorageDataSource _dataSource;

  @override
  Future<BigNumber?> getTotalMultiplier() async {
    try {
      final json = _dataSource.getString(StorageKeys.prestigeTotalMultiplier);
      return json != null ? _parseBigNumber(json) : null;
    } catch (error, stackTrace) {
      throw GameException('Failed to load prestige multiplier', error.toString(), stackTrace);
    }
  }

  @override
  Future<void> saveTotalMultiplier(BigNumber multiplier) async {
    try {
      await _dataSource.setString(StorageKeys.prestigeTotalMultiplier, _serializeBigNumber(multiplier));
    } catch (error, stackTrace) {
      throw GameException('Failed to save prestige multiplier', error.toString(), stackTrace);
    }
  }

  @override
  Future<BigNumber?> getCurrentThreshold() async {
    try {
      final json = _dataSource.getString(StorageKeys.prestigeThreshold);
      return json != null ? _parseBigNumber(json) : null;
    } catch (error, stackTrace) {
      throw GameException('Failed to load prestige threshold', error.toString(), stackTrace);
    }
  }

  @override
  Future<void> saveCurrentThreshold(BigNumber threshold) async {
    try {
      await _dataSource.setString(StorageKeys.prestigeThreshold, _serializeBigNumber(threshold));
    } catch (error, stackTrace) {
      throw GameException('Failed to save prestige threshold', error.toString(), stackTrace);
    }
  }

  @override
  Future<int?> getPrestigeCount() async {
    try {
      return _dataSource.getInt(StorageKeys.prestigeCount);
    } catch (error, stackTrace) {
      throw GameException('Failed to load prestige count', error.toString(), stackTrace);
    }
  }

  @override
  Future<void> savePrestigeCount(int count) async {
    try {
      await _dataSource.setInt(StorageKeys.prestigeCount, count);
    } catch (error, stackTrace) {
      throw GameException('Failed to save prestige count', error.toString(), stackTrace);
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await _dataSource.remove(StorageKeys.prestigeTotalMultiplier);
      await _dataSource.remove(StorageKeys.prestigeThreshold);
      await _dataSource.remove(StorageKeys.prestigeCount);
    } catch (error, stackTrace) {
      throw GameException('Failed to clear prestige data', error.toString(), stackTrace);
    }
  }

  BigNumber _parseBigNumber(String json) {
    final parts = json.split('e');
    return parts.length == 2 ? BigNumber(double.parse(parts[0]), int.parse(parts[1])) : BigNumber.fromDouble(double.parse(json));
  }

  String _serializeBigNumber(BigNumber value) => '${value.mantissa}e${value.exponent}';
}
