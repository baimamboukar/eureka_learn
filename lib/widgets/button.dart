import 'package:eureka_learn/utils/screen.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final Function? callback;
  const Button({Key? key, required this.label, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback,
      child: Container(
          width: Screen.width(context) * 0.45,
          height: 40.0,
          decoration: BoxDecoration(
              color: Palette.light, borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text(label)],
          )),
    );
  }
}
