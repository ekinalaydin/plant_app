import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/themes/colors.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? authorProfileImage;
  late String? _name = "";
  late String? _surname = "";
  late String? _username = "";
  late String? _email = "";
  late String? _city = "";
  late String? _occupation = "";
  late String? _gender = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final TextStyle buttonTextStyle = GoogleFonts.poppins(
      color: Color.fromRGBO(34, 58, 51, 40), fontWeight: FontWeight.bold);

  bool _isNameFieldTouched = false;
  bool _isSurNameFieldTouched = false;
  bool _isEmailFieldTouched = false;
  bool _isUsernameFieldTouched = false;
  bool _isNewPasswordFieldTouched = false;
  bool _isConfirmPasswordFieldTouched = false;

  String? validateName(String? value) {
    if (_isNameFieldTouched) {
      if (value == null || value.isEmpty) {
        return 'Please enter your name';
      }
    }
    return null;
  }

  String? validateSurname(String? value) {
    if (_isSurNameFieldTouched) {
      if (value == null || value.isEmpty) {
        return 'Please enter your surname';
      }
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (_isEmailFieldTouched) {
      if (value == null || value.isEmpty) {
        return 'Please enter your new e-mail address';
      }
      if (!_isValidEmail(value)) {
        return 'Please enter a valid e-mail address';
      }
    }
    return null;
  }

  bool _isValidEmail(String value) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  String? validateUsername(String? value) {
    if (_isUsernameFieldTouched) {
      return null;
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (_isNewPasswordFieldTouched) {
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
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (_isConfirmPasswordFieldTouched) {
      if (value == null || value.isEmpty) {
        return 'Please confirm your password';
      } else if (value != newPasswordController.text) {
        return 'Passwords do not match';
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    ApiService().getProfile(context).then((data) {
      setState(() {
        authorProfileImage = 'lib/assets/images/default_pp.png';
        _username = data['username'];
        _email = data['email'];
        _city = data['city'];
        _occupation = data['occupation'];
        _gender = data['gender'];
        _name = data['name'];
        _surname = data['surname'];

        nameController.text = _name ?? '';
        surnameController.text = _surname ?? '';
        usernameController.text = _username ?? '';
        emailController.text = _email ?? '';
        cityController.text = _city ?? '';
        occupationController.text = _occupation ?? '';
        genderController.text = _gender ?? '';
      });
    }).catchError((error) {
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
          "Profile Settings",
          style: GoogleFonts.poppins(
              color: Color(0xFF2B423D), fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[])
                ],
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(right: 10, left: 20),
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                    authorProfileImage ?? 'lib/assets/images/default_pp.png'),
                radius: 30,
                backgroundColor: Color.fromARGB(255, 201, 224, 109),
              ),
              title: Row(
                children: [
                  Text(
                    "$_name $_surname",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color.fromRGBO(34, 58, 51, 50),
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                "$_username | $_email | $_occupation | $_city",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.8,
                  color: Color.fromRGBO(34, 58, 51, 50),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 1.0, left: 14, right: 14),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name',
                                    style: GoogleFonts.poppins(
                                        color: Color.fromRGBO(34, 58, 51, 40),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(height: 4),
                                  SizedBox(
                                      height: 65,
                                      child: TextFormField(
                                          style: GoogleFonts.poppins(),
                                          textAlign: TextAlign.start,
                                          cursorHeight: 20,
                                          decoration: InputDecoration(
                                            hintText: "$_name ",
                                            hintStyle: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0,
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.all(9),
                                          ),
                                          validator:
                                              validateName, // Assign the validator function here
                                          controller: nameController,
                                          onChanged: (_) {
                                            setState(() {
                                              _isNameFieldTouched = true;
                                            });
                                          })),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Surname',
                                    style: GoogleFonts.poppins(
                                        color: Color.fromRGBO(34, 58, 51, 40),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(height: 4),
                                  SizedBox(
                                      height: 65,
                                      child: TextFormField(
                                          style: GoogleFonts.poppins(),
                                          textAlign: TextAlign.start,
                                          cursorHeight: 20,
                                          decoration: InputDecoration(
                                            hintText: _surname ?? '',
                                            hintStyle: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0,
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.all(9),
                                          ),
                                          validator:
                                              validateSurname, // Assign the validator function here
                                          controller: surnameController,
                                          onChanged: (_) {
                                            setState(() {
                                              _isSurNameFieldTouched = true;
                                            });
                                          })),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Change e-mail address',
                            style: GoogleFonts.poppins(
                                color: Color.fromRGBO(34, 58, 51, 40),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: TextFormField(
                              style: GoogleFonts.poppins(),
                              textAlign: TextAlign.start,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                hintText: _email ?? '',
                                alignLabelWithHint: true,
                                hintStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                ),
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
                                contentPadding: EdgeInsets.all(9),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              validator: validateEmail,
                              controller: emailController,
                              onChanged: (_) {
                                setState(() {
                                  _isEmailFieldTouched = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Change username',
                            style: GoogleFonts.poppins(
                                color: Color.fromRGBO(34, 58, 51, 40),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: TextFormField(
                              style: GoogleFonts.poppins(),
                              textAlign: TextAlign.start,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                hintText: _username ?? '',
                                alignLabelWithHint: true,
                                hintStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                ),
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
                                contentPadding: EdgeInsets.all(9),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              validator: validateUsername,
                              controller: usernameController,
                              onChanged: (_) {
                                setState(() {
                                  _isUsernameFieldTouched = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Password',
                            style: GoogleFonts.poppins(
                              color: Color.fromRGBO(34, 58, 51, 40),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                helperText:
                                    "Your password must be between 4 and 12 characters",
                                helperStyle: GoogleFonts.poppins(),
                                hintText: "Please enter a new password",
                                alignLabelWithHint: true,
                                hintStyle: GoogleFonts.poppins(),
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
                                contentPadding: EdgeInsets.all(8),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _isNewPasswordFieldTouched = true;
                                });
                              },
                              validator: validateNewPassword,
                              controller: newPasswordController,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Re-enter New Password',
                            style: GoogleFonts.poppins(
                              color: Color.fromRGBO(34, 58, 51, 40),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                hintText: "Please re-enter your new password",
                                alignLabelWithHint: true,
                                hintStyle: GoogleFonts.poppins(),
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
                                contentPadding: EdgeInsets.all(9),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _isConfirmPasswordFieldTouched = true;
                                });
                              },
                              validator: validateConfirmPassword,
                              controller: confirmPasswordController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Change your Location',
                            style: GoogleFonts.poppins(
                                color: Color.fromRGBO(34, 58, 51, 40),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 60,
                            child: DropdownSearch<String>(
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                baseStyle: GoogleFonts.poppins(),
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: '$_city',
                                  labelStyle:
                                      GoogleFonts.poppins(color: Colors.black),
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
                                  contentPadding: EdgeInsets.all(9),
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
                                  cityController.text = value ?? '';
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
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Change your occupation',
                            style: GoogleFonts.poppins(
                                color: Color.fromRGBO(34, 58, 51, 40),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: TextFormField(
                              style: GoogleFonts.poppins(),
                              textAlign: TextAlign.start,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                hintText: _occupation ?? '',
                                alignLabelWithHint: true,
                                hintStyle: GoogleFonts.poppins(),
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
                                contentPadding: EdgeInsets.all(9),
                              ),
                              controller: occupationController,
                              onChanged: (value) {
                                setState(() {
                                  _occupation = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender',
                            style: GoogleFonts.poppins(
                                color: Color.fromRGBO(34, 58, 51, 40),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 60,
                            child: DropdownSearch<String>(
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                baseStyle: GoogleFonts.poppins(),
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: 'Gender',
                                  hintStyle: GoogleFonts.poppins(),
                                  labelStyle:
                                      GoogleFonts.poppins(color: Colors.black),
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
                                'Female',
                                'Male',
                                'Prefer not to',
                              ],
                              onChanged: (String? value) {
                                setState(() {
                                  _gender = value;
                                  genderController.text = value ?? '';
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 60,
              width: 160,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await ApiService().updateProfile(
                        context,
                        nameController.text,
                        surnameController.text,
                        emailController.text,
                        usernameController.text,
                        newPasswordController.text,
                        cityController.text,
                        occupationController.text,
                        genderController.text,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Your Changes are Saved!',
                            style: GoogleFonts.poppins(color: Colors.green),
                          ),
                        ),
                      );
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Failed to save changes: $error',
                            style: GoogleFonts.poppins(color: Colors.red),
                          ),
                        ),
                      );
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primaryVariant),
                ),
                child: Text(
                  "Save Changes",
                  style: GoogleFonts.poppins(
                      color: AppColors.onSurface, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
