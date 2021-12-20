class PostModel {
  final bool withPicture;
  final bool inGroup;
  final String? photoURL;
  final String? group;
  final String label;
  final String timeAgo;
  final String ownerId;
  final String ownerLevel;
  final String ownerName;
  final String ownerAvatar;
  final List<String> comments;
  final int likesCount;
  final String? background;
  final List<String> tags;

  PostModel(
      {required this.withPicture,
      required this.inGroup,
      required this.label,
      this.photoURL,
      this.group,
      this.background,
      required this.timeAgo,
      required this.ownerId,
      required this.ownerLevel,
      required this.ownerName,
      required this.ownerAvatar,
      required this.comments,
      required this.likesCount,
      required this.tags});

  static Map<String, dynamic> toDocumentSnapshot(PostModel post) {
    return {
      'withPicture': post.withPicture,
      'inGroup': post.inGroup,
      'group': post.group,
      'label': post.label,
      'photoURL': post.photoURL,
      'timeAgo': post.timeAgo,
      'ownerId': post.ownerId,
      'ownerLevel': post.ownerLevel,
      'ownerName': post.ownerName,
      'ownerAvatar': post.ownerAvatar,
      'comments': post.comments,
      'likesCount': post.likesCount,
      'background': post.background,
      'tags': post.tags,
    };
  }

  factory PostModel.fromDocumentSnapshot(Map<String, dynamic> post) {
    return PostModel(
      withPicture: post['withPicture'],
      inGroup: post['inGroup'],
      photoURL: post['photoURL'],
      timeAgo: post['timeAgo'],
      label: post['label'],
      ownerId: post['ownerId'],
      ownerLevel: post['ownerLevel'],
      ownerName: post['ownerName'],
      ownerAvatar: post['ownerAvatar'],
      comments: List<String>.from(post['comments']),
      likesCount: post['likesCount'],
      background: post['background'],
      tags: List<String>.from(post['tags']),
    );
  }

  @override
  String toString() {
    return 'PostModel(withPicture: $withPicture, inGroup: $inGroup, photoURL: $photoURL, timeAgo: $timeAgo, ownerId: $ownerId, ownerLevel:$ownerLevel ,ownerName: $ownerName, ownerAvatar: $ownerAvatar, group: $group, label: $label,comments: $comments, likesCount: $likesCount, tags: $tags)';
  }
}
