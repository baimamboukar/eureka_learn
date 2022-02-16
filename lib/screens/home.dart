import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class NewsFeed extends HookWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = useProvider(databaseProvider);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await database.getUserFeeds();
    });
    final feedz = useProvider(feedsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        context.refresh(postsControllerProvider);
        await database.getUserFeeds();
        context.refresh(postsControllerProvider);
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
        feedz.when(
            // ignore: non_constant_identifier_names
            data: (feeds_data) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  if (feeds_data.isEmpty)
                    return Column(
                      children: [
                        Center(
                          child: Icon(Iconsax.folder_open, size: 50),
                        ),
                        const SizedBox(height: 20),
                        Text("No Feeds for the moment...",
                            style: Styles.subtitle),
                      ],
                    );
                  return Post(model: feeds_data[index]);
                }, childCount: feeds_data.length),
              );
            },
            loading: () {
              return SliverToBoxAdapter(
                  child:
                      LottieBuilder.asset("assets/animations/loadfeed.json"));
            },
            error: (err, stack) =>
                SliverToBoxAdapter(child: Center(child: Text(err.toString()))))
      ]),
    );
  }
}
