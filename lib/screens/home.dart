import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eureka_learn/controllers/user_controller.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:eureka_learn/services/notifications.dart';
import 'package:eureka_learn/utils/screen.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:eureka_learn/widgets/tips_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:line_icons/line_icons.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:share_plus/share_plus.dart';

import 'package:timeago/timeago.dart' as timeago;

class NewsFeed extends ConsumerWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final user = watch(studentControllerProvider.notifier);
    final notiff = watch(notificationsProvider);
    final database = watch(databaseProvider);
    // if (feed.state.isEmpty) {
    //   feed.state = database.getFeed(
    //     user.student.id,
    //   );
    // }
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
              onTap: () {},
              child: Button(
                  color: Palette.primary,
                  label: "Notification",
                  icon: LineIcons.bell))),
      // SliverToBoxAdapter(
      //     child: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //       height: 110.0,
      //       child: ListView.builder(
      //         scrollDirection: Axis.horizontal,
      //         itemCount: subjectsBox.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           return Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: subjectsBox[index]);
      //         },
      //       )),
      // )),
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          List<PostModel> posts = database.getUserFeed(user.student);
          return Post(model: posts[index]);
        }, childCount: database.getUserFeed(user.student).length),
      )
    ]);
  }
}
