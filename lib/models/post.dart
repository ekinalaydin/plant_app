class Post {
  final String title;
  final DateTime createdAt;
  final String content;
  final String createdByUsername;
  final String authorProfileImage; // Assuming you might add a URL here later
  final int id;
  final String imgUrl;
  bool isLiked;
  int likeCount;
  int commentCount;

  Post(
      {required this.title,
      required this.createdAt,
      required this.content,
      required this.createdByUsername,
      required this.authorProfileImage,
      required this.id,
      required this.commentCount,
      required this.isLiked,
      required this.likeCount,
      required this.imgUrl});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        title: json['title'],
        createdAt: DateTime.parse(json['createdAt']),
        content: json['content'],
        createdByUsername: json['createdBy']['username'],
        authorProfileImage: 'lib/assets/images/default_pp.png',
        isLiked: json['isLiked'] ?? false,
        likeCount: json['likeCount'] ?? 0,
        commentCount: json['commentCount'] ?? 0,
        imgUrl: json['imageUrl']);
  }
  void toggleLike() {
    isLiked = !isLiked;
    likeCount += isLiked ? 1 : -1;
  }
}
