import 'package:flutter/material.dart';
import 'package:plant_app/widgets/login/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SignInForm(),
      ),
    );
  }
}
