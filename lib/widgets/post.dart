import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:like_button/like_button.dart';

class Post extends StatelessWidget {
  final PostModel model;
  const Post({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Palette.light,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(model.postOwner,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Icon(LineIcons.angleRight),
                  Text("Sciences and Energy"),
                  const SizedBox(width: 20.0),
                  Text("${model.timeAgo} ago")
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                  "Lorem ipsum dolor si amet do set consectur de la hammaLorem ipsum dolor si amet do set consectur de la hammaLorem ipsum dolor si amet do set consectur de la hammaLorem ipsum dolor si amet do set consectur de la hammaLorem ipsum dolor si amet do set consectur de la hammaLorem ipsum dolor si amet do set consectur de la hamma",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 10.0),
              model.withPicture
                  ? Center(
                      child: Image(
                        image: AssetImage(model.picturePath),
                        height: 100.0,
                      ),
                    )
                  : SizedBox.shrink(),
              const SizedBox(height: 15.0),
              Wrap(
                spacing: 3.0,
                children: model.tags != null
                    ? model.tags
                        .map((tag) => Chip(
                              backgroundColor: Palette.primary.withOpacity(0.5),
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
                    likeCount: model.likesCount,
                    likeCountAnimationType: LikeCountAnimationType.part,
                  ),
                  Text(" Comments"),
                  Text("Share"),
                  Text("Save")
                ],
              ),
              Divider(),
              Row(
                children: [
                  Chip(
                    backgroundColor: Palette.primary.withOpacity(0.15),
                    side: BorderSide(
                        color: Palette.primary.withOpacity(0.5), width: 0.60),
                    label: Text(model.comments[0]),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PostModel {
  final bool withPicture;
  final String picturePath;
  final String timeAgo;
  final String postOwner;
  final List<String> comments;
  final int likesCount;
  final List<String> tags;

  PostModel(
      {required this.withPicture,
      required this.picturePath,
      required this.timeAgo,
      required this.postOwner,
      required this.comments,
      required this.likesCount,
      required this.tags});
}
