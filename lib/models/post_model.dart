class PostModel {
  final bool withPicture;
  final String? picturePath;
  final String timeAgo;
  final String ownerLevel;
  final List<String> comments;
  final int likesCount;
  final List<String> tags;

  PostModel(
      {required this.withPicture,
      required this.picturePath,
      required this.timeAgo,
      required this.ownerLevel,
      required this.comments,
      required this.likesCount,
      required this.tags});

  Map<String, dynamic> toDocumentSnapshot() {
    return {
      'withPicture': withPicture,
      'picturePath': picturePath,
      'timeAgo': timeAgo,
      'ownerLevel': ownerLevel,
      'comments': comments,
      'likesCount': likesCount,
      'tags': tags,
    };
  }

  factory PostModel.fromDocumentSnapshot(Map<String, dynamic> post) {
    return PostModel(
      withPicture: post['withPicture'],
      picturePath: post['picturePath'],
      timeAgo: post['timeAgo'],
      ownerLevel: post['ownerLevel'],
      comments: List<String>.from(post['comments']),
      likesCount: post['likesCount'],
      tags: List<String>.from(post['tags']),
    );
  }

  @override
  String toString() {
    return 'PostModel(withPicture: $withPicture, picturePath: $picturePath, timeAgo: $timeAgo, ownerLevel: $ownerLevel, comments: $comments, likesCount: $likesCount, tags: $tags)';
  }
}
