import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

///this class will function as local data storage
class AppSharedPreferences {
  static const LAST_CHECKED = "last_checked";
  static const CHECK_INTERVAL = "check_interval";
  static const DATA = "data";

  ///store live cache
  static Future<bool> storeCache(String key, String json, {int lastChecked, int interval = 3600000}) {
    if (lastChecked == null) {
      lastChecked = DateTime.now().millisecondsSinceEpoch;
    }

    return SharedPreferences.getInstance().then((prefs) {
      return prefs.setString(
          key,
          jsonEncode({
            LAST_CHECKED: lastChecked,
            CHECK_INTERVAL: interval,
            DATA: json
          }));
    });
  }

  ///live cache
  static Future<String> getCache(String key) async {
    var prefs = await SharedPreferences.getInstance();
    Map map = jsonDecode(prefs.getString(key));
    /// if outdated, clear and return null
    var lastChecked = map[LAST_CHECKED];
    var interval = map[CHECK_INTERVAL];
    if ((DateTime.now().millisecondsSinceEpoch - lastChecked) > interval) {
      prefs.remove(key);
      return null;
    }
    return map[DATA];
  }

  ///live cache
  static Future<Map> getFullCache(String key) async {
    var prefs = await SharedPreferences.getInstance();
    Map map = jsonDecode(prefs.getString(key));
    /// if outdated, clear and return null
    var lastChecked = map[LAST_CHECKED];
    var interval = map[CHECK_INTERVAL];
    if ((DateTime.now().millisecondsSinceEpoch - lastChecked) > interval) {
      prefs.remove(key);
      return null;
    }
    return map;
  }

  ///Set a token
  static Future<bool> setToken(String value) async {
    var prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    prefs.setString(key, value);
    return prefs.commit();
  }

  ///Get token data
  static Future<String> getToken() async {
    var prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    String value = prefs.getString(key);
    print(value);
    return value;
  }

  ///Delete token
  static Future<bool> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    return prefs.remove(key);
  }
}