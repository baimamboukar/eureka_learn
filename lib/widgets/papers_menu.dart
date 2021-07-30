import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final activeMenuProvider = StateProvider<int>((ref) => 0);

class PapersMenu extends HookWidget {
  const PapersMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> types = [
      "Sequences",
      "Quizz",
      "Assessment",
      "Mock Exams",
      "Official Exams"
    ];
    final activeMenu = useProvider(activeMenuProvider);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 30.0,
        child: ListView.builder(
            itemCount: types.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () => activeMenu.state = index,
                  child: Chip(
                    label: Text(types[index]),
                    backgroundColor: activeMenu.state == index
                        ? Palette.primary
                        : Colors.grey.shade200,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
