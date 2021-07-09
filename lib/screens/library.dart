import 'dart:math';

import 'package:eureka_learn/main.dart';
import 'package:eureka_learn/utils/screen.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/book.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

class Library extends StatefulHookWidget {
  Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final pageController = PageController();
  final scrollNotifier = ValueNotifier(0.0);
  final page = StateProvider<double>((ref) => 0.0);
  ValueChanged<int> index = ((value) => 0);

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

  Widget build(BuildContext context) {
    final activeIndex = useProvider(activeIndexProvider);
    return Scaffold(
        body: Stack(
      children: [
        Container(
          child: Menu(),
          height: 45.0,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: IndexedStack(
            index: activeIndex.state,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0) +
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 4.0),
                child: Container(
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
                        return Transform(
                            alignment: Alignment.centerLeft,
                            transform: Matrix4.identity()
                              ..setEntry(2, 3, 0.0015)
                              ..rotateY(1.8 * rotationSqrt)
                              ..translate(
                                  -rotation * Screen.width(context) * 0.8)
                              ..rotateZ(90.0)
                              ..scale(1 + rotation),
                            child: Book(
                                imagePath: "assets/icons/png/cover5.jpg",
                                author: "Jack le Rouge",
                                name: "The passion of the Christ",
                                tags: ["Science", "Politics", "Self driving"]));
                      },
                    ),
                  ),
                ),
              ),
              Logo(
                withIcon: true,
              ),
              Logo(
                withIcon: true,
              ),
              Logo(
                withIcon: true,
              ),
              Center(
                child: Logo(
                  withIcon: true,
                ),
              ),
              Logo(
                withIcon: true,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
