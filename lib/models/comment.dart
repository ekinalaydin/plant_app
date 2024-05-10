class Comment {
  String commentText;
  int commentId;
  String writerId;
  DateTime createdAt;
  String writerUsername;

  Comment(
      {required this.commentText,
      required this.commentId,
      required this.writerId,
      required this.writerUsername,
      required this.createdAt});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        commentId: json['id'],
        commentText: json['text'],
        writerId: json['user']['id'],
        writerUsername: json['user']['username'],
        createdAt: DateTime.parse(json['createdAt']));
  }
}
