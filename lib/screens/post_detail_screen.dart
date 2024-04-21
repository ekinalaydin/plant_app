import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:plant_app/models/post.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/widgets/details.dart';

class PostDetailPage extends StatefulWidget {
  final int postId;
  const PostDetailPage({Key? key, required this.postId}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService().getPostById(widget.postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error.toString()}"));
          } else if (snapshot.hasData) {
            Post post =
                Post.fromJson(snapshot.data!); // Assuming non-null for demo
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: DetailsWidget(
                  postTitle: post.title,
                  postBody: post.content,
                  authorName: post.createdByUsername,
                  authorProfileImage: post.authorProfileImage,
                  postDate: post.createdAt,
                ),
              ),
            );
          } else {
            return Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}
