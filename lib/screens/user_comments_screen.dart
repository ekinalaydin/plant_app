import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserCommentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Your Comments",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 23,
              color: Color(0xFF2B423D)),
        ),
      ),
    );
  }
}
