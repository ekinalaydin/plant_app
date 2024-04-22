import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsWidget extends StatefulWidget {
  final String postTitle;
  final String postBody;
  final String authorName;
  final String authorProfileImage;
  final DateTime postDate;
  final String imageUrl;

  DetailsWidget({
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
  List<String> _comments = [];
  Color _likeButtonColor = Colors.grey;

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
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
                      height: MediaQuery.of(context).size.height *
                          0.38, // 38% of the screen height
                      fit: BoxFit.fitHeight,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null)
                          return child; // Image is fully loaded, return the image widget
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height *
                              0.38, // Ensure the container matches the image height
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        ); // Container ensures the loading indicator is centered and maintains the height of the image
                      },
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.38,
                          child: Center(
                            child: Text(
                                'Failed to load image'), // Display a message when the image fails to load
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.postTitle,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Color.fromRGBO(34, 58, 51, 40),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.postBody,
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(right: 15),
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage(widget.authorProfileImage),
                          ),
                          title: Row(
                            children: [
                              Text(
                                widget.authorName,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Color.fromRGBO(34, 58, 51, 50),
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '•',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Color.fromRGBO(34, 58, 51, 50),
                                ),
                              ),
                              Text(
                                widget.postDate
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0],
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Color.fromRGBO(34, 58, 51, 50),
                                ),
                              ),
                              SizedBox(width: 14),
                              IconButton(
                                icon: Icon(Icons.favorite),
                                color:
                                    _likeButtonColor, // Use like button color
                                onPressed: () {
                                  // Toggle like button color
                                  setState(() {
                                    _likeButtonColor =
                                        _likeButtonColor == Colors.red
                                            ? Colors.grey
                                            : Colors.red;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context:
                                  context, // Pass the context from the surrounding widget
                              isScrollControlled:
                                  true, // Ensure modal is scrollable when keyboard is open
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    width: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              style: GoogleFonts.poppins(),
                                              controller: _commentController,
                                              decoration: InputDecoration(
                                                hintText: 'Write your comment',
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.send),
                                            onPressed: () {
                                              _submitComment();
                                              Navigator.pop(
                                                  context); // Close the bottom sheet after submitting comment
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            '${_comments.length} Comments',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(116, 124, 122, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _comments.map((comment) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage(widget.authorProfileImage),
                              ),
                              title: Text(
                                widget.authorName,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(
                                comment,
                                style: GoogleFonts.poppins(),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
