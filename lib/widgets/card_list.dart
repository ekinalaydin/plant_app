import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/camera_screen.dart';
import 'package:plant_app/services/user_provider.dart';
import 'package:plant_app/services/weather_provider.dart';
// import 'package:plant_app/screens/home_screen.dart';
import 'package:plant_app/widgets/card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:plant_app/themes/colors.dart';

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.initCity(context);
      Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeather(userProvider.city!);
    });
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Selector<WeatherProvider, String?>(
                    selector: (_, provider) =>
                        provider.weatherData?['days'][0]['datetime'].toString(),
                    builder: (_, date, __) {
                      return buildWeatherRow(context, date);
                    }),
                Selector<WeatherProvider, Map<String, dynamic>?>(
                    selector: (_, provider) => provider.weatherData,
                    builder: (_, weatherData, __) {
                      return weatherData != null
                          ? buildWeatherInfo(context, weatherData)
                          : CircularProgressIndicator();
                    }),
                SizedBox(height: 20),
                buildHistorySection(),
                SizedBox(height: 20),
                buildPlantAssistanceSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWeatherRow(BuildContext context, String? dateString) {
    var date = dateString != null ? formatDate(dateString) : 'Loading date...';
    var weatherProvider = Provider.of<WeatherProvider>(context,
        listen: false); // Use listen: false here
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          date,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurface,
          ),
        ),
        SizedBox(width: 25),
        weatherProvider.weatherData != null
            ? Image.asset(
                'lib/assets/icons/${weatherProvider.weatherData!['days'][0]['icon']}.png', // Dynamic icon based on condition
              )
            : CircularProgressIndicator(),
      ],
    );
  }

  Widget buildWeatherInfo(
      BuildContext context, Map<String, dynamic> weatherData) {
    var temperature = "${weatherData['days'][0]['temp']}°C";
    var humidity = "${weatherData['days'][0]['humidity']}%";
    var solarEnergy = "${weatherData['days'][0]['solarenergy']}%";
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildWeatherInfoBox(temperature, Color(0xFFFFF9DC),
              Icons.thermostat_outlined, Color(0xFF914C1D)),
        ),
        SizedBox(width: 8),
        Expanded(
          child: _buildWeatherInfoBox(humidity, Color(0xFFF8F9F9),
              Icons.water_drop_outlined, Color(0xFF398C77)),
        ),
        SizedBox(width: 8),
        Expanded(
          child: _buildWeatherInfoBox(solarEnergy, Color(0xFFFEF0EF),
              Icons.wb_sunny_outlined, Color(0xFF992B2C)),
        ),
      ],
    );
  }

  Widget buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "History",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurface,
          ),
        ),
        SizedBox(height: 10),
        CardWidget(),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildPlantAssistanceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Plant Assistance",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurface,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraScreen(),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: AppColors.primary,
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
                          color: AppColors.onPrimary,
                        ),
                      ),
                      Text(
                        "Take a photo of your plant",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.health_and_safety,
                    color: AppColors.onPrimary,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherInfoBox(
      String data, Color bgColor, IconData icon, Color iconColor) {
    return Container(
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
    );
  }
}
