import 'package:flutter/material.dart';
import 'package:plant_app/widgets/community_posts.dart';
import 'package:plant_app/services/api_service.dart'; // Make sure to import your ApiService

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  late Future<dynamic> postsFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<dynamic>(
      future: ApiService().getAllPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        } else if (snapshot.hasData && snapshot.data != null) {
          var posts = snapshot.data['content'];
          print(posts);
          if (posts is List && posts.isNotEmpty) {
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index]
                      ['title']), // Make sure these keys exist in your data
                  subtitle: Text(posts[index]['content']),
                );
              },
            );
          } else {
            return Center(child: Text('No posts found'));
          }
        } else {
          return Center(child: Text('No data available'));
        }
      },
    ));
  }
}
