import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:plant_app/helpers/screen_size_helper.dart';
import 'package:plant_app/services/user_provider.dart';
import 'package:plant_app/widgets/bottom_navigation.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSizeHelper.getScreenWidth(context);
    final double screenHeight = ScreenSizeHelper.getScreenHeight(context);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 8.0),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name*',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your surname';
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your e-mail';
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
                helperText: 'Your password must be between 4-12 characters.',
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
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                } else if (value.length < 4 || value.length > 12) {
                  return 'Your password must be between 4-12 characters';
                } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                  return 'Your password must include at least one uppercase letter';
                } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                  return 'Your password must include at least one number';
                } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
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
            ),
            SizedBox(height: 8.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Occupation',
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
              onSaved: (value) {
                _occupation = value;
              },
            ),
            SizedBox(height: 8.0),
            DropdownSearch<String>(
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: 'Gender',
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
            ),
            SizedBox(height: 12.0),
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
                      address: _city ?? '',
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2DDA53),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth / 24,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
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
    required String address,
    String? occupation,
    String? city,
  }) async {
    try {
      // Firebase kullanarak kullanıcı kaydı yapın
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kullanıcının oluşturulduğunu kontrol edin
      if (credential.user != null) {
        // UserProvider kullanarak uygulama genelinde kullanıcı bilgilerini kaydedin
        final userProvider = Provider.of<UserProvider>(context, listen: false);

        // Kayıttan sonra kullanıcıyı anasayfaya yönlendirin
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigation()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Burada bir hata mesajı göster
      String errorMessage = 'An error occurred. Please try again later.';
      if (e.code == 'email-already-in-use') {
        errorMessage =
            'The email address is already in use by another account.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else if (e.code == 'operation-not-allowed') {
        errorMessage = 'Email/password accounts are not enabled.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password is too weak.';
      }

      // Hata mesajını kullanıcıya göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
