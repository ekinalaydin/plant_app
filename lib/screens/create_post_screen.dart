import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/themes/colors.dart';
import 'package:plant_app/widgets/create_post.dart';

class CreatePostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.secondaryVariant,
                blurRadius: 10.0,
              ),
            ],
          ),
          // here the desired height
          child: AppBar(
            elevation: 0.3,
            backgroundColor: AppColors.background,
            title: Text(
              "Create Your Post!",
              style: GoogleFonts.poppins(
<<<<<<< HEAD
                color: AppColors.onSurface,
=======
                color: Color(0xFF2B423D),
>>>>>>> origin/ekin
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
