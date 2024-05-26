import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/helpers/screen_size_helper.dart';
import 'package:plant_app/screens/login/sign_in_screen.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/services/user_provider.dart';
import 'package:plant_app/themes/colors.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _surname;
  String? _username;
  String? _email;
  String? _password;
  String? _city;
  String? _occupation;
  String? _gender;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSizeHelper.getScreenWidth(context);
    final double screenHeight = ScreenSizeHelper.getScreenHeight(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
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
                      Flexible(
                        child: Column(
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name*',
                            labelStyle:
                                GoogleFonts.poppins(color: AppColors.onSurface),
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
                            errorStyle: TextStyle(fontSize: 11),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: AppColors.onError,
                                width: 2.0,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            if (value.length < 2) {
                              return 'At least 2 characters ';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value;
                          },
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Surname*',
                            labelStyle:
                                GoogleFonts.poppins(color: AppColors.onSurface),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your surname';
                            }
                            if (value.length < 2) {
                              return 'At least 2 characters ';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _surname = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username*',
                    labelStyle: GoogleFonts.poppins(color: AppColors.onSurface),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    if (value.length < 3) {
                      return 'At least 3 characters ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value;
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'E-mail*',
                    labelStyle: GoogleFonts.poppins(color: AppColors.onSurface),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your e-mail';
                    }
                    // Regular expression for validating an email address
                    final emailRegExp =
                        RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Please enter a valid e-mail address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value;
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password*',
                    helperText:
                        'Your password must be between 4-12 characters.',
                    labelStyle: GoogleFonts.poppins(color: AppColors.onSurface),
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
                    errorStyle: TextStyle(fontSize: 11),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.onError,
                        width: 2.0,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 4 || value.length > 12) {
                      return 'Your password must be between 4-12 characters';
                    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return 'Your password must include at least one uppercase letter';
                    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return 'Your password must include at least one number';
                    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                        .hasMatch(value)) {
                      return 'Your password must include at least one symbol';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value;
                  },
                ),
                SizedBox(height: 8.0),
                DropdownSearch<String>(
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      hintText: 'City',
                      hintStyle:
                          GoogleFonts.poppins(color: AppColors.onSurface),
                      labelStyle:
                          GoogleFonts.poppins(color: AppColors.onSurface),
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
                  ),
                  items: [
                    "Adana",
                    "Adıyaman",
                    "Afyonkarahisar",
                    "Ağrı",
                    "Aksaray",
                    "Amasya",
                    "Ankara",
                    "Antalya",
                    "Ardahan",
                    "Artvin",
                    "Aydın",
                    "Balıkesir",
                    "Bartın",
                    "Batman",
                    "Bayburt",
                    "Bilecik",
                    "Bingöl",
                    "Bitlis",
                    "Bolu",
                    "Burdur",
                    "Bursa",
                    "Çanakkale",
                    "Çankırı",
                    "Çorum",
                    "Denizli",
                    "Diyarbakır",
                    "Düzce",
                    "Edirne",
                    "Elazığ",
                    "Erzincan",
                    "Erzurum",
                    "Eskişehir",
                    "Gaziantep",
                    "Giresun",
                    "Gümüşhane",
                    "Hakkari",
                    "Hatay",
                    "Iğdır",
                    "Isparta",
                    "İstanbul",
                    "İzmir",
                    "Kahramanmaraş",
                    "Karabük",
                    "Karaman",
                    "Kars",
                    "Kastamonu",
                    "Kayseri",
                    "Kırıkkale",
                    "Kırklareli",
                    "Kırşehir",
                    "Kilis",
                    "Kocaeli",
                    "Konya",
                    "Kütahya",
                    "Malatya",
                    "Manisa",
                    "Mardin",
                    "Mersin",
                    "Muğla",
                    "Muş",
                    "Nevşehir",
                    "Niğde",
                    "Ordu",
                    "Osmaniye",
                    "Rize",
                    "Sakarya",
                    "Samsun",
                    "Şanlıurfa",
                    "Siirt",
                    "Sinop",
                    "Şırnak",
                    "Sivas",
                    "Tekirdağ",
                    "Tokat",
                    "Trabzon",
                    "Tunceli",
                    "Uşak",
                    "Van",
                    "Yalova",
                    "Yozgat",
                    "Zonguldak"
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      _city = value;
                    });
                  },
                  selectedItem: _city,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your city';
                    }
                    return null;
                  },
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    fit: FlexFit.loose,
                    constraints: BoxConstraints(
                      maxHeight: 250,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Occupation*',
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
                        color: AppColors.onError,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onSaved: (value) {
                    _occupation = value;
                  },
                ),
                SizedBox(height: 8.0),
                DropdownSearch<String>(
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      hintText: 'Gender',
                      hintStyle:
                          GoogleFonts.poppins(color: AppColors.onSurface),
                      labelStyle:
                          GoogleFonts.poppins(color: AppColors.onSurface),
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
                  ),
                  items: ['Female', 'Male', 'Prefer not to'],
                  onChanged: (String? value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                  selectedItem: _gender,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                  popupProps: PopupProps.menu(
                    showSearchBox: false,
                    fit: FlexFit.loose,
                    constraints: BoxConstraints(
                      maxHeight: 150,
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                SizedBox(
                  width: screenWidth / 1.5,
                  height: screenHeight / 20,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        signUpUser(
                          name: _name ?? '',
                          familyName: _surname ?? '',
                          nickname: _username ?? '',
                          email: _email ?? '',
                          password: _password ?? '',
                          gender: _gender ?? '',
                          city: _city ?? '',
                          occupation: _occupation ?? '',
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                          color: AppColors.onPrimary,
                          fontSize: screenWidth / 24,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(height: 50.0), // Alt kısma daha fazla boşluk ekledik
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUpUser({
    required String name,
    required String familyName,
    required String nickname,
    required String email,
    required String password,
    required String gender,
    String? occupation,
    String? city,
  }) async {
    try {
      final credential = await ApiService().signUp(context, name, familyName,
          email, nickname, password, occupation, gender, city);

      // Kullanıcının oluşturulduğunu kontrol edin
      if (credential != null) {
        // Kullanıcı başarıyla oluşturuldu mesajı göster
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: Text(
                'Success',
                style: GoogleFonts.poppins(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                'User created successfully! Please sign in!',
                style: GoogleFonts.poppins(
                  color: AppColors.secondary,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'OK',
                    style: GoogleFonts.poppins(
                      color: AppColors.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // UserProvider kullanarak uygulama genelinde kullanıcı bilgilerini kaydedin
                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    // Kayıttan sonra kullanıcıyı giriş sayfasına yönlendirin
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                ),
              ],
            );
          },
        );
      }
    } on FormatException catch (e) {
      // Burada bir hata mesajı göster
      String errorMessage = 'An error occurred. Please try again later.';
      if (e.message == 'EMAIL_ALREADY_EXISTS') {
        errorMessage =
            'The email address is already in use by another account.';
      } else if (e.message == 'USERNAME_ALREADY_EXISTS') {
        errorMessage =
            'The username is already in use by another account.';
      }

      // Hata mesajını kullanıcıya göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
