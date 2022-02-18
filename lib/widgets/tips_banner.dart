import 'package:card_swiper/card_swiper.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';

class TipsBanner extends StatelessWidget {
  final Tips tips;
  const TipsBanner({Key? key, required this.tips}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
        itemHeight: 120.0,
        itemWidth: Screen.width(context),
        pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 6.0),
            builder: DotSwiperPaginationBuilder(
                color: Colors.grey, activeColor: Palette.primary, size: 6.0)),
        itemBuilder: (BuildContext context, int index) {
          return Hacktitude(
            model: tips,
          );
        },
        itemCount: 10,
        viewportFraction: 0.8,
        autoplayDelay: 2,
        autoplay: true);
  }
}

class Hacktitude extends StatelessWidget {
  final Tips model;
  const Hacktitude({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Stack(
          children: [
            Text(
                "The beautiful thing with learning is that no one can tell you what to do.",
                style: Styles.designText(
                    color: Palette.dark, size: 25, bold: false))
          ],
        ),
      ),
    );
  }
}
