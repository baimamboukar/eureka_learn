import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final activeIndexProvider = StateProvider<int>((ref) => 0);

class Menu extends HookWidget {
  Menu({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    final activeIndex = useProvider(activeIndexProvider);
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subjects.length,
        itemBuilder: (BuildContext context, int index) {
          final model = subjects[index];
          return GestureDetector(
              onTap: () => activeIndex.state = index,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                    curve: Curves.easeInCubic,
                    width: 85.0,
                    height: 20.0,
                    duration: Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                        color: activeIndex.state == index
                            ? null
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: activeIndex.state == index
                            ? Palette.linearGradient
                            : null),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(model.iconPath,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        Text(model.title)
                      ],
                    )),
              ));
        });
  }
}
