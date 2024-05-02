import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/themes/colors.dart';

class CameraScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  final picker = ImagePicker();

  Future<dynamic> uploadImage(String filePath, BuildContext context) async {
    var uri = Uri.parse('https://plant-f9a21.ey.r.appspot.com/plant/predict');
    var request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath('image', filePath));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        // Decode response if the status is successful
        var responseBody = await response.stream.bytesToString();
        List<dynamic> decodedList = jsonDecode(responseBody);
        List<Map<String, dynamic>> responseList =
            decodedList.cast<Map<String, dynamic>>();

        // Display success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully uploaded image.')),
        );

        // Optionally handle multiple results here
        for (var item in responseList) {
          showInformationModal(context, item['label']);
        }
      } else {
        // Handle non-200 status codes
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Image upload failed with status: ${response.statusCode}.')),
        );
      }
    } catch (e) {
      // Handle errors like network issues
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void showInformationModal(BuildContext context, String label) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Plant Diagnosis'),
          content: Text(label),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          SnackBar(
            content: Text(
              'No image selected from camera.',
              style: GoogleFonts.poppins(color: AppColors.onSurface),
            ),
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
        uploadImage(
            pickedFile.path, context); // Upload the image after it's selected
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'No image selected from gallery.',
              style: GoogleFonts.poppins(color: AppColors.onSurface),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(79.0), // here the desired height
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.secondaryVariant,
                blurRadius: 20.0,
              ),
            ],
          ), // Adjust t
          child: AppBar(
            backgroundColor: AppColors.primaryVariant,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Take a photo of your plant! ",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
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
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              )
            : FutureBuilder(
                future: uploadImage(_image!.path, context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show CircularProgressIndicator while waiting
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data.length > 0) {
                    // Handle successful result
                    var label = snapshot.data[0]['label'];
                    showInformationModal(context, label);
                    return Image.file(
                      _image!,
                      width: 500,
                      height: 500,
                    );
                  } else {
                    return Text(
                        'No data available'); // Handle case where data is null or empty
                  }
                },
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
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.camera_alt_outlined,
                color: AppColors.onPrimary,
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
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.photo_library,
                color: AppColors.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
