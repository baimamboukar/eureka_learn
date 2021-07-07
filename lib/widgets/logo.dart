import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final bool withIcon;
  const Logo({Key? key, required this.withIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        text: withIcon ? "🤓" : "",
        style: TextStyle(fontSize: 22.0),
        children: [
          TextSpan(
              text: "eureka",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber)),
          TextSpan(text: "learn")
        ]));
  }
}
