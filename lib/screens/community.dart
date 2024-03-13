import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/widgets/community_page.dart';
import 'package:plant_app/widgets/create_post.dart';

class Community extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // here the desired height
        child: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Community",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [CommunityWidget()]),
      ),
    );
  }
}
