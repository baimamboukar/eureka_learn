import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final dynamic icon;
  final Color color;
  final Function callback;
  const ActionButton(
      {Key? key,
      required this.label,
      this.icon,
      required this.callback,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: color, width: 2.0),
            gradient: Palette.gradientWith(color)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(color: Palette.light),
              ),
              const SizedBox(width: 3.0),
              icon
            ],
          ),
        ));
  }
}
