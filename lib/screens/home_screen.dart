import 'package:flutter/material.dart';
import 'package:plant_app/widgets/card_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CardList(), // SignUpForm widget'ını çağırın
      ),
    );
  }
}
