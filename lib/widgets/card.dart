import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/disease_detection.dart';
import 'package:plant_app/themes/colors.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:intl/intl.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<dynamic>>(
        future: ApiService().getMyHistory(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final List<dynamic> history = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: history.map((historyData) {
                  final String date = DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(historyData['dateTime']));
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DiseaseDetection(
                              data: historyData['responses'][0],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: Color(0xFFF8F9F9),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFFE3E9E9),
                            radius: 30,
                            backgroundImage:
                                NetworkImage(historyData['imageUrl']),
                          ),
                          title: Text(
                            'Disease Name: ${historyData['responses'][0]['label']}',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.onSurface,
                            ),
                          ),
                          subtitle: Text(
                            'Date: $date',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: AppColors.onSurface,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.arrow_circle_right_outlined,
                              color: Color(0xFF2B826D),
                              size: 28,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DiseaseDetection(
                                    data: historyData['responses'][0],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          } else {
            return Text("No history available");
          }
        },
      ),
    );
  }
}
