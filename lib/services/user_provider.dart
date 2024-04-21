import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void login(String username, String userId, String token) {
    _user = User(username: username, userId: userId, token: token);
    print("SLşÖSs");
    notifyListeners();
    print("samdlad");
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
