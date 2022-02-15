import 'package:eureka_learn/services/local/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = FutureProvider<bool>((ref) async {
  return await SharedPreferencesServices.getMode();
});
