import 'package:flutter/material.dart';

class Palette {
  static Color primary = Colors.blue;
  static Color secondary = Colors.orange;
  static Color success = Colors.lightGreenAccent;
  static Color error = Colors.redAccent;
  static LinearGradient linearGradient = LinearGradient(colors: [
    Colors.blue,
    Colors.blue.withOpacity(0.7),
    Colors.blue.withOpacity(0.4)
  ]);
}
