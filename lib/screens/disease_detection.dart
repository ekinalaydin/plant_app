import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/widgets/text_detail_page.dart';

class DiseaseDetection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // here the desired height
        child: AppBar(
          elevation: 0.8,
          title: Text(
            'Apple Scab',
            style: GoogleFonts.poppins(
                color: Color.fromARGB(255, 201, 224, 109),
                fontWeight: FontWeight.w500),
          ),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "lib/assets/images/apple.jpeg",
              width: MediaQuery.of(context)
                  .size
                  .width, // Resmin yatay boyutunu ekran genişliği kadar yapar
              fit: BoxFit.fitWidth,
              height: 150,
            ),
            TextSection(
              title: 'SYMPTOMS',
              content:
                  'Apple scab infections are initiated in early spring on emerging and young leaves.Early lesions appear 10 days later as lighter green areas compared to the surrounding leaf tissue. Lesions increase in size and become olive-colored and velvety as a result of asexual spore production (conidia).',
            ),
            TextSection(
              title: 'CULTURAL TREATMENT',
              content:
                  'Sanitation: Remove fallen leaves from the orchard in the fall. Rake up and destroy any diseased fruit.',
            ),
            TextSection(
              title: 'CHEMICAL TREATMENT',
              content:
                  'Common types of fungicides used for apple scab: Dithianes: Mancozeb, metiram Demethylation inhibitors (DMIs): Difenoconazole,  myclobutanil, penconazole Fungicides must be used strictly according to the instructions on the label. Fungicides should be applied evenly to all plant  surfaces. Fungicides should be applied before rain.',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 87, 173, 243),
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 255, 255, 255),
                        )),
                    onPressed: () {},
                    child: Text('Read More'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Resmi yatay boyutu kadar sığacak şekilde ayarlar
    );
  }
}
