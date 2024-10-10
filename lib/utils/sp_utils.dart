import 'package:shared_preferences/shared_preferences.dart';

///本地持久化储存工具
class SpUtils {
  SpUtils._();

  static Future<bool> saveStringList(String key, List<String> values) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setStringList(key, values);
  }

  static Future<List<String>?> getStringList(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getStringList(key);
  }

  static Future<bool> saveBool(String key, bool value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(key);
  }

  static Future<bool> saveInt(String key, int value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getInt(key);
  }

  static Future<bool> saveString(String key, String value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  static Future saveDouble(String key, double value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setDouble(key, value);
  }

  static Future<double?> getDouble(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getDouble(key);
  }

  static Future saveList(String key, List<String> values) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setStringList(key, values);
  }

  static Future getList(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getStringList(key);
  }

  static Future getDynamic(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.get(key);
  }

  static Future<bool> remove(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }

  static Future<bool> removeAll() async {
    final sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
}
