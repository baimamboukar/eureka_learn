import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  static Future<void> theme(bool isDarkOn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme', isDarkOn);
  }
}
