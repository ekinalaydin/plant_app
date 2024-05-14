import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier {
  var _weatherData;

  get weatherData => _weatherData;
  Future<void> fetchWeather(String city) async {
    var url = Uri.parse(
        'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$city?unitGroup=metric&key=E2U5WK3EVD8L6GPJTTAZXGHRZ&contentType=json');

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
