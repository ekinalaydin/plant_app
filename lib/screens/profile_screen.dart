import 'package:flutter/material.dart';
import 'package:plant_app/screens/login/sign_in_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Renk değişebilir
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Log Out',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
