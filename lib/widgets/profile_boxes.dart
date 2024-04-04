import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileBoxes extends StatelessWidget {
  final String title;
  final String content;
  final String helperTxt;
  final String hintTxt;
  final double height;
  final double fontSize;
  final FontWeight fontW;
  TextEditingController controller = TextEditingController();

  ProfileBoxes(
      {required this.title,
      required this.content,
      required this.helperTxt,
      required this.hintTxt,
      required this.height,
      required this.fontSize,
      required this.fontW,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, //Change Password
            style: GoogleFonts.poppins(
                color: Color.fromRGBO(34, 58, 51, 40),
                fontWeight: FontWeight.bold,
                fontSize: fontSize),
          ),
          Text(
            content, // "Please enter your old password",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 4),
          SizedBox(
            height: height,
            width: double.infinity, // Take full available width
            child: TextFormField(
              controller: controller,
              textAlign: TextAlign.start,
              cursorHeight: 20,
              decoration: InputDecoration(
                helperText: helperTxt,
                hintText: hintTxt,
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
    );
  }
}
