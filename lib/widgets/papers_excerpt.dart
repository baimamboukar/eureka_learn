import 'package:eureka_learn/models/paper_model.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class PapersExcerpt extends StatelessWidget {
  final List<PaperModel> papers;
  const PapersExcerpt({Key? key, required this.papers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0) + const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            ...subjectsBox.map((subject) {
              return Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.only(top: 15.0),
                  title: Text(subject.subject ?? "Subject",
                      style: Styles.subtitle),
                  leading: Image.asset(
                      subject.imagePath ?? "assets/icons/png/geography.png"),
                  childrenPadding: const EdgeInsets.all(14.0),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Trending papers", style: Styles.subtitle),
                        Icon(LineIcons.starAlt, color: Palette.primary)
                      ],
                    ),
                    Text("Most downloaded papers"),
                    const SizedBox(height: 30.0),
                    ...papers
                        .where((paper) => paper.subject == subject.subject)
                        .map(
                          (_paper) => Paper(model: _paper),
                        ),
                    Divider(),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Column(
                          children: [
                            Text(
                                "Bei den Initiativen im Bereich der Risikovorsorge liegt der Schwerpunkt auf einer Stärkung des Bankensystems gegenüber",
                                style: Styles.subtitle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("120 lessons"),
                                GestureDetector(
                                  onTap: () => Get.to(() => ExplorePapers(
                                        classe: "1ere",
                                        subject: subject.subject ?? "Maths",
                                      )),
                                  child: Chip(
                                      visualDensity:
                                          VisualDensity.adaptivePlatformDensity,
                                      elevation: 8.0,
                                      backgroundColor:
                                          Palette.primary.withOpacity(0.5),
                                      side: BorderSide(
                                          color:
                                              Palette.primary.withOpacity(0.85),
                                          width: 1.0),
                                      label: Row(
                                        children: [
                                          Text("Explore..",
                                              style: Styles.subtitle),
                                          Icon(LineIcons.angleRight,
                                              color: Palette.dark)
                                        ],
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
