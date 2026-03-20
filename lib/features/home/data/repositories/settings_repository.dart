abstract class SettingsRepository {
  Future<bool?> getUseScientificNotation();
  Future<void> saveUseScientificNotation(bool useScientific);
  Future<void> clearAll();
}
