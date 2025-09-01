import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static late SharedPreferences _prefs;
  static late Box _settingsBox;
  static late Box _userBox;
  static late Box _cacheBox;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    
    // Initialiser Hive
    await Hive.initFlutter();
    
    // Ouvrir les boxes
    _settingsBox = await Hive.openBox('settings');
    _userBox = await Hive.openBox('user');
    _cacheBox = await Hive.openBox('cache');
  }

  // Méthodes pour SharedPreferences
  static Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  static Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  static Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // Méthodes pour Hive
  static Future<void> saveToBox(String boxName, String key, dynamic value) async {
    Box box;
    switch (boxName) {
      case 'settings':
        box = _settingsBox;
        break;
      case 'user':
        box = _userBox;
        break;
      case 'cache':
        box = _cacheBox;
        break;
      default:
        throw Exception('Box $boxName not found');
    }
    await box.put(key, value);
  }

  static dynamic getFromBox(String boxName, String key) {
    Box box;
    switch (boxName) {
      case 'settings':
        box = _settingsBox;
        break;
      case 'user':
        box = _userBox;
        break;
      case 'cache':
        box = _cacheBox;
        break;
      default:
        throw Exception('Box $boxName not found');
    }
    return box.get(key);
  }

  static Future<void> removeFromBox(String boxName, String key) async {
    Box box;
    switch (boxName) {
      case 'settings':
        box = _settingsBox;
        break;
      case 'user':
        box = _userBox;
        break;
      case 'cache':
        box = _cacheBox;
        break;
      default:
        throw Exception('Box $boxName not found');
    }
    await box.delete(key);
  }

  static Future<void> clearBox(String boxName) async {
    Box box;
    switch (boxName) {
      case 'settings':
        box = _settingsBox;
        break;
      case 'user':
        box = _userBox;
        break;
      case 'cache':
        box = _cacheBox;
        break;
      default:
        throw Exception('Box $boxName not found');
    }
    await box.clear();
  }
}
