import 'package:flutter/material.dart';
import 'package:plant_app/widgets/login/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(29.9),
        child: AppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SignUpForm(), // SignUpForm widget'ını çağırın
      ),
    );
  }
}
