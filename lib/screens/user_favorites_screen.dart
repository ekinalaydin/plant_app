import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/models/post.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/widgets/post_card.dart';

class UserFavoritesScreen extends StatefulWidget {
  @override
  _UserFavoritesScreenState createState() => _UserFavoritesScreenState();
}

class _UserFavoritesScreenState extends State<UserFavoritesScreen> {
  var allItems = List.generate(50, (index) => 'item $index');
  var items = [];
  var searchHistory = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(queryListener);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.removeListener(queryListener);
    searchController.dispose();
  }

  void queryListener() {
    search(searchController.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        items = allItems;
      });
    } else {
      setState(() {
        items = allItems
            .where((e) => e.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // the desired height
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text(
            "My Posts",
            style: GoogleFonts.poppins(
              fontSize: 23,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
          ),
          Expanded(
            child: FutureBuilder<dynamic>(
              future: ApiService().getFavorites(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error.toString()}'));
                } else if (snapshot.hasData) {
                  var data = snapshot.data as Map<String, dynamic>;
                  var posts = data['content']
                      as List<dynamic>; // Correctly cast to List<dynamic>
                  if (posts.isNotEmpty) {
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        Post post = Post.fromJson(posts[
                            index]); // Convert each post data to a Post object
                        return PostCard(post: post);
                      },
                    );
                  } else {
                    return Center(child: Text('There is no favorite post.'));
                  }
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
