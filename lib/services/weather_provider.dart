import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier {
  var _weatherData;

  get weatherData => _weatherData;
  Future<void> fetchWeather() async {
    var url = Uri.parse(
        'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/ankara?unitGroup=metric&key=YOUR_API_KEY&contentType=json');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        setWeatherData(json.decode(response.body));
      } else {
        print('Failed to load weather data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void setWeatherData(data) {
    _weatherData = data;
    notifyListeners();
  }
}
