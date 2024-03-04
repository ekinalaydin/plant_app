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
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 178, 234, 176),
                              blurRadius: 20.0,
                            ),
                          ],
                        ), // Adjus
                        child: Card(
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Color.fromARGB(200, 202, 231, 134),
                          child: SizedBox(
                            width: 150,
                            height: 100,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(20),
                              leading: const Icon(
                                Icons.healing_sharp,
                                color: Color.fromARGB(153, 52, 67, 54),
                              ),
                              title: Text(
                                "Health Check",
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(153, 52, 67, 54)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 148, 177, 221),
                            blurRadius: 20.0,
                          ),
                        ],
                      ), // Adjust the height of
                      child: Card(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color.fromARGB(255, 175, 210, 238),
                        child: SizedBox(
                          width: 150,
                          height: 100,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(20),
                            leading: const Icon(
                              Icons.cloud_circle,
                              color: Colors.blue,
                            ),
                            title: Text(
                              "Weather",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Previous Diseases",
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(153, 52, 67, 54),
                      ),
                    ),
                  ],
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
