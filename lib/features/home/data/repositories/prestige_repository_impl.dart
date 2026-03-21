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
  Future<BigNumber?> getTotalMultiplier() => guardAsync(() async {
        final json = _dataSource.getString(StorageKeys.prestigeTotalMultiplier);
        return json != null ? _parseBigNumber(json) : null;
      });

  @override
  Future<void> saveTotalMultiplier(BigNumber multiplier) =>
      guardAsync(() => _dataSource.setString(StorageKeys.prestigeTotalMultiplier, _serializeBigNumber(multiplier)));

  @override
  Future<BigNumber?> getCurrentThreshold() => guardAsync(() async {
        final json = _dataSource.getString(StorageKeys.prestigeThreshold);
        return json != null ? _parseBigNumber(json) : null;
      });

  @override
  Future<void> saveCurrentThreshold(BigNumber threshold) =>
      guardAsync(() => _dataSource.setString(StorageKeys.prestigeThreshold, _serializeBigNumber(threshold)));

  @override
  Future<int?> getPrestigeCount() => guardAsync(() => _dataSource.getInt(StorageKeys.prestigeCount));

  @override
  Future<void> savePrestigeCount(int count) => guardAsync(() => _dataSource.setInt(StorageKeys.prestigeCount, count));

  @override
  Future<void> clearAll() => guardAsync(() async {
        await _dataSource.remove(StorageKeys.prestigeTotalMultiplier);
        await _dataSource.remove(StorageKeys.prestigeThreshold);
        await _dataSource.remove(StorageKeys.prestigeCount);
      });

  BigNumber _parseBigNumber(String json) {
    final parts = json.split('e');
    return parts.length == 2
        ? BigNumber(double.parse(parts[0]), int.parse(parts[1]))
        : BigNumber.fromDouble(double.parse(json));
  }

  String _serializeBigNumber(BigNumber value) => '${value.mantissa}e${value.exponent}';
}
