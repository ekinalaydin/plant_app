import 'package:flutter/material.dart';
import 'package:plant_app/services/api_service.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;

  String? _city;
  String? get city => _city;

  set city(String? city) {
    if (city != null) {
      _city = city;
    }
  }

  void login(String username, String userId, String token) {
    _user = User(username: username, userId: userId, token: token);
    notifyListeners();
  }

  void logout() {
    _user = null;
    _city = null;
    notifyListeners();
  }

  Future<void> initCity(context) async {
    if (_city == null) {
      String city = await ApiService().getCity(context);
      _city = city;
    }
  }
}
