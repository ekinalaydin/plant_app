import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_app/screens/community_screen.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/themes/colors.dart';

class PostWidget extends StatefulWidget {
  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  File? image;
  bool _isLoading = false;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _askToCommunityController =
      TextEditingController();
  bool _photoSelected = false;
  bool _submitButtonClicked = false;

  bool _isImagePickerActive = false;

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _validateImage(File? image) {
    if (image == null) {
      return 'Please select an image';
    }
    return null;
  }

  void _submitPost() async {
    if (!_formKey.currentState!.validate() || _validateImage(image) != null) {
      setState(() {});
      return;
    }

    final title = _askToCommunityController.text.trim();
    final content = _descriptionController.text.trim();

    setState(() => _isLoading = true);

    try {
      await ApiService().postCommunity(context, title, content, image!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Your Question is Submitted!'),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommunityScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit post: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 60, 10, 30),
          child: Container(
            decoration: BoxDecoration(
              border: Border.symmetric(),
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryVariant],
                stops: [0.25, 0.75],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(220, 226, 201, 0.498),
                  spreadRadius: 10,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            width: 440,
            height: 550,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "What is your question?*",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      child: TextFormField(
                        controller: _askToCommunityController,
                        decoration: InputDecoration(
                          errorStyle: GoogleFonts.poppins(
                              color: AppColors.onError, fontSize: 12),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _askToCommunityController.clear();
                            },
                          ),
                          hintText: 'Ask to Community!',
                          hintStyle: GoogleFonts.poppins(
                            color: AppColors.onSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                                color: AppColors.secondaryVariant,
                                style: BorderStyle.solid),
                          ),
                        ),
                        validator: _validateField,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 4),
                        child: Text(
                          "Description*",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: _descriptionController,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          errorStyle: GoogleFonts.poppins(
                              color: AppColors.onError, fontSize: 12),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _descriptionController.clear();
                            },
                          ),
                          hintText: 'Give More Detail!',
                          hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: AppColors.onSecondary,
                          ),
                        ),
                        validator: _validateField,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40.0, right: 40, top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        width: 80,
                        height: 50,
                        child: Column(
                          children: [
                            TextButton.icon(
                              icon: Icon(
                                Icons.camera_alt_rounded,
                                color: AppColors.onSurface,
                              ),
                              onPressed: _photoSelected || _isImagePickerActive
                                  ? null
                                  : () => _selectImage(context),
                              label: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  children: [
                                    Text(
                                      _photoSelected
                                          ? "Photo is selected!"
                                          : "Add your photo!*",
                                      style: GoogleFonts.poppins(
                                        color: AppColors.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_submitButtonClicked &&
                        !_photoSelected &&
                        _validateImage(image) != null)
                      Center(
                        child: Text(
                          _validateImage(image)!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppColors.onError,
                          ),
                        ),
                      ),
                    if (_photoSelected)
                      TextButton.icon(
                        icon: Icon(
                          Icons.cancel,
                          color: AppColors.onSurface,
                        ),
                        onPressed: () {
                          setState(() {
                            image = null;
                            _photoSelected = false;
                          });
                        },
                        label: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            "Remove photo",
                            style: GoogleFonts.poppins(
                              color: AppColors.onSurface,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.delete_rounded,
                            color: Color(0xFF914C1D),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xFFFFF9DC),
                            ),
                          ),
                          onPressed: () {
                            _descriptionController.clear();
                            _askToCommunityController.clear();
                            setState(() {
                              image = null;
                              _photoSelected = false;
                            });
                          },
                          label: Text(
                            'Clear',
                            style:
                                GoogleFonts.poppins(color: Color(0xFF914C1D)),
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.send_rounded,
                            color: Color(0xFF914C1D),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFFFF9DC)),
                          ),
                          onPressed: () {
                            setState(() {
                              _submitButtonClicked = true;
                              if (_formKey.currentState!.validate()) {
                                _submitPost();
                              }
                            });
                          },
                          label: Text(
                            'Submit',
                            style:
                                GoogleFonts.poppins(color: Color(0xFF914C1D)),
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
      ),
    );
  }

  void _selectImage(BuildContext context) async {
    if (_isImagePickerActive) return;

    setState(() {
      _isImagePickerActive = true;
    });

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _isImagePickerActive = false;

      if (pickedFile != null) {
        image = File(pickedFile.path);
        _photoSelected = true;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Image successfully selected from gallery.')));
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
