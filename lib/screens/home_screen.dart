import 'package:flutter/material.dart';
import 'package:plant_app/widgets/card_list.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0), // here the desired height
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 84, 87, 81),
                blurRadius: 20.0,
              ),
            ],
          ), // Adjust
          child: AppBar(
            automaticallyImplyLeading:
                false, // This line removes the back button
            backgroundColor: Color.fromARGB(178, 193, 242, 155),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello X!",
                  style: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  "Let’s Learn More About  Your Plants",
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: CardList(), // SignUpForm widget'ını çağırın
      ),
    );
  }
}
