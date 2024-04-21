class Post {
  final String title;
  final DateTime createdAt;
  final String content;
  final String createdByUsername;
  final String authorProfileImage; // Assuming you might add a URL here later
  final int id;

  Post(
      {required this.title,
      required this.createdAt,
      required this.content,
      required this.createdByUsername,
      required this.authorProfileImage,
      required this.id});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      content: json['content'],
      createdByUsername: json['createdBy']['username'],
      authorProfileImage: json['authorProfileImage'] ?? '',
    );
  }
}
