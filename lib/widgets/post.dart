import 'package:cached_network_image/cached_network_image.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

final commentToglerProvider = StateProvider<bool>((ref) => false);

class Post extends StatefulHookWidget {
  final PostModel model;
  const Post({Key? key, required this.model}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();
    final database = useProvider(databaseProvider);
    final commentToggler = useProvider(commentToglerProvider);

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
                          Text(widget.model.ownerName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Palette.primary)),
                          if (widget.model.inGroup)
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
                                if (widget.model.inGroup)
                                  Text(widget.model.group ?? "Group",
                                      style: Styles.subtitle),
                                Icon(Iconsax.verify,
                                    color: Palette.primary, size: 14)
                              ],
                            )
                        ],
                      ),
                    ]),
                    Text(timeago
                        .format(DateTime.parse(widget.model.timeAgo))
                        .toString()),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(widget.model.label,
                    maxLines: 4, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 10.0),
                widget.model.withPicture
                    ? GestureDetector(
                        onTap: () => Get.to(() =>
                            ImageView(imageURL: widget.model.photoURL ?? "")),
                        child: Center(
                            child: CachedNetworkImage(
                                imageUrl: widget.model.photoURL ?? "")),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 15.0),
                Wrap(
                  spacing: 3.0,
                  children: widget.model.tags.isNotEmpty
                      ? widget.model.tags
                          .map((tag) => Chip(
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                                backgroundColor:
                                    Palette.primary.withOpacity(0.5),
                                label: Text(
                                  tag,
                                  style: Styles.designText(
                                      color: Palette.dark,
                                      size: 8.0,
                                      bold: false),
                                ),
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
                      countBuilder: (count, liked, text) {
                        return Text(
                          "$count",
                          style: Styles.designText(
                              color: Palette.primary, size: 16.0, bold: false),
                        );
                      },
                      likeCount: widget.model.likesCount,
                      likeCountAnimationType: LikeCountAnimationType.all,
                      onTap: (liked) async {
                        return true;
                      },
                    ),
                    GestureDetector(
                      onTap: () => commentToggler.state = !commentToggler.state,
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.envelopeOpenText,
                            color: Palette.dark,
                            size: 18,
                          ),
                          const Text(" comment"),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Iconsax.save_add, color: Palette.dark),
                        Text(" save"),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Share.share(widget.model.label.padLeft(30));
                      },
                      child: Row(
                        children: [
                          Icon(LineIcons.share, color: Palette.dark),
                          Text(" share"),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                commentToggler.state
                    ? Container(
                        decoration: BoxDecoration(
                            color: Palette.primary.withOpacity(.3),
                            borderRadius: BorderRadius.circular(24.0)),
                        child: TextFormField(
                          controller: commentController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              border: InputBorder.none,
                              suffixIcon: GestureDetector(
                                  onTap: () async {
                                    await database
                                        .commentPost(widget.model,
                                            commentController.text)
                                        .then((response) {
                                      commentController.clear();
                                      commentToggler.state = false;
                                    });
                                  },
                                  child: Icon(LineIcons.telegramPlane,
                                      color: Palette.primary))),
                        ),
                      )
                    : widget.model.comments.length >= 1
                        ? Chip(
                            label: Text(widget.model.comments.last),
                            backgroundColor: Palette.primary.withOpacity(.4),
                            side: BorderSide(color: Palette.primary),
                          )
                        : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
