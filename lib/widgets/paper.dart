import 'package:animate_do/animate_do.dart';
import 'package:eureka_learn/models/paper_model.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Paper extends StatelessWidget {
  final PaperModel model;
  const Paper({Key? key, required this.model}) : super(key: key);

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
                padding: const EdgeInsets.all(12.0),
                child: ListTile(
                  leading: Icon(LineIcons.pdfFileAlt,
                      color: Palette.error, size: 42.0),
                  title: Text("${model.type}",
                      overflow: TextOverflow.ellipsis,
                      style: Styles.designText(
                          bold: true,
                          size: 18.0,
                          color: Palette.primary.withOpacity(0.75))),
                  subtitle: Text("${model.from}"),
                  trailing: IconButton(
                      icon: Icon(LineIcons.download, color: Palette.primary),
                      onPressed: () => print("downloading file...")),
                ),
              ))),
    );
  }
}
