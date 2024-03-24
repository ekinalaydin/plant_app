import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  final picker = ImagePicker();

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No image selected from camera.'),
          ),
        );
      }
    });
  }

  Future<void> getImageFromGallery() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0), // here the desired height
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 84, 87, 81),
                blurRadius: 20.0,
              ),
            ],
          ), // Adjust t
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 224, 228, 208),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Take a photo of your plant! ",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color.fromRGBO(108, 124, 117, 0.857),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: _image == null
            ? Text(
                "No image selected. Please select an image.",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(108, 124, 117, 0.857),
                ),
              )
            : Image.file(
                _image!,
                width: 500,
                height: 500,
              ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: 80, // Specify the desired width
            height: 80,
            child: FloatingActionButton(
              heroTag: 'camera_fab',
              onPressed: getImageFromCamera,
              tooltip: 'Take a Photo',
              backgroundColor: Color.fromARGB(178, 193, 242, 155),
              child: Icon(
                Icons.camera,
                color: Colors.green,
              ),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: 80, // Specify the desired width
            height: 80,
            child: FloatingActionButton(
              heroTag: 'gallery_fab',
              onPressed: getImageFromGallery,
              tooltip: 'Choose from Gallery',
              backgroundColor: Color.fromARGB(178, 193, 242, 155),
              child: Icon(
                Icons.photo_library,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
