import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/models/post.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/widgets/post_card.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool _expanded = false;
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
            "Community",
            style: GoogleFonts.poppins(
              color: Color(0xFF2B423D),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
            child: SizedBox(
              height: 40,
              child: SearchBar(
                surfaceTintColor:
                    MaterialStateProperty.all(Color.fromRGBO(245, 246, 246, 1)),
                backgroundColor:
                    MaterialStateProperty.all(Color.fromRGBO(255, 255, 255, 1)),
                overlayColor:
                    MaterialStateProperty.all(Color.fromRGBO(240, 239, 237, 1)),
                shadowColor: MaterialStateProperty.all(
                    Color.fromRGBO(224, 231, 231, 100)),
                controller: searchController,
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
                hintText: 'Search',
                textStyle: MaterialStateProperty.all(GoogleFonts.poppins(
                  color: Color(0xFF2B423D),
                )),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<dynamic>(
              future: ApiService().getAllPosts(context),
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
                    return Center(child: Text('No posts found'));
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
