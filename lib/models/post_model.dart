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
