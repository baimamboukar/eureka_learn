import 'package:eureka_learn/utils/screen.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icons.dart';

class Poster extends StatefulWidget {
  const Poster({Key? key}) : super(key: key);

  @override
  _PosterState createState() => _PosterState();
}

class _PosterState extends State<Poster> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: Screen.height(context) * 0.25,
        decoration: BoxDecoration(
            //gradient: Palette.linearGradient,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0))),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(text: "Hi, ", children: [
                      TextSpan(
                          text: "Zarathustra",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ]))
                  ],
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
              child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Palette.primary, width: 1),
                          borderRadius: BorderRadius.circular(20.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Palette.primary, width: 0.50),
                          borderRadius: BorderRadius.circular(20.0)),
                      prefix: Text("✍️"),
                      hintText: "What comes in your mind ? ",
                      filled: true,
                      fillColor: Colors.grey.shade200)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10.0),
              child: Row(
                children: [
                  ActionButton(
                      label: "add file",
                      icon: Text("🖇️"),
                      callback: () => print("exporting...")),
                  const SizedBox(width: 10.0),
                  ActionButton(
                      label: "add photo",
                      icon: Icon(LineIcons.photoVideo),
                      callback: () => print("exporting..."))
                ],
              ),
            )
          ],
        ));
  }
}
