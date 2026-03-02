import 'package:shared_preferences/shared_preferences.dart';

/// A wrapper around SharedPreferences providing type-safe storage operations.
///
/// This data source abstracts the underlying storage mechanism and provides
/// a clean interface for reading and writing data. Makes it easy to switch
/// storage solutions (e.g., Hive, SQLite) without changing repository code.
class LocalStorageDataSource {
  const LocalStorageDataSource(this._prefs);

  final SharedPreferences _prefs;

  // String operations
  Future<bool> setString(String key, String value) async {
    return _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  // Int operations
  Future<bool> setInt(String key, int value) async {
    return _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // Double operations
  Future<bool> setDouble(String key, double value) async {
    return _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  // Bool operations
  Future<bool> setBool(String key, bool value) async {
    return _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // List<String> operations
  Future<bool> setStringList(String key, List<String> value) async {
    return _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // Remove operation
  Future<bool> remove(String key) async {
    return _prefs.remove(key);
  }

  // Check if key exists
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  // Clear all data (use with caution)
  Future<bool> clear() async {
    return _prefs.clear();
  }

  // Get all keys
  Set<String> getKeys() {
    return _prefs.getKeys();
  }
}
