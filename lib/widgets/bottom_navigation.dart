import 'package:flutter/material.dart';
import 'package:plant_app/screens/camera_screen.dart';
import 'package:plant_app/screens/community_screen.dart';
import 'package:plant_app/screens/home_screen.dart';
import 'package:plant_app/screens/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedTab = 0;

  List<Widget> _pages = [
    HomeScreen(),
    CommunityScreen(),
    CameraScreen(),
    Center(
      child: Text("Contact"),
    ),
    ProfileScreen(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        fixedColor: const Color.fromARGB(255, 100, 189, 132),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) => _changeTab(index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded),
            label: 'Detect',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person_2), label: 'Profile'),
        ],
      ),
    );
  }
}
