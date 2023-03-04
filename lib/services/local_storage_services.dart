import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageServices {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }  

  static Future<void> saveStringLocally(String key, String value) {
    return _preferences.setString(key, value);
  }

  static String? getString(String key) {
    return _preferences.getString(key);
  }

  static void clearLocalStorage() {
    _preferences.clear();
  }
}
