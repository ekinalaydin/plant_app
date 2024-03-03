import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/camera_screen.dart';
// import 'package:plant_app/screens/home_screen.dart';
import 'package:plant_app/widgets/card.dart';

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (context) => CameraScreen(),
                          ),
                        );
                      },
                      child: Card(
                        color: const Color.fromARGB(255, 232, 236, 234),
                        child: SizedBox(
                          width: 150,
                          height: 120,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(20),
                            leading: const Icon(Icons.healing_sharp),
                            title: Text(
                              "Health Check",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Card(
                      shadowColor: const Color.fromARGB(255, 133, 131, 131),
                      color: const Color.fromARGB(255, 232, 236, 234),
                      child: SizedBox(
                        width: 150,
                        height: 120,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          leading: const Icon(Icons.cloud_circle),
                          title: Text(
                            "Weather",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your Previous Diseases",
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
              // Adding multiple instances of CardWidget
              CardWidget(),
              CardWidget(),
              CardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
