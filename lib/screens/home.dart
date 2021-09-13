import 'package:eureka_learn/controllers/user_controller.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/services/notifications.dart';
import 'package:eureka_learn/utils/screen.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:eureka_learn/widgets/tips_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

class NewsFeed extends ConsumerWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final user = watch(studentControllerProvider.notifier);
    final notiff = watch(notificationsProvider);
    print("Already inside the widget == ${user.student.email}");
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Container(
            height: Screen.height(context) * 0.25,
            decoration: BoxDecoration(
                //gradient: Palette.linearGradient,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0))),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TipsBanner(
                    tips: Tips(DateTime(1, 01, 2021),
                        "Lorem ipsum dolor ai samet", "Geography")))),
      ),
      SliverToBoxAdapter(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(user.student.names.toString(), style: Styles.subtitle),
      )),
      SliverToBoxAdapter(
          child: GestureDetector(
              onTap: () {
                notiff.send(
                    callbackWidget: FlutterLogo(),
                    title: "Brave notification",
                    message: "Man must survive",
                    payload: "Payload vibes",
                    id: 0);
              },
              child: Button(
                  color: Palette.primary,
                  label: "Notification",
                  icon: LineIcons.bell))),
      SliverToBoxAdapter(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 110.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subjectsBox.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: subjectsBox[index]);
              },
            )),
      )),
      SliverList(
        delegate: SliverChildListDelegate.fixed(
            posts.map((post) => Post(model: post)).toList()),
      )
    ]);
  }
}
