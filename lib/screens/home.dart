import 'dart:math';

import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/screen.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class All extends StatelessWidget {
  const All({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Container(
            height: Screen.height(context) * 0.25,
            decoration: BoxDecoration(
                //gradient: Palette.linearGradient,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0))),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 4.0),
                  child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      maxLength: 1000,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Palette.primary, width: 1),
                              borderRadius: BorderRadius.circular(20.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Palette.primary, width: 0.50),
                              borderRadius: BorderRadius.circular(20.0)),
                          prefix: Text("✍️"),
                          filled: true,
                          fillColor: Colors.grey.shade200)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
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
            )),
      ),
      SliverToBoxAdapter(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Browsing by categories..."),
      )),
      SliverToBoxAdapter(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 110.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subjects.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: subjectsBox[index]);
              },
            )),
      ))
    ]);
  }
}

List<LabelModel> subjects = [
  LabelModel(title: "All", iconPath: "🔥", active: false),
  LabelModel(title: "Chemestry", iconPath: "🌡️", active: false),
  LabelModel(title: "Geography", iconPath: "🌍", active: false),
  LabelModel(title: "Biology", iconPath: "🔬", active: false),
  LabelModel(title: "Maths", iconPath: "📈", active: false),
  LabelModel(title: "Csc", iconPath: "💻", active: false),
  LabelModel(title: "Physics", iconPath: "🚀", active: false),
  LabelModel(title: "Philosophy", iconPath: "📚", active: false),
];

var imagesRoot = "assets/icons/png";
List<SubjectBox> subjectsBox = [
  SubjectBox(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      subject: "Chemestry",
      imagePath: "$imagesRoot/chemestry.png"),
  SubjectBox(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      subject: "Maths",
      imagePath: "$imagesRoot/maths.png"),
  SubjectBox(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      subject: "Biology",
      imagePath: "$imagesRoot/biology.png"),
  SubjectBox(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      subject: "Geography",
      imagePath: "$imagesRoot/geography.png"),
  SubjectBox(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      subject: "Philosophy",
      imagePath: "$imagesRoot/philosophy.png"),
];
// Container(
//             height: 55.0,
//             child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children:
//                     subjects.map((label) => Label(model: label)).toList())),