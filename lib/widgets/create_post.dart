import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  File? _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>(); // Define form key
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50.0, 100, 50, 50),
        child: Container(
          width: 350, // Adjust width as needed
          height: 400, // Adjust height as needed
          color: const Color.fromARGB(255, 199, 199, 199),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "What is your question?",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Icon(Icons.clear),
                      hintText: 'Ask to Community!',
                      hintStyle: GoogleFonts.poppins(),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Description",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ), // Adjust spacing between text fields
                  SizedBox(
                    width: 240, // <-- TextField width
                    height: 120, // <-- TextField height
                    child: TextFormField(
                      controller: _descriptionController,
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.clear),
                        hintText: 'Give More Detail!',
                        hintStyle: GoogleFonts.poppins(fontSize: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ), // Adjust spacing between text fields and camera icon
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        _selectImage(context);
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Submit form functionality
                          if (_formKey.currentState!.validate()) {
                            // Do something with the form data
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Form submitted!'),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Submit',
                          style: GoogleFonts.poppins(color: Colors.green),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Clear form fields functionality
                          _descriptionController.clear();
                        },
                        child: Text(
                          'Clear',
                          style: GoogleFonts.poppins(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to select image
  void _selectImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No image selected from gallery.'),
          ),
        );
      }
    });
  }
}
