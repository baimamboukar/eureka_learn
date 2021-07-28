import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Palette.success, width: 1.50)),
        child: Center(
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/icons/png/student.png"),
          ),
        ),
      ),
      Positioned(
          bottom: 2.0,
          right: 3.0,
          child: Container(
              height: 8.0,
              width: 8.0,
              decoration: BoxDecoration(
                  color: Palette.success, shape: BoxShape.circle)))
    ]);
  }
}
