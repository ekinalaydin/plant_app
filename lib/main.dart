import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/screens/login/sign_in_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black, // Cursor rengini burada ayarlayın
        ),
      ),
      home: SignInScreen(),
    );
  }
}
