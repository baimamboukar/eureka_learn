import 'dart:math';

import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/book.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookView extends StatefulWidget {
  const BookView({Key? key}) : super(key: key);

  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0) +
          const EdgeInsets.symmetric(vertical: 40.0, horizontal: 4.0),
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
                    ..translate(-rotation * Screen.width(context) * 0.8)
                    ..scale(1 + rotation),
                  child: Book(
                      imagePath: "assets/icons/png/cover5.jpg",
                      author: "Brave Author Eureka",
                      name: "Eurekaboom Inside",
                      tags: ["Science", "History", "Supernatural"]));
            },
          ),
        ),
      ),
    );
  }
}
