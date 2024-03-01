import 'package:flutter/material.dart';
import 'package:plant_app/screens/home_screen.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shadowColor: const Color.fromARGB(255, 133, 131, 131),
          color: const Color.fromARGB(255, 232, 236, 234),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  radius: 35,
                  child: ClipOval(
                    child: Image.asset(
                      "lib/assets/images/apple.jpeg",
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                title: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Apple Scab',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                subtitle: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '20/12/2023',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      debugPrint("Current context: $context");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Builder(
                            builder: (context) => HomeScreen(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
