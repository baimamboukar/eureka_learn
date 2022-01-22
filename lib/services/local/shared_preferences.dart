import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  static Future<void> setMode(bool darkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme', darkMode);
  }

  static Future<bool> getMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('theme') ?? false;
  }
}
