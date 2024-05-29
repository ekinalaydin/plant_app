import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:plant_app/screens/login/sign_in_screen.dart';

import 'package:plant_app/screens/profile_screen.dart';
import 'package:plant_app/screens/user_history_screen.dart';
import 'package:plant_app/screens/user_favorites_screen.dart';
import 'package:plant_app/screens/user_posts.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/services/user_provider.dart';
import 'package:plant_app/services/weather_provider.dart';

import 'package:plant_app/themes/colors.dart';

import 'package:plant_app/widgets/user_options_card.dart';
import 'package:provider/provider.dart';

class UserOptionScreen extends StatefulWidget {
  @override
  State<UserOptionScreen> createState() => _UserOptionScreenState();
}

class _UserOptionScreenState extends State<UserOptionScreen> {
  late String? _name = "";

  late String? _surname = "";

  late String? _username = "";

  late String? _email = "";

  late String? _city = "";

  TextEditingController nameController = TextEditingController();

  TextEditingController surnameController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ApiService().getProfile(context).then((data) {
      setState(() {
        _name = data['name'];
        _surname = data['surname'];
        _username = data['username'];
        _email = data['email'];
        _city = data['city'];

        // Initialize the controllers with the retrieved data
        usernameController.text = _username ?? '';
        emailController.text = _email ?? '';
        cityController.text = _city ?? '';
      });
    }).catchError((error) {
      // Handle any errors that occur during the API call
      print('Error fetching profile data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.background,
        title: Text(
          'User Profile',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 23,
              color: AppColors.onSurface),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15, top: 35),
        child: ListView(
          padding: EdgeInsets.all(6.0),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                "Please Select an Option",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Color(0xFF2B826D),
                    fontWeight: FontWeight.w700),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                child: UserOptionsCard(
                  title: "My Profile Settings",
                  iconData: Icons.settings,
                )),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPost()),
                );
              },
              child: UserOptionsCard(
                title: "My Posts",
                iconData: Icons.question_mark_outlined,
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserFavoritesScreen()),
                  );
                },
                child: UserOptionsCard(
                  title: "My Favorite Posts",
                  iconData: Icons.favorite,
                )),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserCommentsScreen()),
                  );
                },
                child: UserOptionsCard(
                  title: "My History",
                  iconData: Icons.history,
                )),
            GestureDetector(
              onTap: () async {
                bool shouldLogout = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: AppColors.background,
                      title: Text(
                        'Confirm Logout',
                        style: GoogleFonts.poppins(color: AppColors.onSurface),
                      ),
                      content: Text(
                        'Are you sure you want to log out?',
                        style: TextStyle(color: AppColors.onSurface),
                      ),
                      actions: [
                        TextButton(
                          child: Text('No',
                              style: GoogleFonts.poppins(
                                  color: AppColors.primary)),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        TextButton(
                          child: Text('Yes',
                              style: GoogleFonts.poppins(
                                  color: AppColors.primary)),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    );
                  },
                );

                if (shouldLogout) {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Provider.of<UserProvider>(context, listen: false).logout();
                    Provider.of<WeatherProvider>(context, listen: false)
                        .reset();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  } catch (e) {
                    print('Error occurred while logging out: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                        'An error occurred while logging out',
                        style: GoogleFonts.poppins(color: Colors.red),
                      )),
                    );
                  }
                }
              },
              child: UserOptionsCard(
                title: "Log Out ",
                iconData: Icons.logout_sharp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
