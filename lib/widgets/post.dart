import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:line_icons/line_icons.dart';
import 'package:like_button/like_button.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

class Post extends HookWidget {
  final Map<String, dynamic> model;
  const Post({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      UserAvatar(),
                      const SizedBox(width: 6.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model['ownerName'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Palette.primary)),
                          if (model['inGroup'])
                            Row(
                              children: [
                                Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()
                                      ..rotateX(
                                        180.0,
                                      ),
                                    child: Icon(LineIcons.share,
                                        size: 25.0, color: Palette.primary)),
                                if (model['inGroup'])
                                  Text(model['group'] ?? "Group",
                                      style: Styles.subtitle),
                              ],
                            )
                        ],
                      ),
                    ]),
                    Text(timeago
                        .format(DateTime.parse("2019-09-17 12:50:40.000"))
                        .toString()),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(model['label'],
                    maxLines: 4, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 10.0),
                model['withPicture']
                    ? Center(
                        child: Image(
                          errorBuilder: (_, __, ___) {
                            return Center(
                                child:
                                    const Icon(LineIcons.faceWithRollingEyes));
                          },
                          loadingBuilder: (context, widget, loadingProgress) {
                            return CircularProgressIndicator(
                              strokeWidth: 1.50,
                              value: loadingProgress?.expectedTotalBytes != null
                                  ? (loadingProgress!.cumulativeBytesLoaded) /
                                      (loadingProgress.expectedTotalBytes!)
                                  : null,
                            );
                          },
                          image: OptimizedCacheImageProvider(
                              model['photoURL'] ?? "",
                              imageRenderMethodForWeb:
                                  ImageRenderMethodForWeb.HtmlImage),
                          height: 100.0,
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 15.0),
                Wrap(
                  spacing: 3.0,
                  children: model['tags'].isNotEmpty
                      ? model['tags']
                          .map((tag) => Chip(
                                backgroundColor:
                                    Palette.primary.withOpacity(0.5),
                                label: Text(tag),
                              ))
                          .toList()
                      : [SizedBox.shrink()],
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LikeButton(
                      likeBuilder: (liked) {
                        return Icon(liked ? LineIcons.starAlt : LineIcons.star,
                            size: 25.0,
                            color: liked ? Colors.amberAccent : Colors.grey);
                      },
                      likeCount: model['likesCount'],
                      likeCountAnimationType: LikeCountAnimationType.part,
                    ),
                    Row(
                      children: const [
                        const Icon(Icons.chat),
                        const Text(" comment"),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(LineIcons.download),
                        Text(" save"),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Share.share(model['label'].padLeft(30));
                      },
                      child: Row(
                        children: [
                          Icon(LineIcons.share),
                          Text(" share"),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Chip(
                      backgroundColor: Palette.primary.withOpacity(0.15),
                      side: BorderSide(
                          color: Palette.primary.withOpacity(0.5), width: 0.60),
                      label: Text(model['comments'][0]),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
