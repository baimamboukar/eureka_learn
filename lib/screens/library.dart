import 'package:eureka_learn/utils/screen.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Library extends HookWidget {
  Library({Key? key}) : super(key: key);
  final pageController = usePageController();
  final scrollNotifier = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Text("LOREMSON IPSUMSON"),
          Container(
            height: 400.0,
            child: ValueListenableBuilder<double>(
              valueListenable: scrollNotifier,
              builder: (context, value, _) => PageView.builder(
                controller: pageController,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  final percentage = index - value;
                  final rotation = percentage.clamp(0.0, 1.0);
                  if (index == 1) print(percentage);
                  return Column(
                    children: [
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.002)
                          ..rotateY(rotation * 1.8),
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
    ));
  }
}
