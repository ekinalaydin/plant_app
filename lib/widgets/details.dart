import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsWidget extends StatefulWidget {
  final String postTitle;
  final String postBody;
  final String authorName;
  final String authorProfileImage;
  final DateTime postDate;

  DetailsWidget({
    required this.postTitle,
    required this.postBody,
    required this.authorName,
    required this.authorProfileImage,
    required this.postDate,
  });

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  TextEditingController _commentController = TextEditingController();
  List<String> _comments = [];
  bool _isCommentBoxVisible = false;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 224, 228, 208),
                  spreadRadius: 3,
                  blurRadius: 40,
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 201, 224, 109),
                  Color.fromARGB(255, 218, 242, 168),
                ],
                stops: [0.25, 0.75],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 170,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset("lib/assets/images/plant.jpeg",
                          fit: BoxFit.fill,
                          width: double.infinity,
                          alignment: Alignment.topLeft),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                              NetworkImage(widget.authorProfileImage),
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
                            SizedBox(
                                width:
                                    4), // Add spacing between author name and separator
                            Text(
                              '•',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color.fromRGBO(34, 58, 51, 50),
                              ),
                            ), // Add spacing between author name and date
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 246, 247, 226),
                      shadowColor: Color.fromARGB(255, 216, 229, 160),
                    ),
                    icon: Icon(Icons.comment_sharp,
                        color: Color.fromARGB(255, 116, 118, 107)),
                    onPressed: () {
                      setState(() {
                        _isCommentBoxVisible = true;
                      });
                    },
                    label: Text(
                      'Add Your Comment',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(116, 124, 122, 1),
                      ),
                    ),
                  ),
                ),
                if (_isCommentBoxVisible)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _commentController,
                                decoration: InputDecoration(
                                  hintText: 'Write your comment...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                _submitComment();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: _comments.map((comment) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.authorProfileImage),
                        ),
                        title: Text(widget.authorName),
                        subtitle: Text(comment),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
