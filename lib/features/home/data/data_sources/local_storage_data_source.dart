import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class LocalStorageDataSource {
  const LocalStorageDataSource(this._prefs);
  final SharedPreferences _prefs;

  Future<bool> setString(String key, String value) async => _prefs.setString(key, value);
  String? getString(String key) => _prefs.getString(key);
  Future<bool> setInt(String key, int value) async => _prefs.setInt(key, value);
  int? getInt(String key) => _prefs.getInt(key);
  Future<bool> setDouble(String key, double value) async => _prefs.setDouble(key, value);
  double? getDouble(String key) => _prefs.getDouble(key);
  Future<bool> setBool(String key, {required bool value}) async => _prefs.setBool(key, value);
  bool? getBool(String key) => _prefs.getBool(key);
  Future<bool> setStringList(String key, List<String> value) async => _prefs.setStringList(key, value);
  List<String>? getStringList(String key) => _prefs.getStringList(key);
  Future<bool> remove(String key) async => _prefs.remove(key);
  bool containsKey(String key) => _prefs.containsKey(key);
  Future<bool> clear() async => _prefs.clear();
  Set<String> getKeys() => _prefs.getKeys();
}
