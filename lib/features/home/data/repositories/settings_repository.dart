abstract class SettingsRepository {
  Future<bool?> getUseScientificNotation();
  Future<void> saveUseScientificNotation({required bool useScientific});
  Future<void> clearAll();
}
