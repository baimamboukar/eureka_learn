import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:line_icons/line_icons.dart';

class Quizz extends StatefulHookWidget {
  const Quizz({Key? key}) : super(key: key);

  @override
  _QuizzState createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {
  final scrollController = ScrollController();
  void listenScroll() {
    print("Offset: ${scrollController.offset}");
    setState(() {});
  }

  @override
  void initState() {
    subjectsBox.addAll(List.from(subjectsBox));
    scrollController.addListener(listenScroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(listenScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120.0,
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              var _subject = subjectsBox[index];
              final itemPositionOffset = index * 50;
              final diff = scrollController.offset - itemPositionOffset;
              final percent = 1.0 - (diff / 50);
              double opacity = percent;
              double scale = percent;
              if (opacity > 1.0) opacity = 1;
              if (opacity < 0.0) opacity = 0;
              if (percent > 1.0) scale = 1.0;
              return Align(
                heightFactor: 0.6,
                child: Opacity(
                  opacity: opacity,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(scale, 1.0, 2.0),
                    child: Card(
                        color: _subject.color,
                        elevation: 5.0,
                        margin: const EdgeInsets.all(10.0),
                        shadowColor: Palette.light,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  24.0,
                                ),
                                topRight: Radius.circular(24.0)),
                            side:
                                BorderSide(color: Colors.black12, width: 2.20)),
                        child: SizedBox(
                          height: 100.0,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Computer Science",
                                            style: TextStyle(
                                                color: Palette.light,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.5)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Chip(
                                          backgroundColor: Palette.light,
                                          side: BorderSide(
                                              color: Palette.primary
                                                  .withOpacity(0.5),
                                              width: 0.60),
                                          avatar: Icon(LineIcons.medal),
                                          label: Text("120 quizz"),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(_subject
                                                    .imagePath ??
                                                "assets/icons/png/atom.png"))))
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              );
            }, childCount: subjectsBox.length),
          )
        ],
      ),
    );
  }
}
