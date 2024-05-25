import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plant_app/models/comment.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/themes/colors.dart';

class DetailsWidget extends StatefulWidget {
  final int postId;
  final String postTitle;
  final String postBody;
  final String authorName;
  final String authorProfileImage;
  final DateTime postDate;
  final String imageUrl;
  bool isLiked;

  DetailsWidget(
      {required this.postId,
      required this.postTitle,
      required this.postBody,
      required this.authorName,
      required this.authorProfileImage,
      required this.postDate,
      required this.imageUrl,
      required this.isLiked});

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  TextEditingController _commentController = TextEditingController();
  Future<List<Comment>>? _commentsFuture;
  bool _isLoading = false;

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

    setState(() => _isLoading = true);

    try {
      await ApiService().postComment(widget.postId, context, newComment);
      _commentController.clear();
      await _fetchComments(); // Fetch comments again after a successful post
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Comment posted successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchComments() async {
    try {
      var updatedComments = await ApiService().getComments(widget.postId);
      setState(() {
        _commentsFuture = Future.value(updatedComments);
      });
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            widget.postTitle,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface),
          ),
        ),
        extendBodyBehindAppBar: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0),
                      ),
                      child: Image.network(
                        widget.imageUrl,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.38,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child; // Image is fully loaded, return the image widget
                          }
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height *
                                0.38, // Ensure the container matches the image height
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          ); // Container ensures the loading indicator is centered and maintains the height of the image
                        },
                        errorBuilder: (context, error, stackTrace) => InkWell(
                          onTap: () {
                            setState(() {}); // Retry loading the image
                          },
                          child: Center(
                            child: Text('Tap to retry loading image'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.postTitle,
                              style: GoogleFonts.poppins(
                                  color: AppColors.onSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          SizedBox(height: 8),
                          Text(widget.postBody,
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: AppColors.onSurface)),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 8),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(widget.authorProfileImage),
                                  ),
                                  title: Text(widget.authorName,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                  subtitle: Text(widget.postDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0]),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.favorite),
                                color:
                                    widget.isLiked ? Colors.red : Colors.grey,
                                onPressed: () async {
                                  try {
                                    await ApiService()
                                        .likePost(widget.postId, context);
                                    setState(() {
                                      widget.isLiked = !widget.isLiked;
                                    });
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(e.toString())));
                                  }
                                },
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              hintText: 'Add a comment',
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14, color: AppColors.onSurface),
                              suffixIcon: _isLoading
                                  ? Container(
                                      padding: EdgeInsets.all(8.0),
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2.0),
                                    )
                                  : IconButton(
                                      icon: Icon(Icons.send),
                                      onPressed: _submitComment,
                                    ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.onSurface,
                                    width: 2.0), // Focus state
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              if (!_isLoading) {
                                _submitComment();
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FutureBuilder<List<Comment>>(
                            future: _commentsFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData &&
                                  snapshot.data!.isEmpty) {
                                return Text("0 comments",
                                    style: GoogleFonts.poppins(fontSize: 16));
                              } else {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          Comment comment =
                                              snapshot.data![index];
                                          return Container(
                                            margin:
                                                EdgeInsets.only(bottom: 8.0),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 12.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 6,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      widget.imageUrl),
                                                  radius: 18,
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              comment
                                                                  .writerUsername,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          14)),
                                                          SizedBox(width: 6),
                                                          Text(
                                                            DateFormat(
                                                                    'MMM d, y')
                                                                .format(comment
                                                                    .createdAt), // Assuming you have date as DateTime object
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 4),
                                                      Text(comment.commentText,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize:
                                                                      12)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
