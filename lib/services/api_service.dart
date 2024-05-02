import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/services/user_provider.dart';
import 'package:provider/provider.dart';

class ApiService {
<<<<<<< HEAD
<<<<<<< Updated upstream
  static String baseUrl = 'https://plant-app-f6e01.uc.r.appspot.com/';
=======
  static String baseUrl = 'https://plant-f9a21.ey.r.appspot.com';
>>>>>>> Stashed changes
=======
  static String baseUrl = 'https://plantapp-2ee83.ew.r.appspot.com';
>>>>>>> origin/ekin

  // GET ALL POSTS
  Future<Map<String, dynamic>> getAllPosts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.user?.userId;
    print(userId);
    final response =
        await http.get(Uri.parse('$baseUrl/community/?userId=$userId'));
    if (response.statusCode == 200) {
      var decodedJson = json.decode(utf8.decode(response.bodyBytes));
      return decodedJson['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  // GET POST BY ID
  Future<Map<String, dynamic>> getPostById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/community/$id'));
    if (response.statusCode == 200) {
      var decodedJson = json.decode(utf8.decode(response.bodyBytes));
      return decodedJson['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  // LIKE POST
  Future<void> likePost(int id, BuildContext context) async {
    // Retrieve the userProvider using the context provided
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final response = await http.post(
      Uri.parse('$baseUrl/community/$id/likes'),
      headers: {
        'Authorization':
            'Bearer $token', // Include the auth token in the header
      },
    );

    if (response.statusCode != 204) {
      throw Exception(
          'Failed to load data with status code: ${response.statusCode}');
    }
  }
}
