import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/disease_detection.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(162, 202, 231, 134),
                blurRadius: 25.0,
              ),
            ],
          ), // Adjust the height of the card container
          child: Card(
            shadowColor: const Color.fromARGB(255, 133, 131, 131),
            color: Color.fromARGB(235, 227, 246, 212),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10, 10, 10),
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(153, 52, 67, 54),
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
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Apple Scab',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(153, 52, 67, 54)),
                      ),
                      Text(
                        '20/12/2023',
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(153, 52, 67, 54)),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    debugPrint("Current context: $context");
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
                    color: Color.fromARGB(153, 52, 67, 54),
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
