import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookStore extends StatelessWidget {
  const BookStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Container(
                height: 200.0,
                width: double.infinity,
                child: Swiper(
                  itemCount: books.length,
                  itemHeight: 180.0,
                  itemWidth: 300.0,
                  fade: 8.0,
                  scale: 1.20,
                  autoplay: true,
                  layout: SwiperLayout.STACK,
                  pagination: SwiperPagination(
                      margin: const EdgeInsets.only(top: 20.0),
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.grey,
                          activeColor: Palette.primary,
                          size: 6.0)),
                  itemBuilder: (BuildContext context, int index) {
                    final BookModel book = books[index];
                    return Card(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Palette.primary),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FadeIn(
                                    child: Image.asset(
                                      book.imagePath ??
                                          "assets/icons/png/cover1.jpg",
                                      width: 125.0,
                                      height: 155.0,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(book.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: Styles.designText(
                                              color: Palette.primary,
                                              bold: true,
                                              size: 15.0)),
                                      Text(
                                        "✍ by ${book.author}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Wrap(
                                        children: [
                                          Chip(
                                            label: Text("Drama"),
                                          ),
                                          Chip(
                                            label: Text("African"),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
                  },
                )),
          ),
          ...subjectsBox.map((subject) {
            final List<BookModel> _books = List.from(
                books.where((book) => book.subject == subject.subject));
            return ExpansionTile(
              title: Text(subject.subject ?? "Subject"),
              leading: Padding(
                padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                child: Image.asset(
                    subject.imagePath ?? "assets/icons/png/chemestry.png"),
              ),
              initiallyExpanded: true,
              children: [
                Container(
                    height: 125.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _books.length,
                      itemBuilder: (BuildContext context, int index) {
                        final BookModel _book = _books[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: GestureDetector(
                            onTap: () => Get.to(() => BookDetails(
                                  model: _book,
                                )),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                  boxShadow: [BoxShadow()],
                                  border: Border.all(color: Palette.primary),
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      colorFilter: ColorFilter.mode(
                                          Palette.primary.withOpacity(1.0),
                                          BlendMode.overlay),
                                      image: AssetImage(_book.imagePath ??
                                          "assets/icons/png/chemestry.png"))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(_book.name,
                                      style: Styles.designText(
                                          color: Palette.light,
                                          size: 15.0,
                                          bold: false))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ))
              ],
            );
          })
        ],
      ),
    );
  }
}
