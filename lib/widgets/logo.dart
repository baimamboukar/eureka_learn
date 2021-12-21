import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final bool withIcon;
  final double? size;
  const Logo({Key? key, required this.withIcon, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        text: withIcon ? "💡" : "",
        style: TextStyle(fontSize: 22.0),
        children: [
          TextSpan(
              text: "Intelli'",
              style: TextStyle(
                  fontSize: size ?? 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber)),
          TextSpan(text: "learn"),
        ]));
  }
}
