import 'dart:ui';

import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final dynamic icon;
  final Function callback;
  const ActionButton(
      {Key? key, required this.label, this.icon, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback,
      child: Container(
          height: 30.0,
          width: 80.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: Palette.linearGradient),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                label,
                style: TextStyle(color: Palette.light),
              ),
              icon
            ],
          )),
    );
  }
}
