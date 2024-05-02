import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/helpers/screen_size_helper.dart';
import 'package:plant_app/themes/colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  String _emailOrUsername = '';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSizeHelper.getScreenWidth(context);
    final double screenHeight = ScreenSizeHelper.getScreenHeight(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 32.0),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: <Widget>[
                    // Logo
                    Container(
                      margin: EdgeInsets.only(right: 12.0),
                      child: Image.asset(
                        'lib/assets/images/logo1.png', // Logo dosya yolu buraya
                        width: 80, // Logo genişliği
                        height: 80, // Logo yüksekliği
                      ),
                    ),
                    // Hoşgeldiniz Metni
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello',
                          style: GoogleFonts.poppins(
                            color: AppColors.onSurface,
                            fontSize: screenWidth / 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Let's Learn More About Plants",
                          style: GoogleFonts.poppins(
                            color: AppColors.onSurface,
                            fontSize: screenWidth / 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail or Username*',
                  labelStyle: GoogleFonts.poppins(color: AppColors.onSurface),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                ),
                cursorColor: Colors.black, // İmleç rengi burada ayarlanıyor

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your e-mail or username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _emailOrUsername = value ?? '';
                },
              ),
              SizedBox(height: 8.0),
              SizedBox(height: 8.0),
              SizedBox(height: 8.0),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: screenWidth / 1.5,
                      height: screenHeight / 20,
                      child: ElevatedButton(
                        onPressed: () {
                          print("Reset password");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryVariant,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Reset password',
                          style: GoogleFonts.poppins(
                              color: AppColors.onPrimary,
                              fontSize: screenWidth / 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
