import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:eureka_learn/providers/user_provider.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Profile extends HookWidget {
  final Student user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = useProvider(databaseProvider);
    final userRefresher = useProvider(studentControllerProvider.notifier);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          "Profile",
          style: Styles.subtitle,
        )),
        body: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: () async => userRefresher.refresh(),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Palette.primary.withOpacity(0.45),
                              BlendMode.color),
                          image: OptimizedCacheImageProvider(
                              "https://firebasestorage.googleapis.com/v0/b/eurekalearn-d63d4.appspot.com/o/eureka.png?alt=media&token=9d806524-caa7-4d72-a006-e4ae6e578e0b",
                              maxHeight: 140))),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                      padding: const EdgeInsets.only(left: 6.0, right: 4.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            OptimizedCacheImageProvider(user.avatar),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                user.names,
                                style: Styles.designText(
                                    color: Palette.primary,
                                    size: 20,
                                    bold: true),
                              ),
                              user.achievements.length == 0
                                  ? Icon(Icons.verified,
                                      color: Palette.primary, size: 14)
                                  : SizedBox.shrink(),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              "${user.level} Advanced level student at ${user.school}",
                              style: Styles.designText(
                                  color: Palette.dark, size: 12, bold: true),
                            ),
                          ),
                          Wrap(
                            spacing: 3.0,
                            children: [
                              ...["Bronz", "Gold", "Silver"]
                                  .map((medal) => Chip(
                                        backgroundColor: medal == "Bronz"
                                            ? Colors.brown
                                            : medal == "Gold"
                                                ? Palette.secondary
                                                : Colors.grey,
                                        side: BorderSide(
                                            color: medal == "Bronz"
                                                ? Colors.brown
                                                : medal == "Gold"
                                                    ? Palette.secondary
                                                    : Colors.grey),
                                        label: Text(
                                          "$medal 10",
                                          style: Styles.designText(
                                              color: Palette.dark,
                                              size: 10.0,
                                              bold: false),
                                        ),
                                        avatar: Icon(
                                          medal == "Bronz"
                                              ? LineIcons.award
                                              : medal == "Gold"
                                                  ? LineIcons.medal
                                                  : Iconsax.award,
                                        ),
                                      ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text("Quizz Performances",
                      style: Styles.designText(
                          color: Palette.primary, size: 18, bold: true)),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        bottom: 18.0, left: 10, right: 10),
                    child: Container(
                        height: 150.0,
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                            BarSeries<QuizzModel, String>(
                                dataSource: user.quizzes,
                                xValueMapper: (QuizzModel quizz, _) =>
                                    quizz.subject,
                                yValueMapper: (QuizzModel quizz, _) =>
                                    quizz.correct)
                          ],
                        ))),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text("Learning Performances",
                      style: Styles.designText(
                          color: Palette.primary, size: 18, bold: true)),
                ),
                Container(
                  height: 150.0,
                  child: SfCircularChart(
                    legend: Legend(
                        isVisible: true,
                        isResponsive: true,
                        position: LegendPosition.right),
                    series: <CircularSeries>[
                      RadialBarSeries<String, String>(
                          maximumValue: 20,
                          cornerStyle: CornerStyle.endCurve,
                          trackColor: Palette.light,
                          legendIconType: LegendIconType.circle,
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              textStyle: Styles.designText(
                                  color: Palette.dark, size: 4, bold: false)),
                          dataSource: [
                            "Biology",
                            "Computer",
                            "Maths",
                            "Physics",
                            "Chemistry"
                          ],
                          sortingOrder: SortingOrder.descending,
                          sortFieldValueMapper: (datum, index) {
                            return datum;
                          },
                          xValueMapper: (perf, _) => perf,
                          yValueMapper: (perf, _) => perf == "Biology"
                              ? 8
                              : perf == "Computer"
                                  ? 14
                                  : perf == "Physics"
                                      ? 9
                                      : perf == "Maths"
                                          ? 11
                                          : 12)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              database.pushQuestions(data: [
                {
                  "label": "What does LAN stands for ?",
                  "subject": "Computer Science",
                  "section": "Anglophone",
                  "level": "novice",
                  "correct_answer": "Local Area Network",
                  "wrong_answers":
                      "Long Area Network __ Live Area Network __ Lost Area Network",
                  "topic": "networks",
                  "class": "Ordinary"
                },
                {
                  "label": "What does LAN stands for ?",
                  "subject": "Biology",
                  "section": "Anglophone",
                  "level": "medium",
                  "correct_answer": "Local Area Network",
                  "wrong_answers":
                      "Long Area Network __ Live Area Network __ Lost Area Network",
                  "topic": "networks",
                  "class": "Advanced"
                }
              ]);
            },
            child: Icon(Iconsax.edit)),
      ),
    );
  }
}
