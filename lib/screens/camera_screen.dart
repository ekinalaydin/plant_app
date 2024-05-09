import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

// Import the DiseaseDetection screen
import 'disease_detection.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  final picker = ImagePicker();

  Future<void> uploadImage(String filePath, BuildContext context) async {
    var uri = Uri.parse('https://plant-f9a21.ey.r.appspot.com/plant/predict');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', filePath));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        List<dynamic> decodedList = jsonDecode(responseBody);
        List<Map<String, dynamic>> responseList =
            decodedList.cast<Map<String, dynamic>>();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully uploaded image.')),
        );

        // Navigate to DiseaseDetection screen
        if (responseList.isNotEmpty) {
          print(responseList);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiseaseDetection(data: responseList[0]),
              ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Image upload failed with status: ${response.statusCode}.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadImage(
            pickedFile.path, context); // Upload the image after it's selected
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No image selected from camera.')),
        );
      }
    });
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadImage(
            pickedFile.path, context); // Upload the image after it's selected
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No image selected from gallery.')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 84, 87, 81),
                blurRadius: 20.0,
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Color(0xFFDEF99B),
            title: Text(
              "Take a photo of your plant!",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xFF273E39),
              ),
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
                  color: Color(0xFF273E39),
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
            width: 80,
            height: 80,
            child: FloatingActionButton(
              heroTag: 'camera_fab',
              onPressed: getImageFromCamera,
              tooltip: 'Take a Photo',
              backgroundColor: Color(0xFF9BCA22),
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: 80,
            height: 80,
            child: FloatingActionButton(
              heroTag: 'gallery_fab',
              onPressed: getImageFromGallery,
              tooltip: 'Choose from Gallery',
              backgroundColor: Color(0xFF9BCA22),
              child: Icon(
                Icons.photo_library,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
