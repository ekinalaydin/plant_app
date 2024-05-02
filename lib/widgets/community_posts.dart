import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/models/post.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/themes/colors.dart';
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
  late Future<dynamic> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService().getAllPosts(context, null);
    searchController.addListener(queryListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)!.isCurrent) {
      setState(() {
        _future = ApiService().getAllPosts(context, searchController.text);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    searchController.removeListener(queryListener);
    searchController.dispose();
  }

  void queryListener() {}

  void search(String query) async {
    setState(() {
      _future = ApiService().getAllPosts(context, query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // the desired height
        child: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.background,
          elevation: 0.3,
          title: Text(
            "Community",
            style: GoogleFonts.poppins(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurface,
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
                onSubmitted: (query) {
                  search(query);
                },
                surfaceTintColor: MaterialStateProperty.all(AppColors.surface),
                backgroundColor:
                    MaterialStateProperty.all(AppColors.background),
                overlayColor: MaterialStateProperty.all(AppColors.onPrimary),
                shadowColor:
                    MaterialStateProperty.all(AppColors.secondaryVariant),
                controller: searchController,
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: AppColors.onSurface,
                  ),
                ),
                hintText: 'Search',
                textStyle: MaterialStateProperty.all(GoogleFonts.poppins(
                  color: AppColors.onSurface,
                )),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<dynamic>(
              future: ApiService().getAllPosts(context, searchController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error.toString()}'));
                } else if (snapshot.hasData) {
                  var data = snapshot.data as Map<String, dynamic>;
                  var posts = data['content'] as List<dynamic>;
                  if (posts.isNotEmpty) {
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        Post post = Post.fromJson(posts[index]);
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
