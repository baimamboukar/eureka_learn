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
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Palette.randomColor(),
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
        pagination: SwiperPagination(
            margin: EdgeInsets.all(5.0), builder: SwiperPagination.fraction),
        itemCount: 10,
        viewportFraction: 0.8,
        scale: 0.9,
        outer: true,
        autoplay: true);
  }
}
