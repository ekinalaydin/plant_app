import 'package:flutter/material.dart';
import 'package:plant_app/widgets/community_posts.dart';
import 'package:plant_app/services/api_service.dart'; // Make sure to import your ApiService
import 'dart:convert' show utf8;

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  late Future<dynamic> postsFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PostPage());
  }
}
