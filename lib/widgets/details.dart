import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsWidget extends StatefulWidget {
  final String postTitle;
  // final String postSummary;
  final String postBody;
  //final int reactsCount;
  // final int viewsCount;
  final String authorName;
  final String authorProfileImage;
  final DateTime postDate;

  DetailsWidget({
    required this.postTitle,
    // required this.postSummary,
    required this.postBody,
    // required this.reactsCount,
    // required this.viewsCount,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 224, 228, 208),
                  spreadRadius: 3,
                  blurRadius: 40,
                  offset: Offset(0, 2),
                ),
              ]),
              width: 100,
              height: 170,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "lib/assets/images/plant.jpeg",
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.symmetric(),
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 201, 224, 109),
                        Color.fromARGB(255, 218, 242, 168)
                      ],
                      stops: [0.25, 0.75],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(220, 226, 201, 0.498),
                        spreadRadius: 10,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        widget.postTitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Color.fromRGBO(34, 58, 51, 40)),
                      ),
                    ),
                    SizedBox(height: 8),
                    // SizedBox(height: 16),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, right: 12, left: 12),
                      child: Text(
                        widget.postBody,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ), // Text(widget.postSummary),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            NetworkImage(widget.authorProfileImage),
                      ),
                      title: Text(
                        widget.authorName,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color.fromRGBO(34, 58, 51, 50)),
                      ),
                      subtitle: Text(
                          widget.postDate.toLocal().toString().split(' ')[0],
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color.fromRGBO(34, 58, 51, 50))),
                      // trailing:
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 80, bottom: 5, right: 50),
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 246, 247, 226),
                              shadowColor: Color.fromARGB(255, 216, 229, 160),
                            ),
                            icon: Icon(Icons.comment_sharp,
                                color: Color.fromARGB(255, 116, 118, 107)),
                            onPressed: () {
                              // Show comment text box
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        Color.fromRGBO(224, 231, 231, 1),
                                    title: Text(
                                      'Add a Comment',
                                      style: GoogleFonts.poppins(),
                                    ),
                                    content: SingleChildScrollView(
                                      // Wrap content with SingleChildScrollView
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              20.0), // Increase contentPadding
                                          child: TextField(
                                            controller: _commentController,
                                            decoration: InputDecoration(
                                              hintText: 'Write your comment...',
                                              hintStyle: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context); // Close dialog
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: GoogleFonts.poppins(
                                            color: const Color.fromARGB(
                                                179, 0, 0, 0),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      ElevatedButton(
                                        onPressed: () {
                                          _submitComment();
                                          Navigator.pop(
                                              context); // Close dialog
                                        },
                                        child: Text(
                                          'Submit',
                                          style: GoogleFonts.poppins(
                                            color: const Color.fromARGB(
                                                179, 0, 0, 0),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            label: Text(
                              'Add Your Comment',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(116, 124, 122, 1)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(220, 226, 201, 0.498),
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ]),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: _comments.map(
                    (comment) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.symmetric(
                                horizontal: BorderSide(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Color.fromRGBO(57, 79, 74, 100),
                        ))),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage:
                                NetworkImage(widget.authorProfileImage),
                          ),
                          title: Text(widget.authorName),
                          subtitle: Text(comment),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
