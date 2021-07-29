import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:badges/badges.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
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
    setState(() {});
  }

  @override
  void initState() {
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
            child: Container(
                height: 120.0,
                child: Column(
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText("Hack your success now",
                            speed: const Duration(milliseconds: 100),
                            cursor: "⚡"),
                      ],
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                      repeatForever: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: UserAvatar(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0) +
                              const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: Text("Welcome back, Zarathustra",
                              overflow: TextOverflow.ellipsis,
                              style: Styles.subtitle),
                        )
                      ],
                    ),
                    const SizedBox(height: 15.0, child: Divider()),
                    Text("In which subject do you want to take the quizz ?",
                        style: Styles.subtitle, overflow: TextOverflow.ellipsis)
                  ],
                )),
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
              final lastElementOffset = subjectsBox.length * 50;
              if (opacity > 1.0) opacity = 1;
              if (opacity < 0.0) opacity = 0;
              if (percent > 1.0) scale = 1.0;
              return true
                  ? Align(
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
                                  side: BorderSide(
                                      color: Colors.black12, width: 2.20)),
                              child: SizedBox(
                                height: 100.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  _subject.subject ?? "Subject",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Palette.light,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.5)),
                                            ],
                                          ),
                                          const SizedBox(height: 10.0),
                                          Row(
                                            children: [
                                              Text("120 quizz"),
                                              const SizedBox(
                                                width: 15.0,
                                              ),
                                              Text("10 Taken")
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
                    )
                  : Align(
                      heightFactor: 0.6,
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
                              side: BorderSide(
                                  color: Colors.black12, width: 2.20)),
                          child: SizedBox(
                            height: 100.0,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(_subject.subject ?? "Subject",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Palette.light,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.5)),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Text("120 quizz"),
                                          const SizedBox(
                                            width: 15.0,
                                          ),
                                          Text("10 Taken")
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
                    );
            }, childCount: subjectsBox.length),
          )
        ],
      ),
    );
  }
}
