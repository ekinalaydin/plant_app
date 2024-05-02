import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/models/comment.dart';
import 'package:plant_app/services/api_service.dart';

class DetailsWidget extends StatefulWidget {
  final int postId;
  final String postTitle;
  final String postBody;
  final String authorName;
  final String authorProfileImage;
  final DateTime postDate;
  final String imageUrl;

  DetailsWidget({
    required this.postId,
    required this.postTitle,
    required this.postBody,
    required this.authorName,
    required this.authorProfileImage,
    required this.postDate,
    required this.imageUrl,
  });

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  TextEditingController _commentController = TextEditingController();
  Future<List<Comment>>? _commentsFuture;
  bool _isLoading = false; // Tracks if a comment post is in progress

  @override
  void initState() {
    super.initState();
    _commentsFuture = ApiService().getComments(widget.postId);
  }

  void _submitComment() async {
    final newComment = _commentController.text.trim();
    if (newComment.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Comment cannot be empty!')));
      return;
    }

    setState(() {
      _isLoading = true; // Start loading before the try block
    });

    try {
      await ApiService().postComment(widget.postId, context, newComment);
      _commentController.clear(); // Clear the text field on successful post

      // Optimistically update comments list or re-fetch comments
      var updatedComments = await ApiService().getComments(widget.postId);
      setState(() {
        _commentsFuture = Future.value(
            updatedComments); // Update the future directly with new data
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Comment posted successfully!')));
    } catch (e) {
      // Log the error or handle it in a more refined way
      print(
          'Failed to post comment: $e'); // Consider logging to console or your logging infrastructure
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to post comment: $e')));
    } finally {
      setState(() {
        _isLoading =
            false; // Ensure loading state is updated even if an error occurs
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 218, 242, 168),
              Color.fromRGBO(237, 240, 230, 1),
              Color.fromRGBO(236, 237, 228, 1),
              Color.fromRGBO(235, 233, 221, 1),
              Color.fromRGBO(237, 234, 221, 1),
              Color.fromARGB(255, 218, 242, 168)
            ],
            stops: [0.1, 0.25, 0.5, 0.75, 0.8, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                widget.imageUrl,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.38,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Text('Failed to load image'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.postTitle,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 8),
                    Text(widget.postBody,
                        style: GoogleFonts.poppins(fontSize: 14)),
                    ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage(widget.authorProfileImage)),
                      title: Text(widget.authorName,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      subtitle: Text("${widget.postDate.toLocal()}"),
                    ),
                    TextFormField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        labelText: 'Add a comment',
                        suffixIcon: _isLoading
                            ? CircularProgressIndicator()
                            : IconButton(
                                icon: Icon(Icons.send),
                                onPressed: _submitComment,
                              ),
                      ),
                    ),
                    FutureBuilder<List<Comment>>(
                      future: _commentsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                          return Text("0 comments",
                              style: GoogleFonts.poppins(fontSize: 16));
                        } else {
                          return ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: snapshot.data!
                                .map((comment) => ListTile(
                                      title: Text(comment.writerUsername,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14)),
                                      subtitle: Text(comment.commentText,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12)),
                                    ))
                                .toList(),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
