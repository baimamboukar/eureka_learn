import 'package:card_swiper/card_swiper.dart';
import 'package:eureka_learn/models/paper_model.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

final showFilterProvider = StateProvider<bool>((ref) => false);
final showSearchProvider = StateProvider<bool>((ref) => false);

class ExplorePapers extends HookWidget {
  final String subject;
  final String classe;
  const ExplorePapers({Key? key, required this.subject, required this.classe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showFilter = useProvider(showFilterProvider);
    final activeTypesMenu = useProvider(activeMenuProvider);
    final showSearch = useProvider(showSearchProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore $subject Papers", style: Styles.subtitle),
        bottom: PreferredSize(
          preferredSize: Size(Screen.width(context), 30.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(color: Colors.grey, width: 1.50),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: TextFormField(
                onTap: () => showSearch.state = !showSearch.state,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(LineIcons.filter),
                        onPressed: () {
                          showFilter.state = !showFilter.state;
                        }),
                    prefixIcon: Icon(LineIcons.search),
                    border: InputBorder.none,
                    hintText: "Which paper are you lokking for ?"),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: showSearch.state
              ? Column(
                  children: [
                    Center(
                        child: Logo(
                      withIcon: true,
                    ))
                  ],
                )
              : Column(
                  children: [
                    PapersMenu(),
                    IndexedStack(
                      index: activeTypesMenu.state,
                      children: [
                        Papers(feed: "Sequence"),
                        Text("lolo"),
                        Logo(
                          withIcon: true,
                        )
                      ],
                    )
                  ],
                )),
    );
  }
}

class Papers extends StatelessWidget {
  final String feed;
  const Papers({Key? key, required this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 15.0),
            child: Text("Most popular papers", style: Styles.subtitle),
          ),
          Container(
              height: 175.0,
              width: double.infinity,
              child: Swiper(
                itemCount: 10,
                itemHeight: 150.0,
                itemWidth: 300.0,
                fade: 8.0,
                scale: 1.20,
                layout: SwiperLayout.STACK,
                pagination: SwiperPagination(
                    margin: const EdgeInsets.only(top: 10.0),
                    builder: DotSwiperPaginationBuilder(
                        color: Colors.grey,
                        activeColor: Palette.primary,
                        size: 6.0)),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(LineIcons.pdfFileAlt,
                                    color: Palette.error, size: 64.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("4th Sequence",
                                        overflow: TextOverflow.ellipsis,
                                        style: Styles.designText(
                                            color: Palette.primary,
                                            bold: false,
                                            size: 18.0)),
                                    Text(
                                      "College la retraite",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                  label: Text("Maths"),
                                ),
                                IconButton(
                                    icon: Icon(LineIcons.download,
                                        color: Palette.primary),
                                    onPressed: () => print("downloading...")),
                              ],
                            )
                          ],
                        ),
                      ));
                },
              )),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0),
            child: Text("Papers you may like", style: Styles.subtitle),
          ),
          for (int i = 0; i < _papers.length; i++) Paper(model: _papers[i]),
        ],
      ),
    ));
  }
}

List<PaperModel> _papers = [
  PaperModel(
      from: "GBHSM",
      subject: "Physics",
      since: DateTime.parse("2021-05-28"),
      type: "2nd Sequence"),
  PaperModel(
      from: "Lykama",
      subject: "Csc",
      since: DateTime.parse("2028-04-18"),
      type: "4th Sequence"),
  PaperModel(
      from: "Xv Vogt",
      subject: "Philosophy",
      since: DateTime.parse("2021-05-28"),
      type: "Mock Exam"),
  PaperModel(
      from: "CMGHSM",
      subject: "Information Systems",
      since: DateTime.parse("2021-05-28"),
      type: "4th Sequence"),
  PaperModel(
      from: "OBC",
      subject: "Economics",
      since: DateTime.parse("2021-05-28"),
      type: "2022 Exam"),
];
