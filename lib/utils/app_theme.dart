import 'package:eureka_learn/services/local/shared_preferences.dart';
import 'package:eureka_learn/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final appThemeProvider = Provider<AppTheme>((ref) {
  return AppTheme();
});

class AppTheme {
  //Modify to add more colors here
  static ThemeData _lightThemeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColorBrightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.grey.shade200,
    iconTheme: IconThemeData(size: 22.0, opacity: 1),
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Palette.light,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        actionsIconTheme: IconThemeData(color: Palette.primary),
        iconTheme: IconThemeData(color: Palette.primary, size: 16.0)),
  );
  static ThemeData _darkThemeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColorBrightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black12,
    iconTheme: IconThemeData(size: 22.0, opacity: 1),
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Palette.light,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        actionsIconTheme: IconThemeData(color: Palette.primary),
        iconTheme: IconThemeData(color: Palette.primary, size: 16.0)),
  );
  ThemeData getAppThemedata(BuildContext context, bool isDarkModeEnabled) {
    return isDarkModeEnabled ? _darkThemeData : _lightThemeData;
  }
}

/* AppTheme Notifier */
final appThemeStateProvider =
    StateNotifierProvider<AppThemeNotifier, bool>((ref) {
  final _isDarkModeEnabled =
      ref.read(sharedUtilityProvider).isDarkModeEnabled();
  return AppThemeNotifier(_isDarkModeEnabled);
});

class AppThemeNotifier extends StateNotifier<bool> {
  AppThemeNotifier(this.defaultDarkModeValue) : super(defaultDarkModeValue);
  final bool defaultDarkModeValue;
  bool get isDarkModeEnabled => state;
  toggleAppTheme(BuildContext context) {
    final _isDarkModeEnabled =
        context.read(sharedUtilityProvider).isDarkModeEnabled();
    final _toggleValue = !_isDarkModeEnabled;
    context
        .read(
          sharedUtilityProvider,
        )
        .setDarkModeEnabled(_toggleValue)
        .whenComplete(
          () => {
            state = _toggleValue,
          },
        );
  }
}
