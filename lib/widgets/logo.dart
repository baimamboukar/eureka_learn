import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  final bool withIcon;
  final double? size;
  const Logo({Key? key, required this.withIcon, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        text: "eureka",
        style: GoogleFonts.novaOval(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Palette.primary,
        ),
        children: [
          TextSpan(
              text: "learn",
              style: GoogleFonts.novaOval(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.amber)),
        ]));
  }
}
