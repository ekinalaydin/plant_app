import 'package:flutter/material.dart';
import 'package:plant_app/screens/post_detail_screen.dart';
import 'package:plant_app/widgets/community_posts.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PostPage(
          postTitle: 'What kind of soil should I use for my plant?',
          // postSummary: 'Creating beautiful UIs with Flutter!',
          postBody:
              'What types of soil do you guys use for your indoor plants? I’ve been using miracle grow indoor but it seems to not do well with majority of my plants. I have more than just these but I can’t find pics. Any tips on mixing soils or types to try is appreciated! Thanks!',
          reactsCount: 123,
          // viewsCount: 456,
          authorName: 'John Doe',
          authorProfileImage:
              'https://upload.wikimedia.org/wikipedia/commons/5/50/User_icon-cp.svg',
          postDate: DateTime.now(),
        ),
      ),
    );
  }
}
