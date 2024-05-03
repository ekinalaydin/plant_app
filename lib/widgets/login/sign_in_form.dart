import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/login/forgot_password_screen.dart';
import 'package:plant_app/screens/login/sign_up_screen.dart';
import 'package:plant_app/helpers/screen_size_helper.dart';
import 'package:plant_app/services/user_provider.dart';
import 'package:plant_app/themes/colors.dart';
import 'package:plant_app/widgets/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String _emailOrUsername = '';
  String _password = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    // _loadUserEmailAndPassword();
  }

  // Future<void> _loadUserEmailAndPassword() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (prefs.getBool('rememberMe') ?? false) {
  //     _emailController.text = prefs.getString('email') ?? '';
  //     _passwordController.text = prefs.getString('password') ?? '';
  //     _rememberMe = true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSizeHelper.getScreenWidth(context);
    final double screenHeight = ScreenSizeHelper.getScreenHeight(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      key: _formKey,
      body: SingleChildScrollView(
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
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail or Username*',
                  labelStyle: GoogleFonts.poppins(
                    color: AppColors.onSurface,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: AppColors.onSurface,
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: AppColors.onError,
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
                onChanged: (value) {
                  _emailOrUsername = value ?? '';
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password*',
                  helperText: 'Your password must be between 4-12 characters',
                  labelStyle: GoogleFonts.poppins(
                    color: AppColors.onSurface,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: AppColors.onSurface,
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: AppColors.onError,
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
                onChanged: (value) {
                  _password = value ?? '';
                },
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                    fillColor:
                        MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppColors.primary; // Seçili durumda kutu rengi
                      }
                      return Colors.transparent; // Diğer durumlarda kutu rengi
                    }),
                  ),
                  Text(
                    'Remember me',
                    style: GoogleFonts.poppins(
                      color: AppColors.onSurface,
                    ),
                  ),
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
                      style: GoogleFonts.poppins(
                          color: AppColors.onSurface,
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
                        onPressed: () async {
                          await _processFormData(_emailOrUsername, _password);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Log In',
                          style: GoogleFonts.poppins(
                              color: AppColors.onPrimary,
                              fontSize: screenWidth / 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 16), // İsteğe bağlı boşluk ekleyebilirsiniz
                    RichText(
                      text: TextSpan(
                        text: "Don't you have an account? ",
                        style: GoogleFonts.poppins(
                            color: AppColors.onSurface,
                            fontSize: screenWidth / 30),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: screenWidth / 30),
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

  Future<void> _processFormData(String email, String password) async {
    try {
      // FirebaseAuth kullanarak kullanıcı girişi yap
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Eğer kullanıcı bilgisi null değilse ve kullanıcı "Beni Hatırla" işlevini seçtiyse
      if (credential.user != null) {
        // UserProvider'ı kullanarak kullanıcı bilgilerini kaydetme
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        String? token =
            await credential.user!.getIdToken(); // Token alınır ve beklenir
        userProvider.login(
          credential.user!.displayName ?? '',
          credential.user!.uid,
          token ?? '',
        );
        // Kullanıcı girişi başarılı olduktan sonra ana sayfaya yönlendir
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavigation()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // FirebaseAuth'tan gelen hataları işle
      String errorMessage = 'An error occurred. Please try again later.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
      // Kullanıcıya hata mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
