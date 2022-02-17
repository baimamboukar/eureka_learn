import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final profileTabIndexProvider = StateProvider<int>((ref) => 0);

class Profile extends HookWidget {
  final Student user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = useProvider(databaseProvider);
    final userRefresher = useProvider(studentControllerProvider.notifier);
    final profileTabIndex = useProvider(profileTabIndexProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          "Profile",
          style: Styles.subtitle,
        )),
        body: RefreshIndicator(
          onRefresh: () async => userRefresher.refresh(),
          child: SingleChildScrollView(
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Palette.primary.withOpacity(0.45),
                              BlendMode.color),
                          image: CachedNetworkImageProvider(
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
                            CachedNetworkImageProvider(user.avatar),
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
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TabLabel(0, "Activity", Iconsax.activity),
                      TabLabel(1, "Performances", Iconsax.chart_success),
                      TabLabel(2, "Infos", Icons.info)
                    ]
                        .map((label) => GestureDetector(
                              onTap: () => profileTabIndex.state = label.index,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(label.icon,
                                          color: label.index ==
                                                  profileTabIndex.state
                                              ? Palette.primary
                                              : Palette.dark),
                                      const SizedBox(width: 5.0),
                                      Text(
                                        label.title,
                                        style: Styles.designText(
                                            color: label.index ==
                                                    profileTabIndex.state
                                                ? Palette.primary
                                                : Palette.dark,
                                            size: 18,
                                            bold: true),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Visibility(
                                          visible: label.index ==
                                              profileTabIndex.state,
                                          child: Container(
                                            height: 5,
                                            width: 25.0,
                                            decoration: BoxDecoration(
                                              color: Palette.primary,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                IndexedStack(
                  index: profileTabIndex.state,
                  children: [
                    StreamBuilder<List<PostModel>>(
                        stream: database.getFeedsBy(user.id!),
                        builder: (context, data) => data.hasData
                            ? Visibility(
                                visible: data.data!.length > 0,
                                replacement: Center(
                                  child: LottieBuilder.asset(
                                    "assets/animations/nothing.json",
                                    height: 200,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    ...data.data!.map((post) => Post(
                                          model: post,
                                        ))
                                  ],
                                ),
                              )
                            : Loading()),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text("Quizz Performances",
                              style: Styles.designText(
                                  color: Palette.primary,
                                  size: 18,
                                  bold: true)),
                        ),
                        if (user.quizzes.length > 0)
                          Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 18.0, left: 10, right: 10),
                              child: Container(
                                  height: 150.0,
                                  child: SfCartesianChart(
                                    primaryXAxis: CategoryAxis(),
                                    isTransposed: true,
                                    enableAxisAnimation: true,
                                    palette: [
                                      Palette.primary,
                                      Palette.secondary,
                                      Palette.error,
                                      Palette.success,
                                      Palette.dark
                                    ],
                                    series: <ChartSeries>[
                                      ColumnSeries<QuizzModel, String>(
                                          dataSource: user.quizzes,
                                          xAxisName: "Subject",
                                          yAxisName: "Score",
                                          isVisible: true,
                                          xValueMapper: (QuizzModel quizz, _) =>
                                              quizz.subject,
                                          yValueMapper: (QuizzModel quizz, _) =>
                                              quizz.correct),
                                      LineSeries<QuizzModel, String>(
                                          width: 1.5,
                                          color: Palette.success,
                                          dataSource: user.quizzes,
                                          xValueMapper: (QuizzModel quizz, _) =>
                                              quizz.subject,
                                          yValueMapper: (QuizzModel quizz, _) =>
                                              quizz.correct),
                                    ],
                                  ))),
                        if (user.quizzes.length < 1)
                          LottieBuilder.asset(
                            "assets/animations/data.json",
                            height: 200,
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text("Learning Performances",
                              style: Styles.designText(
                                  color: Palette.primary,
                                  size: 18,
                                  bold: true)),
                        ),
                        if (user.quizzes.length > 0)
                          Container(
                            height: 150.0,
                            child: SfCircularChart(
                              legend: Legend(
                                  isVisible: true,
                                  isResponsive: true,
                                  position: LegendPosition.right),
                              series: <CircularSeries>[
                                RadialBarSeries<QuizzModel, String>(
                                    maximumValue: 10,
                                    cornerStyle: CornerStyle.endCurve,
                                    trackColor: Palette.light,
                                    legendIconType: LegendIconType.circle,
                                    dataLabelSettings: DataLabelSettings(
                                        isVisible: true,
                                        textStyle: Styles.designText(
                                            color: Palette.dark,
                                            size: 4,
                                            bold: false)),
                                    dataSource: user.quizzes,
                                    sortingOrder: SortingOrder.descending,
                                    sortFieldValueMapper: (datum, index) {
                                      return datum.topic;
                                    },
                                    xValueMapper: (quizz, _) => quizz.subject,
                                    yValueMapper: (quizz, _) => quizz.correct),
                                PieSeries<QuizzModel, String>(
                                    legendIconType: LegendIconType.circle,
                                    dataLabelSettings: DataLabelSettings(
                                        isVisible: true,
                                        textStyle: Styles.designText(
                                            color: Palette.dark,
                                            size: 4,
                                            bold: false)),
                                    groupMode: CircularChartGroupMode.value,
                                    dataSource: user.quizzes,
                                    sortingOrder: SortingOrder.descending,
                                    sortFieldValueMapper: (datum, index) {
                                      return datum.topic;
                                    },
                                    xValueMapper: (quizz, _) => quizz.subject,
                                    yValueMapper: (quizz, _) => quizz.correct)
                              ],
                            ),
                          ),
                        if (user.quizzes.length < 1)
                          LottieBuilder.asset(
                            "assets/animations/nothing.json",
                          ),
                      ],
                    ),
                    Text("Infos")
                  ],
                )
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

class TabLabel {
  final int index;
  final String title;
  final IconData icon;
  TabLabel(this.index, this.title, this.icon);
}
