import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
          SizedBox(height: 8.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Process form data here
                  _processFormData();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Sign Up'),
            ),
          ),
        ],
      ),
    );
  }

  void _processFormData() {
    // Process form data here
    print('Name: $_name');
    print('Surname: $_surname');
    print('Username: $_username');
    print('Email: $_email');
    print('Password: $_password');
    print('City: $_city');
    print('Occupation: $_occupation');
    print('Gender: $_gender');
  }
}
