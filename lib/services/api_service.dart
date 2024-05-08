import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/models/comment.dart';
import 'package:plant_app/services/user_provider.dart';
import 'package:provider/provider.dart';

class ApiService {
  static String baseUrl = 'https://plant-f9a21.ey.r.appspot.com';

  // GET ALL POSTS
  Future<Map<String, dynamic>> getAllPosts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.user?.userId;
    print(userId);
    final response =
        await http.get(Uri.parse('$baseUrl/posts/?userId=$userId'));
    print(('$baseUrl/posts/?userId=$userId'));
    if (response.statusCode == 200) {
      var decodedJson = json.decode(utf8.decode(response.bodyBytes));
      print(decodedJson);
      return decodedJson['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  // GET POST BY ID
  Future<Map<String, dynamic>> getPostById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$id'));

    if (response.statusCode == 200) {
      var decodedJson = json.decode(utf8.decode(response.bodyBytes));
      print(decodedJson);
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
      Uri.parse('$baseUrl/posts/$id/likes'),
      headers: {
        'Authorization':
            'Bearer $token', // Include the auth token in the header
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to load data with status code: ${response.statusCode}');
    }
  }

  // GET COMMENTS
  Future<List<Comment>> getComments(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$id/comments'));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      if (data != null && data['data']['content'] != null) {
        List<dynamic> commentsJson = data['data']['content'];
        return commentsJson
            .map<Comment>((json) => Comment.fromJson(json))
            .toList();
      } else {
        return <Comment>[]; // Return an empty list if there's no 'comments' key
      }
    } else {
      throw Exception('Failed to load comments');
    }
  }

  // POST COMMENT
  Future<void> postComment(int id, BuildContext context, String text) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final response = await http.post(
      Uri.parse('$baseUrl/posts/$id/comments'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'text': text}),
    );

    if (response.statusCode == 401) {
      throw Exception('Authentication failed. Please login again.');
    } else if (response.statusCode == 403) {
      throw Exception('You do not have permission to post comments.');
    } else if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception(
          'Failed to post comment with status code: ${response.statusCode}');
    }
  }

  // GET FAVORITES
  Future<Map<String, dynamic>> getFavorites(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    final response = await http.get(
      Uri.parse('$baseUrl/profile/likes'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var decodedJson = json.decode(utf8.decode(response.bodyBytes));
      print(decodedJson);
      return decodedJson['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  // GET MY POSTS
  Future<Map<String, dynamic>> getMyPosts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    print(token);
    final response = await http.get(
      Uri.parse('$baseUrl/profile/posts'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var decodedJson = json.decode(utf8.decode(response.bodyBytes));
      return decodedJson['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> getProfile(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    print(token);
    final response = await http.get(
      Uri.parse('$baseUrl/profile/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var decodedJson = json.decode(utf8.decode(response.bodyBytes));
      return decodedJson;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
