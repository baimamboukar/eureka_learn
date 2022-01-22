import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = FutureProvider<bool>((ref) async {
  return await SharedPreferences.getInstance().then((prefs) {
    return prefs.getBool('darkMode') ?? false;
  });
});
