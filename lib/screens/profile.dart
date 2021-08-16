import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Profile extends StatelessWidget {
  final Student user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 220.0,
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 40.0, left: 12.0, right: 12.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("❣ ${user.school}"),
                                  Text(user.email),
                                  Text("${user.phone}"),
                                  Wrap(
                                    spacing: 3.5,
                                    children: user.subjects
                                        .map((subject) => Chip(
                                              backgroundColor: Palette.primary
                                                  .withOpacity(0.5),
                                              label: Text(subject),
                                            ))
                                        .toList(),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Icon(LineIcons.medal,
                                        size: 38.0, color: Palette.secondary),
                                    Text("Brave Achiever")
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(LineIcons.trophy,
                                        size: 38.0, color: Palette.dark),
                                    Text("Best Achievement")
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration()),
                  collapseMode: CollapseMode.pin,
                  stretchModes: [
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                    StretchMode.zoomBackground
                  ],
                  title: Text(user.names, overflow: TextOverflow.ellipsis)),
            ),
            SliverToBoxAdapter(
              child: Column(children: [
                for (int i = 0; i < 250; i++) Text("I love Davna Marie Claire")
              ]),
            )
          ],
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton:
            FloatingActionButton(onPressed: null, child: Icon(LineIcons.edit)),
      ),
    );
  }
}
