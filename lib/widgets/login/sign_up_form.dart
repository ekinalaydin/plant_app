import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:plant_app/helpers/screen_size_helper.dart';
import 'package:plant_app/widgets/bottom_navigation.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

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
      final userAttributes = {
        AuthUserAttributeKey.email: email,
        AuthUserAttributeKey.address: address,
        AuthUserAttributeKey.gender: gender,
        AuthUserAttributeKey.familyName: familyName,
        AuthUserAttributeKey.nickname: nickname,
        AuthUserAttributeKey.name: name
      };
      final result = await Amplify.Auth.signUp(
        username: nickname,
        password: password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );
      await _handleSignUpResult(
          result, nickname); // Kullanıcı adını argüman olarak geçirin*/
    } on AuthException catch (e) {
      safePrint('Error signing up user: ${e.message}');
    }
  }

  Future<void> _handleSignUpResult(SignUpResult result, String username) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails,
            username); // Kullanıcı adını argüman olarak geçirin
        break;
      case AuthSignUpStep.done:
        safePrint('Sign up is complete');
        break;
    }
  }

  void _handleCodeDelivery(
      AuthCodeDeliveryDetails codeDeliveryDetails, String username) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.lightGreen[50],
          title: Text('Confirmation Code'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please enter the confirmation code:'),
              SizedBox(
                width: 450,
                child: VerificationCode(
                  keyboardType: TextInputType.number,
                  textStyle: TextStyle(fontSize: 20),
                  underlineColor: Colors.black,
                  length: 6,
                  onEditing: (bool value) {},
                  onCompleted: (String value) {
                    confirmUser(
                      username: username,
                      confirmationCode: value,
                      onResult: (title, message) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.lightGreen[50],
                              title: Text(
                                title,
                                style: TextStyle(
                                  color: Colors.green[800],
                                ),
                              ),
                              content: Text(
                                message,
                                style: TextStyle(
                                  color: Colors.green[600],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    if (title.toLowerCase() == "başarılı") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigation(),
                                        ),
                                      );
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.lightGreen[200],
                                  ),
                                  child: Text(
                                    'Tamam',
                                    style: TextStyle(
                                      color: Colors.green[900],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> confirmUser({
    required String username,
    required String confirmationCode,
    required Function(String title, String message)
        onResult, // Sonuç callback'i
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
      await _handleSignUpResult(result, username);

      // Onaylama başarılıysa callback'i çağır
      onResult('Başarılı', 'Kullanıcı başarıyla onaylandı.');
    } on AuthException catch (e) {
      // Hata mesajıyla callback'i çağır
      onResult('Hata', 'Kullanıcı onayı başarısız: ${e.message}');
    }
  }

  void safePrint(String message) {
    print(message);
  }
}
