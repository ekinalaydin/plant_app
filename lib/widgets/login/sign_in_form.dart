import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:plant_app/screens/login/forgot_password_screen.dart';
import 'package:plant_app/screens/login/sign_up_screen.dart';
import 'package:plant_app/helpers/screen_size_helper.dart';
import 'package:plant_app/widgets/bottom_navigation.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String? _emailOrUsername;
  String? _password;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSizeHelper.getScreenWidth(context);
    final double screenHeight = ScreenSizeHelper.getScreenHeight(context);

    return Scaffold(
      key: _formKey,
      body: SingleChildScrollView(
        child:  Center(
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
                          style: TextStyle(
                            fontSize: screenWidth / 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Let's Learn More About Plants",
                          style: TextStyle(
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
                  labelStyle: TextStyle(color: Colors.black),
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
                  _emailOrUsername = value;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password*',
                  helperText: 'Your password must be between 4-12 characters',
                  labelStyle: TextStyle(color: Colors.black),
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
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 4 || value.length > 12) {
                    return 'Your password must be between 4-12 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value;
                },
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                    fillColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Color(0xFF2DDA53); // Seçili durumda kutu rengi
                      }
                      return Colors.transparent; // Diğer durumlarda kutu rengi
                    }),
                  ),
                  Text('Remember me'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      );
                      // Forgot Password sayfasına yönlendirme yapılabilir veya başka işlemler gerçekleştirilebilir
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontSize: screenWidth / 30),
                    ),
                  ),
                ],
              ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavigation(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2DDA53),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Log In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth / 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(height: 16), // İsteğe bağlı boşluk ekleyebilirsiniz
                    RichText(
                      text: TextSpan(
                        text: "Don't you have an account? ",
                        style: TextStyle(
                            color: Colors.black, fontSize: screenWidth / 30),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyle(
                                color: Colors.green, fontSize: screenWidth / 30),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()),
                                );
                              },
                            // Buraya tıklandığında yapılacak işlemleri de ekleyebilirsiniz.
                          ),
                        ],
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

  void _processFormData() {
    // Process form data here
    print('E-mail or Username: $_emailOrUsername');
    print('Password: $_password');
    // Add your authentication logic here
  }
}
