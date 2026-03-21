import 'package:idle_laboratory/core/utils/big_number.dart';

abstract class EnergyRepository {
  Future<BigNumber?> getTotalEnergy();
  Future<void> saveTotalEnergy(BigNumber energy);
  Future<void> clearAll();
}
