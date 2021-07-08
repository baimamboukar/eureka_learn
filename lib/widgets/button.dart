import 'package:eureka_learn/utils/screen.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  final String label;
  final Widget? callbackDestination;
  const Button({Key? key, required this.label, this.callbackDestination})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => () => Get.to(() => callbackDestination),
      child: Container(
          width: Screen.width(context) * 0.45,
          height: 40.0,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(spreadRadius: 2.0, blurRadius: 3.0, color: Palette.light)
          ], color: Palette.light, borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,/0
            children: [Text(label)],
          )),
    );
  }
}
