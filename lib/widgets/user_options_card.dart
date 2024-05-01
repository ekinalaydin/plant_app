import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/profile_screen.dart';

class UserOptionsCard extends StatelessWidget {
  final String title;
  UserOptionsCard({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shadowColor: Color.fromARGB(255, 84, 87, 81),
        color: Color(0xFFDEF99B),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF2B423D)),
                ),
              ),
              Icon(
                Icons.arrow_circle_right_outlined,
                color: Color(0xFF2B826D),
                size: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
