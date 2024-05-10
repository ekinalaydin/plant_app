import 'package:flutter/material.dart';

class DiseaseDetection extends StatefulWidget {
  final Map<String, dynamic> data;

  // Constructor that accepts data as a parameter
  const DiseaseDetection({Key? key, required this.data}) : super(key: key);

  @override
  _DiseaseDetectionState createState() => _DiseaseDetectionState();
}

class _DiseaseDetectionState extends State<DiseaseDetection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF2EA),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                  child: Image.asset(
                    "lib/assets/images/apple.jpeg",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height *
                        0.4, // 40% of the screen height
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context)
                      .padding
                      .top, // Adjust for the status bar height
                  left: 15, // Added some left padding for the button
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFAACC96), // White color background
                      shape: BoxShape.circle, // Circular shape
                      boxShadow: [
                        // Optional: if you want to add a shadow to the button
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back,
                          color: Color(
                              0xFF233A38)), // Icon color changed to green for contrast
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Ensure this context has a Navigator ancestor
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(
                      8), // Padding for text inside the container
                  child: Text(
                    widget.data['label'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 13,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(8),
                      child: TextSection(
                        title: 'SYMPTOMS',
                        content: widget.data['description'],
                        titleStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C352F),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextSection(
                    title: 'CULTURAL TREATMENT',
                    content: 'The cultural treatment text goes here...',
                  ),
                  SizedBox(height: 16),
                  TextSection(
                    title: 'CHEMICAL TREATMENT',
                    content: 'The chemical treatment text goes here...',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Handle your onPressed action here
        },
        label: Text('Health Check'),
        icon: Icon(Icons.camera_alt),
        backgroundColor: Colors.green, // Use the color from your screenshot
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class TextSection extends StatelessWidget {
  final String title;
  final String content;
  final TextStyle? titleStyle; // Optional custom style for the title
  final TextStyle? contentStyle; // Optional custom style for the content

  const TextSection(
      {Key? key,
      required this.title,
      required this.content,
      this.titleStyle,
      this.contentStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ??
                TextStyle(
                  color: Color(0xFF1C352F),
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: contentStyle ??
                TextStyle(
                  color: Color(0xFF74857D),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
