import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/login/sign_in_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(133, 192, 197, 173),
                  blurRadius: 15.0,
                ),
              ],
            ),
            child: AppBar(
              elevation: 0.8,
              backgroundColor: Colors.white,
              title: Text(
                "Profile",
                style: GoogleFonts.poppins(
                  color: Color.fromRGBO(57, 79, 74, 50),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: GoogleFonts.poppins(color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 39,
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                              hintText: "Ekin",
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
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Surname',
                          style: GoogleFonts.poppins(color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 39,
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                              hintText: "Alaydin",
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
                  ),
                ],
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change username',
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 39,
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
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change password',
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    height: 39,
                    width: double.infinity, // Take full available width
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      cursorHeight: 20,
                      decoration: InputDecoration(
                        // helperText: "Please enter old password",
                        hintText: "Please enter your old password",
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
              SizedBox(height: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New password',
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    height: 62,
                    width: double.infinity, // Take full available width
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      cursorHeight: 20,
                      decoration: InputDecoration(
                        helperText:
                            "Your password must be between 4 and 12 characters",
                        hintText: "Please enter new password",
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
              SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change your Location',
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    height: 39,
                    child: DropdownSearch<String>(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          hintText: 'City',
                          labelStyle: GoogleFonts.poppins(color: Colors.black),
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
                    style: GoogleFonts.poppins(color: Colors.black),
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
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    width: 180,
                    height: 60,
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
        ));
  }
}
