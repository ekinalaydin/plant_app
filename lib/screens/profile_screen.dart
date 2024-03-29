import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/login/sign_in_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(133, 192, 197, 173),
                blurRadius: 15.0,
              ),
            ],
          ),
          child: AppBar(
            elevation: 0.8,
            backgroundColor: Colors.white,
            title: Text(
              "Profile",
              style: GoogleFonts.poppins(
                color: Color.fromRGBO(57, 79, 74, 50),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 39,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                            hintText: "Ekin",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Surname',
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 39,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                            hintText: "Alaydin",
                            alignLabelWithHint: true,
                            hintStyle: GoogleFonts.poppins(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change username',
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 39,
                  width: double.infinity, // Take full available width
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      hintText: "Please enter a new username",
                      alignLabelWithHint: true,
                      hintStyle: GoogleFonts.poppins(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(9),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change password',
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 39,
                  width: double.infinity, // Take full available width
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      // helperText: "Please enter old password",
                      hintText: "Please enter your old password",
                      alignLabelWithHint: true,
                      hintStyle: GoogleFonts.poppins(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(9),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
