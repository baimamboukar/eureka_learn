import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/services/notifications.dart';
import 'package:eureka_learn/utils/screen.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:eureka_learn/widgets/tips_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

class NewsFeed extends HookWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = useProvider(databaseProvider);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await database.getUserFeeds();
    });
    final user = useProvider(studentControllerProvider.notifier);
    final notiff = useProvider(notificationsProvider);

    List<PostModel> feeds = useProvider(postsControllerProvider.notifier).feeds;

    return RefreshIndicator(
      onRefresh: () async {
        await database.getUserFeeds();
      },
      child: CustomScrollView(slivers: [
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
                      title: "INtelli'learn vibes",
                      body: "Get annual subscription for free",
                      summary: "Promotion",
                      channel: 'basic_channel');
                },
                child: Button(
                    color: Palette.primary,
                    label: "Notification",
                    icon: LineIcons.bell))),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            if (feeds.length < 1) {
              return Container(
                child: Center(
                  child: Text("No posts yet"),
                ),
              );
            }
            if (index == 1) return Text(user.student.names.toString());
            return Post(model: feeds[index]);
          }, childCount: feeds.length + 1),
        )
      ]),
    );
  }
}
