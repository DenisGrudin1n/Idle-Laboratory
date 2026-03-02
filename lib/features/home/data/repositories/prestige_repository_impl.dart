import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/data/repositories/prestige_repository.dart';

/// Implementation of PrestigeRepository using local storage.
///
/// Uses LocalStorageDataSource to persist prestige data.
/// BigNumber values are serialized as strings in "mantissa e exponent" format.
class PrestigeRepositoryImpl implements PrestigeRepository {
  const PrestigeRepositoryImpl(this._dataSource);

  final LocalStorageDataSource _dataSource;

  @override
  Future<BigNumber?> getTotalMultiplier() async {
    final String? json = _dataSource.getString(
      StorageKeys.prestigeTotalMultiplier,
    );
    return json != null ? _parseBigNumber(json) : null;
  }

  @override
  Future<void> saveTotalMultiplier(BigNumber multiplier) async {
    await _dataSource.setString(
      StorageKeys.prestigeTotalMultiplier,
      _serializeBigNumber(multiplier),
    );
  }

  @override
  Future<BigNumber?> getCurrentThreshold() async {
    final String? json = _dataSource.getString(
      StorageKeys.prestigeThreshold,
    );
    return json != null ? _parseBigNumber(json) : null;
  }

  @override
  Future<void> saveCurrentThreshold(BigNumber threshold) async {
    await _dataSource.setString(
      StorageKeys.prestigeThreshold,
      _serializeBigNumber(threshold),
    );
  }

  @override
  Future<int?> getPrestigeCount() async {
    return _dataSource.getInt(StorageKeys.prestigeCount);
  }

  @override
  Future<void> savePrestigeCount(int count) async {
    await _dataSource.setInt(StorageKeys.prestigeCount, count);
  }

  @override
  Future<void> clearAll() async {
    await _dataSource.remove(StorageKeys.prestigeTotalMultiplier);
    await _dataSource.remove(StorageKeys.prestigeThreshold);
    await _dataSource.remove(StorageKeys.prestigeCount);
  }

  /// Parses a BigNumber from storage string format.
  ///
  /// Expected format: "mantissa e exponent" (e.g., "1.5e10")
  /// Falls back to parsing as double if format doesn't match.
  BigNumber _parseBigNumber(String json) {
    final List<String> parts = json.split('e');
    if (parts.length == 2) {
      final double mantissa = double.parse(parts[0]);
      final int exponent = int.parse(parts[1]);
      return BigNumber(mantissa, exponent);
    }
    return BigNumber.fromDouble(double.parse(json));
  }

  /// Serializes a BigNumber to storage string format.
  ///
  /// Format: "mantissa e exponent" (e.g., "1.5e10")
  String _serializeBigNumber(BigNumber value) {
    return '${value.mantissa}e${value.exponent}';
  }
}
