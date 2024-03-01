import 'package:flutter/material.dart';
import 'package:plant_app/screens/home_screen.dart';
import 'package:plant_app/widgets/card.dart';

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      },
                      child: Card(
                        color: const Color.fromARGB(255, 232, 236, 234),
                        child: SizedBox(
                          width: 150,
                          height: 120,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(20),
                            leading: const Icon(Icons.healing_sharp),
                            title: Text(
                              "Health Check",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Card(
                      shadowColor: const Color.fromARGB(255, 133, 131, 131),
                      color: const Color.fromARGB(255, 232, 236, 234),
                      child: SizedBox(
                        width: 150,
                        height: 120,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          leading: const Icon(Icons.cloud_circle),
                          title: Text(
                            "Weather",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                "Your Previous Diseases",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Adding multiple instances of CardWidget
              CardWidget(),
              CardWidget(),
              CardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
