import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/disease_detection.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiseaseDetection()),
          );
        },
        child: Card(
          color: Color(0xFFF8F9F9),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFFE3E9E9),
                  radius: 35,
                  child: ClipOval(
                    child: Image.asset(
                      "lib/assets/images/apple.jpeg",
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Apple Scab',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2B423D),
                        ),
                      ),
                      Text(
                        '20/12/2023',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF2B423D),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  iconSize: 32,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Builder(
                          builder: (context) => DiseaseDetection(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Color(0xFF2B826D),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
