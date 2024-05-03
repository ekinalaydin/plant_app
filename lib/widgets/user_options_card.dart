import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/profile_screen.dart';
import 'package:plant_app/themes/colors.dart';

class UserOptionsCard extends StatelessWidget {
  final String title;
  final IconData iconData;
  UserOptionsCard({required this.title, required this.iconData});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shadowColor: AppColors.onSecondary,
        color: AppColors.primaryVariant,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.onSurface),
                ),
              ),
              Icon(
                iconData,
                color: Color(0xFF2B826D),
                size: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
