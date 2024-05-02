class Comment {
  String commentText;
  int commentId;
  String writerId;
  String writerUsername;

  Comment(
      {required this.commentText,
      required this.commentId,
      required this.writerId,
      required this.writerUsername});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        commentId: json['id'],
        commentText: json['text'],
        writerId: json['user']['id'],
        writerUsername: json['user']['username']);
  }
}
