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
      child: ListView.builder(
          itemBuilder: (context, index) {
            return Text("Hello world");
          },
          itemCount: feeds.length),
    );
  }
}
