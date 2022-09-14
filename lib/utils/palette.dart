import 'package:flutter/material.dart';

class Palette {
  static const Color primary = MaterialColor(
    0xFFFFB323,
    {
      80: Color(0xFFB58527),
      40: Color(0xFFEEC36D),
      20: Color(0xFFF9D183),
      10: Color(0xFFFFF1D4),
    },
  );

  static const Color red = MaterialColor(
    0xFFFF5247,
    {
      80: Color(0xFFD3180C),
      40: Color(0xFFFF6D6D),
      20: Color(0xFFFF9898),
      10: Color(0xFFFFE5E5),
    },
  );

  static const Color green = MaterialColor(
    0xFF23C16B,
    {
      80: Color(0xFF198155),
      40: Color(0xFF4CD571),
      20: Color(0xFF7DDE86),
      10: Color(0xFFECFCE5),
    },
  );

  static const Color blue = MaterialColor(
    0xFF48A7F8,
    {
      80: Color(0xFF0065D0),
      60: Color(0xFF48A7F8),
      20: Color(0xFF9BDCFD),
    },
  );

  static const Color dark = MaterialColor(
    0xFF090A0A,
    {
      100: Color(0xFF090A0A),
      80: Color(0xFF303437),
      40: Color(0xFF404446),
      20: Color(0xFF6C7072)
    },
  );

  static const Color grey = MaterialColor(
    0xFFCDCFD0,
    {
      100: Color(0xFF979C9E),
      80: Color(0xFFE3E5E5),
      40: Color(0xFFF2F4F5),
      20: Color(0xFFF7F9FA)
    },
  );

  static const Color light = Colors.white;
  static const Color danger = Color(0xFFD3180C);
  static const Color info = Color(0xFF006978);
  static const Color warning = Color(0xFFA05E03);
  static const Color primo = Color(0xFF005B9F);
  static const Color indigo = Color(0xFF673AB7);
  static const Color bordo = Color(0xFFA00037);

  static const ColorSwatch blackSwatch = ColorSwatch(
    80,
    <int, Color>{
      100: Color(0xFF090A0A),
      80: Color(0xFF303437),
      40: Color(0xFF404446),
      20: Color(0xFF6C7072)
    },
  );

  static List<Color> sessionColors = const [
    Color(0xFFBA000D),
    Color(0xFF006978),
    Color(0xFFE1980C),
    Color(0xFF673AB7),
    Color(0xFFA00037),
    Color(0xFF00766C),
    Color(0xFF00600F),
    Color(0xFFBC5100)
  ];

  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}
