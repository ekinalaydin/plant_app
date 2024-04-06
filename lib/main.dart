import 'package:flutter/material.dart';
import 'package:plant_app/screens/login/sign_in_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Namer App',
      theme: ThemeData(
        scaffoldBackgroundColor:
            Colors.white, // Arka plan rengini buradan ayarlayabilirsiniz
        useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black, // Cursor rengini burada ayarlayın
        ),
      ),
      home: SignInScreen(),
    );
  }
}
