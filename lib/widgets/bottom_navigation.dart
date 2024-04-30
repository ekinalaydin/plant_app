import 'package:flutter/material.dart';
import 'package:plant_app/screens/camera_screen.dart';
import 'package:plant_app/screens/community_screen.dart';
import 'package:plant_app/screens/create_post_screen.dart';
import 'package:plant_app/screens/home_screen.dart';
import 'package:plant_app/screens/profile_screen.dart';
import 'package:plant_app/screens/map_screen.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedTab = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    CommunityScreen(),
    CameraScreen(),
    MapScreen(),
    ProfileScreen(),
  ];

  void _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  void _onCameraButtonPressed() {
    if (_selectedTab == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreatePostScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        selectedItemColor: Color(
            0xFF2B423D), // fixedColor is deprecated, use selectedItemColor
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _changeTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => _onCameraButtonPressed(),
              borderRadius: BorderRadius.circular(24),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF87BB17), // Inner color
                      Color(0xFFB4DC30), // Outer color
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _selectedTab == 1 ? Icons.add : Icons.camera,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
