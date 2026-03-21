import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/core/exceptions/game_exceptions.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/data/repositories/energy_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EnergyRepository)
class EnergyRepositoryImpl implements EnergyRepository {
  const EnergyRepositoryImpl(this._dataSource);
  final LocalStorageDataSource _dataSource;

  @override
  Future<BigNumber?> getTotalEnergy() => guardAsync(() async {
        final json = _dataSource.getString(StorageKeys.totalEnergy);
        return json != null ? _parseBigNumber(json) : null;
      });

  @override
  Future<void> saveTotalEnergy(BigNumber energy) =>
      guardAsync(() => _dataSource.setString(StorageKeys.totalEnergy, _serializeBigNumber(energy)));

  @override
  Future<void> clearAll() => guardAsync(() => _dataSource.remove(StorageKeys.totalEnergy));

  BigNumber _parseBigNumber(String json) {
    final parts = json.split('e');
    return parts.length == 2
        ? BigNumber(double.parse(parts[0]), int.parse(parts[1]))
        : BigNumber.fromDouble(double.parse(json));
  }

  String _serializeBigNumber(BigNumber value) => '${value.mantissa}e${value.exponent}';
}
