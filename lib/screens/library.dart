import 'dart:math';

import 'package:eureka_learn/utils/screen.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Library extends StatefulWidget {
  Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
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
  final pageController = PageController();
  final scrollNotifier = ValueNotifier(0.0);

  void listenScroll() => scrollNotifier.value = pageController.page ?? 0.0;
  @override
  void initState() {
    pageController.addListener(listenScroll);
    super.initState();
  }

  @override
  void dispose() {
    pageController.removeListener(listenScroll);
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0) +
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 4.0),
        child: Column(
          children: [
            Container(
                height: Screen.height(context) * 0.08,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: subjects.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Label(model: subjects[index]);
                    })),
            Container(
              height: Screen.height(context) * 0.85,
              child: ValueListenableBuilder<double>(
                valueListenable: scrollNotifier,
                builder: (context, value, _) => PageView.builder(
                  controller: pageController,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    final percentage = index - value;
                    final rotation = percentage.clamp(0.0, 1.0);
                    final rotationSqrt = pow(rotation, 0.5);
                    if (index == 1) print(percentage);
                    return Column(
                      children: [
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()
                            ..setEntry(2, 3, 0.002)
                            ..rotateY(1.8 * rotationSqrt)
                            ..translate(-rotation * Screen.width(context) * 0.8)
                            ..scale(1 + rotation),
                          child: Image(
                              height: 300.0,
                              width: 150.0,
                              image:
                                  AssetImage("assets/icons/png/chemestry.png")),
                        ),
                        Text("Breaking Bad"),
                        Text("Erika Jefferson, Edt BrightBooks")
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
