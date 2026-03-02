/// Repository interface for app settings persistence.
///
/// Handles storage and retrieval of user preferences including:
/// - Number notation preference (scientific vs suffix)
/// - Future settings (sound, animations, etc.)
abstract class SettingsRepository {
  /// Loads the scientific notation preference from storage.
  /// Returns null if not found (indicating default should be used).
  Future<bool?> getUseScientificNotation();

  /// Saves the scientific notation preference to storage.
  Future<void> saveUseScientificNotation(bool useScientific);

  /// Clears all settings from storage.
  Future<void> clearAll();
}
