import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/camera_screen.dart';
import 'package:plant_app/services/weather_provider.dart';
// import 'package:plant_app/screens/home_screen.dart';
import 'package:plant_app/widgets/card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false)
        .fetchWeather(); // Trigger the weather API call
  }

  String formatDate(String dateString) {
    // Parse the date string
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(dateString);
    // Format the date to 'Friday, April 5'
    String formattedDate = DateFormat('EEEE, MMMM d').format(parsedDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    var weatherProvider = Provider.of<WeatherProvider>(context);
    var weatherData = weatherProvider.weatherData;

    var date = weatherData != null
        ? formatDate(weatherData['days'][0]['datetime'].toString())
        : 'Loading date...';
    var temperature = weatherData != null
        ? "${weatherData['days'][0]['temp'].toString()}°C"
        : 'Loading...';
    var humidity = weatherData != null
        ? "${weatherData['days'][0]['humidity'].toString()}%"
        : 'Loading...';
    var solarEnergy = weatherData != null
        ? "${weatherData['days'][0]['solarenergy'].toString()}%"
        : 'Loading...';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    date, // Updated to display the date from the API
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2B423D),
                    ),
                  ),
                  SizedBox(width: 25),
                  weatherData != null
                      ? Image.asset(
                          'lib/assets/icons/${weatherData!['days'][0]['icon']}.png', // Dynamic icon based on condition
                        )
                      : CircularProgressIndicator(),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _buildWeatherInfoBox(temperature, Color(0xFFFFF9DC),
                        Icons.thermostat_outlined, Color(0xFF914C1D)),
                  ),
                  Expanded(
                    child: _buildWeatherInfoBox(humidity, Color(0xFFF8F9F9),
                        Icons.water_drop_outlined, Color(0xFF398C77)),
                  ),
                  Expanded(
                    child: _buildWeatherInfoBox(solarEnergy, Color(0xFFFEF0EF),
                        Icons.wb_sunny_outlined, Color(0xFF992B2C)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "History",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF273E39),
                    ),
                  ),
                  SizedBox(height: 10),
                  CardWidget(),
                  SizedBox(height: 10),
                  CardWidget(),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Plant Assistance",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF273E39),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push to Identifier screen
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFDEF99B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Identifier",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF2B423D),
                                    ),
                                  ),
                                  Text(
                                    "Tap to recognize a plant",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 76, 106, 99),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons
                                  .search, // You can choose an appropriate icon
                              color: Colors.green[800],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Spacing between buttons
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Builder(
                            builder: (context) => CameraScreen(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFF9BCA22),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Health Check",
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFFEFEFD),
                                  ),
                                ),
                                Text(
                                  "Take a photo of your plant",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color(0xFFFEFEFD),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.favorite,
                              color: Color(0xFFDF5172),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherInfoBox(
      String data, Color bgColor, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: bgColor, // Solid color applied here
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the row contents horizontally
          children: <Widget>[
            Icon(icon, color: iconColor, size: 20),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                data,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: iconColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
