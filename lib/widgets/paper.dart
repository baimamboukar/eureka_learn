import 'package:animate_do/animate_do.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Paper extends StatelessWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: Align(
          heightFactor: 0.65,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        24.0,
                      ),
                      topRight: Radius.circular(24.0)),
                  side: BorderSide(color: Colors.black12, width: 2.20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(LineIcons.pdfFileAlt, color: Palette.error),
                  title: Text("GCE 2021", style: Styles.subtitle),
                  subtitle: Text("GCE board, MINESEC"),
                  trailing: IconButton(
                      icon: Icon(LineIcons.download, color: Palette.primary),
                      onPressed: () => print("downloading file...")),
                ),
              ))),
    );
  }
}
