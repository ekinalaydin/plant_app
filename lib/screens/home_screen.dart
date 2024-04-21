import 'package:flutter/material.dart';
import 'package:plant_app/services/user_provider.dart';
import 'package:plant_app/widgets/card_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider aracılığıyla UserProvider'a erişim sağlayın
    final userProvider = Provider.of<UserProvider>(context);
    final userName = userProvider
        .user?.username; // Kullanıcı adını al veya varsayılan bir değer kullan

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
            backgroundColor: Color(0xFFDEF99B),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello $userName!",
                  style: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2B423D)),
                ),
                Text(
                  "Let’s Learn More About  Your Plants",
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF2B423D)),
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
