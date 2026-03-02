import 'package:idle_laboratory/core/utils/big_number.dart';

/// Repository interface for prestige-related data persistence.
///
/// Handles storage and retrieval of prestige state including:
/// - Total multiplier (accumulated across all prestiges)
/// - Current threshold (energy requirement for next prestige)
/// - Prestige count (how many times prestiged)
abstract class PrestigeRepository {
  /// Loads the total multiplier from storage.
  /// Returns null if not found.
  Future<BigNumber?> getTotalMultiplier();

  /// Saves the total multiplier to storage.
  Future<void> saveTotalMultiplier(BigNumber multiplier);

  /// Loads the current threshold from storage.
  /// Returns null if not found.
  Future<BigNumber?> getCurrentThreshold();

  /// Saves the current threshold to storage.
  Future<void> saveCurrentThreshold(BigNumber threshold);

  /// Loads the prestige count from storage.
  /// Returns null if not found.
  Future<int?> getPrestigeCount();

  /// Saves the prestige count to storage.
  Future<void> savePrestigeCount(int count);

  /// Clears all prestige data from storage.
  Future<void> clearAll();
}
