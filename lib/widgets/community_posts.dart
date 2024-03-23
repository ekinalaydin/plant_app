import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/create_post_screen.dart';

class PostPage extends StatefulWidget {
  final String postTitle;
  // final String postSummary;
  final String postBody;
  final int reactsCount;
  // final int viewsCount;
  final String authorName;
  final String authorProfileImage;
  final DateTime postDate;
  PostPage({
    required this.postTitle,
    // required this.postSummary,
    required this.postBody,
    required this.reactsCount,
    // required this.viewsCount,
    required this.authorName,
    required this.authorProfileImage,
    required this.postDate,
  });

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController _commentController = TextEditingController();
  List<String> _comments = [];
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

  void _submitComment() {
    final newComment = _commentController.text;
    if (newComment.isNotEmpty) {
      setState(() {
        _comments.add(newComment);
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // here the desired height
        child: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Community",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SearchBar(
                controller: searchController,
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
                hintText: 'Search',
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 199, 199, 199),
                border: Border.all(
                  style: BorderStyle.none,
                  color: Colors.green,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              width: 300,
              child: Image.asset(
                "lib/assets/images/plant.jpeg",
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.postTitle,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Text(widget.postSummary),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(widget.authorProfileImage),
                    ),
                    title: Text(widget.authorName),
                    subtitle: Text(
                      widget.postDate.toLocal().toString().split(' ')[0],
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    trailing: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      icon: Icon(
                        Icons.comment_bank_outlined,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        // Show comment text box
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Add a Comment'),
                              content: Material(
                                type: MaterialType.transparency,
                                child: TextField(
                                  controller: _commentController,
                                  decoration: InputDecoration(
                                    hintText: 'Write your comment...',
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close dialog
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: _submitComment,
                                  child: Text('Submit'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      label: Text(
                        'Comment',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  Text(widget.postBody),
                ],
              ),
            ),

            // Post statistics

            // Post author details

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Text('Reacts: ${widget.reactsCount}'),
            //     // Text('Views: ${widget.viewsCount}'),
            //   ],
            // ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _comments.map(
                (comment) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(widget.authorProfileImage),
                    ),
                    title: Text(widget.authorName),
                    subtitle: Text(comment),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Builder(
                builder: (context) => CreatePostScreen(),
              ),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
