import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Quizz extends StatefulHookWidget {
  const Quizz({Key? key}) : super(key: key);

  @override
  _QuizzState createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {
  final scrollController = ScrollController();
  double topContainer = 0;
  bool close = false;
  void listenScroll() {
    double firstEelementOffset = scrollController.offset / 80;
    setState(() {
      topContainer = firstEelementOffset;
      close = scrollController.offset > 30;
    });
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
    final quizSubject = useProvider(quizSubjectProvider);
    final user = useProvider(studentControllerProvider);
    final student = useProvider(studentControllerProvider.notifier);
    List<SubjectBox> subjects = subjectsBox
        .where((subject) => student.student.subjects.contains(subject.subject))
        .toList();
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: 1.0,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const SizedBox(height: 25.0),
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
                        child: Text("Welcome back, ${user.names}",
                            overflow: TextOverflow.ellipsis,
                            style: Styles.subtitle),
                      )
                    ],
                  ),
                  const SizedBox(height: 15.0, child: Divider()),
                  Text("In which subject do you want to take the quizz ?",
                      style: Styles.subtitle, overflow: TextOverflow.ellipsis),
                  const SizedBox(
                    height: 15.0,
                  )
                ],
              )),
        ),
        Expanded(
            child: ListView.builder(
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                itemCount: subjects.length,
                itemBuilder: (BuildContext context, int index) {
                  var _subject = subjects[index];

                  double scale = 1.0;
                  if (topContainer > 0.1) {
                    scale = index + 0.5 - topContainer;
                    if (scale < 0) {
                      scale = 0;
                    } else if (scale > 1) {
                      scale = 1;
                    }
                  }
                  return GestureDetector(
                    onTap: () {
                      quizSubject.state = _subject.subject ?? '';
                      Get.to(() => QuizIntro());
                    },
                    child: Align(
                      heightFactor: 0.6,
                      alignment: Alignment.topCenter,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 200),
                        opacity: scale,
                        child: Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()..scale(scale, 1.0),
                          child: Card(
                              color: _subject.color,
                              elevation: 5.0,
                              // margin: const EdgeInsets.all(10.0),
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, bottom: 8.0),
                                      child: Column(
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
                                    ),
                                    CustomPaint(
                                      size: Size(100, 100),
                                      painter: Painter(
                                          start: _subject.color ?? Colors.white,
                                          end: _subject.color!.withOpacity(0.8),
                                          radius: 24.0),
                                      child: Container(
                                        height: 100.0,
                                        width: 75.0,
                                        child: Image.asset(
                                          _subject.imagePath ??
                                              "assets/icons/png/atom.png",
                                          height: 80.0,
                                          width: 80.0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  );
                }))
      ],
    ));
  }
}
