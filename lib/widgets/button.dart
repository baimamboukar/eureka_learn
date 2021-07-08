import 'package:eureka_learn/utils/screen.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  final String label;
  final Color color;
  const Button({Key? key, required this.label, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Screen.width(context) * 0.40,
        height: 40.0,
        decoration: BoxDecoration(
            color: color,
            boxShadow: [
              BoxShadow(spreadRadius: 1.50, blurRadius: 1.5, color: color)
            ],
            borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text(label)],
        ));
  }
}
