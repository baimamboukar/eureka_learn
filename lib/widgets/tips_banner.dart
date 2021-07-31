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
          return Container(
            color: Colors.grey.shade300,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Text(tips.content),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Chip(
                        backgroundColor: Palette.primary.withOpacity(0.5),
                        side: BorderSide(
                            color: Palette.primary.withOpacity(0.5),
                            width: 0.60),
                        label: Text(tips.subject),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
        itemCount: 10,
        viewportFraction: 0.8,
        autoplayDelay: 2,
        autoplay: true);
  }
}
