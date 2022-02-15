import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  const Button(
      {Key? key, required this.label, required this.color, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Screen.width(context) * 0.40,
        height: 40.0,
        decoration: BoxDecoration(
            gradient: Palette.gradientWith(color),
            boxShadow: [BoxShadow(color: color)],
            borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: Styles.subtitle),
            const SizedBox(width: 20.0),
            Icon(icon)
          ],
        ));
  }
}
