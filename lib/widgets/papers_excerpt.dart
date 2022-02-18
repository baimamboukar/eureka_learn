import 'package:eureka_learn/models/paper_model.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

class PapersExcerpt extends HookWidget {
  final List<PaperModel> papersz;
  const PapersExcerpt({Key? key, required this.papersz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final student = useProvider(studentControllerProvider.notifier);
    final userPapers = useProvider(papersProvider(student.student));
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: userPapers.when(
          data: (papers) => Column(
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 110.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          PaperBox(),
                          PaperBox(),
                          PaperBox(),
                          PaperBox()
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  ...subjectsBox
                      .where((subject) =>
                          student.student.subjects.contains(subject.subject))
                      .map((subject) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(ExplorePapers(
                          subject: subject.subject ?? "unkown",
                          papers: papers,
                          classe: subject.subject ?? "unknow",
                        ));
                      },
                      child: Card(
                        elevation: 0.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                            side: BorderSide(color: subject.color!, width: 3)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: ListTile(
                              title: Text(subject.subject ?? "Subject",
                                  style: Styles.subtitle),
                              subtitle: Text("80 papers"),
                              leading: Image.asset(
                                subject.imagePath ??
                                    "assets/icons/png/geography.png",
                                height: 35.0,
                                width: 35.0,
                              ),
                              trailing: Icon(Iconsax.arrow_right)),
                        ),
                      ),
                    );
                  })
                ],
              ),
          loading: () =>
              LottieBuilder.asset("assets/animations/loadingeffect.json"),
          error: (err, trace) => const Text("err")),
    );
  }
}

class PaperBox extends StatelessWidget {
  const PaperBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  children: [
                    Positioned(
                      left: 35.0,
                      top: 58.0,
                      child: Text(
                        "Exams",
                        style: Styles.subtitle,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        "assets/icons/png/group.png",
                        height: 90,
                        width: 120,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        height: 100.0,
        width: 120,
        decoration: BoxDecoration(
            color: Palette.light, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
