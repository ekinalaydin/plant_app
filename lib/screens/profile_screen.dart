import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/user_posts_comments.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _surname;
  String? _username;
  String? _email;
  String? _password;
  String? _city;
  String? _occupation;
  String? _gender;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final TextStyle buttonTextStyle = GoogleFonts.poppins(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF2EA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                children: [
                  ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 180,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor:
                                  (Color.fromRGBO(240, 241, 234, 1)),
                            ),
                            child: Text(
                              'User Profile',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          width: 190,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor:
                                  (Color.fromRGBO(240, 241, 234, 1)),
                            ),
                            child: Text(
                              'Posts and Comments',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CommentPostScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ])
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 1.0, left: 0, right: 0),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                                        fontSize: 14),
                                  ),
                                  SizedBox(height: 8),
                                  SizedBox(
                                    height: 34,
                                    child: TextFormField(
                                      textAlign: TextAlign.start,
                                      cursorHeight: 20,
                                      decoration: InputDecoration(
                                        hintText: "Ekin",
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Surname',
                                    style: GoogleFonts.poppins(
                                        color: Color.fromRGBO(34, 58, 51, 40),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  SizedBox(height: 8),
                                  SizedBox(
                                    height: 34,
                                    child: TextFormField(
                                      textAlign: TextAlign.start,
                                      cursorHeight: 20,
                                      decoration: InputDecoration(
                                        hintText: "Alaydin",
                                        alignLabelWithHint: true,
                                        hintStyle: GoogleFonts.poppins(),
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
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
                          SizedBox(height: 8),
                          SizedBox(
                            height: 49,
                            width: double.infinity, // Take full available width
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                hintText: "Please enter a new e-mail address",
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your new e-mail address';
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
                            'Change username',
                            style: GoogleFonts.poppins(
                                color: Color.fromRGBO(34, 58, 51, 40),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            height: 49,
                            width: double.infinity, // Take full available width
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                hintText: "Please enter a new username",
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your new username';
                                }
                                return null;
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
                                fontSize: 16),
                          ),
                          Text(
                            "Please enter your old password",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 49,
                            width: double.infinity, // Take full available width
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                // helperText: "Please enter old password",
                                // hintText: "Your old password",

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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Password',
                            style: GoogleFonts.poppins(
                                color: Color.fromRGBO(34, 58, 51, 40),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 65,
                            width: double.infinity, // Take full available width
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                helperText:
                                    "Your password must be between 4 and 12 characters",
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
                                contentPadding: EdgeInsets.all(9),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                } else if (value.length < 4 ||
                                    value.length > 12) {
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
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 14,
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
                            height: 59,
                            child: DropdownSearch<String>(
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: 'City',
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
                            height: 39,
                            width: double.infinity, // Take full available width
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                hintText: "Occupation",
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
                            width: 180,
                            height: 59,
                            child: DropdownSearch<String>(
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
            } else if (oldPassword.isEmpty || newPassword.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Please enter your old and new passwords',
                  ),
                ),
              );
            } else if (oldPassword == newPassword) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Your old and new password cannot be the same',
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Password changed successfully.',
                    style: GoogleFonts.poppins(
                      color: Color.fromRGBO(34, 58, 51, 40),
                    ),
                  ),
                ),
              );
              // You can add code here to actually change the password
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
