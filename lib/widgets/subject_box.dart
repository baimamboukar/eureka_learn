import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';

class SubjectBox extends StatelessWidget {
  final Color? color;
  final String? imagePath;
  final String? subject;
  const SubjectBox({Key? key, this.color, this.imagePath, this.subject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: Palette.gradientWith(color ?? Colors.blue),
          image: DecorationImage(
              image:
                  AssetImage(imagePath ?? "assets/icons/png/chemestry.png"))),
    );
  }
}
