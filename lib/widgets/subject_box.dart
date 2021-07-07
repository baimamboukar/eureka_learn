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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.bottomRight,
                  child: Text(subject ?? "subject")),
              Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                      height: 60.0,
                      image: AssetImage(
                          imagePath ?? "assets/icons/png/chemestry.png")))
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              color: Colors.white30,
            )
          ],
          gradient: Palette.gradientWith(color ?? Colors.blue),
        ));
  }
}
