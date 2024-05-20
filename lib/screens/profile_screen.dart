import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/user_posts.dart';
import 'package:plant_app/services/api_service.dart';

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
  String? initialOccupationValue; // API'den gelen ilk değeri tutacak değişken

  // late String? _oldPassword = ""; // Define _oldPassword variable here
  // late String? _newPassword = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final TextStyle buttonTextStyle = GoogleFonts.poppins(
      color: Color.fromRGBO(34, 58, 51, 40), fontWeight: FontWeight.bold);

  bool _isNameSurnameFieldTouched =
      false; // Flag to track whether the field is touched

  String? validateFullName(String? value) {
    if (_isNameSurnameFieldTouched) {
      // Validation logic only executed if the field is touched
      List<String> parts = value?.trim().split(' ') ?? [];
      if (parts.length < 2) {
        return 'Please enter both name and surname';
      }
      String name = parts[0];
      String surname = parts.sublist(1).join(' ');

      // Check if name and surname are empty
      if (name.isEmpty || surname.isEmpty) {
        return 'Both name and surname are required';
      }

      // Check if the new name and surname are the same as the existing values
      // if (_name != null &&
      //     _surname != null &&
      //     name == _name &&
      //     surname == _surname) {
      //   return 'The new name is the same as the current one';
      // }
    }
    return null; // Return null if validation passes or if the field hasn't been touched
  }

  bool _isEmailFieldTouched = false;
  String? validateEmail(String? value) {
    if (_isEmailFieldTouched) {
      // Validation logic only executed if the field is touched
      if (value == null || value.isEmpty) {
        return 'Please enter your new e-mail address';
      }
      // Check for valid email format
      if (!_isValidEmail(value)) {
        return 'Please enter a valid e-mail address';
      }
    }
    return null; // Return null if validation passes or if the field hasn't been touched
  }

  bool _isValidEmail(String value) {
    // Simple email validation using a regular expression
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  bool _isUsernameFieldTouched = false;
  String? validateUsername(String? value) {
    if (_isUsernameFieldTouched) {
      // Validation logic only executed if the field is touched
      // You can add specific validation rules here if needed
      // For now, we return null to indicate no error
      return null;
    }
    return null; // Return null if validation passes or if the field hasn't been touched
  }

  bool _isOldPasswordFieldTouched = false;
  String? _oldPassword;

  bool _isNewPasswordFieldTouched = false;
  String? _newPassword;

  String? validateOldPassword(String? value) {
    if (_isOldPasswordFieldTouched) {
      // Validation logic only executed if the field is touched
      if (value == null || value.isEmpty) {
        return 'Please enter your old password';
      }
    }
    return null; // Return null if validation passes or if the field hasn't been touched
  }

  String? validateNewPassword(String? value) {
    if (_isNewPasswordFieldTouched) {
      // Validation logic only executed if the field is touched
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
      } else if (_oldPassword != null && _oldPassword == value) {
        return 'New password cannot be the same as old password';
      }
    }
    return null; // Return null if validation passes or if the field hasn't been touched
  }

  @override
  void initState() {
    super.initState();

    ApiService().getProfile(context).then((data) {
      setState(() {
        _username = data['username'];
        _email = data['email'];
        _city = data['city'];
        _occupation = data['occupation'];
        _gender = data['gender'];
        _name = data['name'];
        _surname = data['surname'];
        _oldPassword = data['password'];

        // Initialize the controllers with the retrieved data
        oldPasswordController.text = _oldPassword ?? '';
        usernameController.text = _username ?? '';
        emailController.text = _email ?? '';
        cityController.text = _city ?? '';
        occupationController.text = _occupation ?? '';
        genderController.text = _gender ?? '';
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
        backgroundColor: Colors.white,
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
                radius: 30,
                backgroundColor: Color.fromARGB(255, 201, 224, 109),
                // backgroundImage: NetworkImage(""),
              ),
              title: Row(
                children: [
                  Text(
                    "$_name "
                    "$_surname ",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
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
                padding: const EdgeInsets.only(top: 1.0, left: 10, right: 10),
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
                                    'Full Name',
                                    style: GoogleFonts.poppins(
                                        color: Color.fromRGBO(34, 58, 51, 40),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(height: 4),
                                  SizedBox(
                                      height: 65,
                                      child: TextFormField(
                                          textAlign: TextAlign.start,
                                          cursorHeight: 20,
                                          decoration: InputDecoration(
                                            hintText: "$_name $_surname",
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
                                              validateFullName, // Assign the validator function here
                                          controller: nameController,
                                          onChanged: (_) {
                                            // Set the flag to true when the user interacts with the field
                                            setState(() {
                                              _isNameSurnameFieldTouched = true;
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
                            width: double.infinity, // Take full available width
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                hintText: _email ??
                                    '', // Use the existing email as hint
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
                              validator:
                                  validateEmail, // Assign the validator function here
                              onChanged: (_) {
                                // Set the flag to true when the user interacts with the field
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
                            width: double.infinity, // Take full available width
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                hintText: _username ??
                                    '', // Use the existing username as hint
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
                              validator:
                                  validateUsername, // Assign the validator function here
                              onChanged: (_) {
                                // Set the flag to true when the user interacts with the field
                                setState(() {
                                  _isUsernameFieldTouched = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Change Password',
                            style: GoogleFonts.poppins(
                              color: Color.fromRGBO(34, 58, 51, 40),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Please enter your old password",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 50,
                            width: double.infinity, // Take full available width
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              cursorHeight: 20,
                              decoration: InputDecoration(
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
                                  _isOldPasswordFieldTouched = true;
                                  _oldPassword = value;
                                });
                              },
                              validator: validateOldPassword,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
// New Password Column with validation
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Password',
                            style: GoogleFonts.poppins(
                              color: Color.fromRGBO(34, 58, 51, 40),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 100,
                            width: double.infinity, // Take full available width
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
                                  _newPassword = value;
                                });
                              },
                              validator: validateNewPassword,
                            ),
                          ),
                        ],
                      ),
// Error message if old and new passwords are the same
                      if (_oldPassword != null &&
                          _newPassword != null &&
                          _oldPassword == _newPassword)
                        Text(
                          'New password cannot be the same as old password',
                          style: TextStyle(color: Colors.red),
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
                            width: double.infinity, // Take full available width
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                hintText: "$_occupation",
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
                              onChanged: (value) {
                                // Kullanıcı bir şeyler yazmaya başladığında initialOccupationValue'yi null yapabiliriz
                                initialOccupationValue = null;
                              },
                              initialValue: initialOccupationValue,
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
                            width: 200,
                            height: 60,
                            child: DropdownSearch<String>(
                              dropdownDecoratorProps: DropDownDecoratorProps(
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
                                });
                              },
                              selectedItem: _gender,
                              validator: (
                                String? value,
                              ) {
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
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 160,
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 201, 224, 109),
          onPressed: () {
            String oldPassword = oldPasswordController.text;
            String newPassword = newPasswordController.text;
            if (_formKey.currentState!.validate()) {
              // Do something with the form data
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Your Changes are Saved!'),
                ),
              );
            }
          },
          child: Text(
            "Save Changes",
            style: GoogleFonts.poppins(
                color: Color.fromRGBO(34, 58, 51, 40),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
