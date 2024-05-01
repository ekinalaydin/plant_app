import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/widgets/create_post.dart';

class CreatePostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(133, 192, 197, 173),
                blurRadius: 15.0,
              ),
            ],
          ),
          // here the desired height
          child: AppBar(
            elevation: 0.8,
            backgroundColor: Colors.white,
            title: Text(
              "Create Your Post!",
              style: GoogleFonts.poppins(
                color: Color(0xFF2B423D),
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PostWidget(), // Assuming this is where you create a post
          ],
        ),
      ),
    );
  }
}
