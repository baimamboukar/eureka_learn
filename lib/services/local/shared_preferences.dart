import 'package:flutter_riverpod/flutter_riverpod.dart';
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

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
final sharedUtilityProvider = Provider<SharedUtility>((ref) {
  final _sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(sharedPreferences: _sharedPrefs);
});

class SharedUtility {
  SharedUtility({
    required this.sharedPreferences,
  });
  final SharedPreferences sharedPreferences;
  bool isDarkModeEnabled() {
    return sharedPreferences.getBool('isDarkModeEnabled') ?? false;
  }

  Future<bool> setDarkModeEnabled(bool value) async {
    return await sharedPreferences.setBool('isDarkModeEnabled', value);
  }
}
