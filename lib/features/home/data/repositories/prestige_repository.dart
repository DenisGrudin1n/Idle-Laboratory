import 'package:idle_laboratory/core/utils/big_number.dart';

abstract class PrestigeRepository {
  Future<BigNumber?> getTotalMultiplier();
  Future<void> saveTotalMultiplier(BigNumber multiplier);
  Future<BigNumber?> getCurrentThreshold();
  Future<void> saveCurrentThreshold(BigNumber threshold);
  Future<int?> getPrestigeCount();
  Future<void> savePrestigeCount(int count);
  Future<void> clearAll();
}
