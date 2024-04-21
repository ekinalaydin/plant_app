import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/widgets/details.dart';

class PostDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(133, 192, 197, 173),
                blurRadius: 15.0,
              ),
            ],
          ),
          // here the desired height
          child: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: Text(
              "Post Detail",
              style: GoogleFonts.poppins(
                color: Color.fromRGBO(57, 79, 74, 50),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: DetailsWidget(
            postTitle: 'What kind of soil should I use for my plant?',
            // postSummary: 'Creating beautiful UIs with Flutter!',
            postBody:
                'What types of soil do you guys use for your indoor plants? I’ve been using miracle grow indoor but it seems to not do well with majority of my plants. I have more than just these but I can’t find pics. Any tips on mixing soils or types to try is appreciated! Thanks!',

            authorName: 'John Doe',
            authorProfileImage:
                'https://upload.wikimedia.org/wikipedia/commons/5/50/User_icon-cp.svg',
            postDate: DateTime.now(),
          ),
        ),
      ),
    );
  }
}
