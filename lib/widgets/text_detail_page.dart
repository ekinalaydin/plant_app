import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSection extends StatelessWidget {
  final String title;
  final String content;

  TextSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(108, 124, 117, 0.857)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            content,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
