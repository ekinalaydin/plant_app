import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/models/comment.dart';
import 'package:plant_app/services/user_provider.dart';
import 'package:provider/provider.dart';

class ApiService {
  static String baseUrl = 'https://plant-f9a21.ey.r.appspot.com';

  // SIGN UP USER
  Future<dynamic> signUp(
      BuildContext context,
      String name,
      String surname,
      String email,
      String username,
      String password,
      String? occupation,
      String gender,
      String? city) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'username': username,
        'password': password,
        'occupation': occupation,
        'gender': gender,
        'city': city,
        'name': name,
        'surname': surname
      }),
    );

    // Consider handling other successful status codes or using a range check
    if (response.statusCode < 200 || response.statusCode > 299) {
      print(response.body);
      throw Exception(
          'Failed to sign up with status code: ${response.statusCode}');
    }

    return response;
  }

  // GET ALL POSTS
  Future<Map<String, dynamic>> getAllPosts(
      BuildContext context, String? search) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final response = await http.get(
      Uri.parse('$baseUrl/posts/?search=${search ?? ''}'),
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

  // GET POST BY ID
  Future<Map<String, dynamic>> getPostById(BuildContext context, int id) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final response = await http.get(
      Uri.parse('$baseUrl/posts/$id'),
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

  // LIKE POST
  Future<Map<String, dynamic>> likePost(int id, BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (userProvider.user == null || userProvider.user!.token == null) {
      throw Exception('User is not logged in or token is missing');
    }

    final token = userProvider.user!.token!;

    final response = await http.post(
      Uri.parse('$baseUrl/posts/$id/likes'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // If the request is successful, return the updated liked post
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to like post');
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
    // Retrieve the userProvider using the context provided
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
    print(response);

    // Consider handling other successful status codes or using a range check
    if (response.statusCode < 200 || response.statusCode > 299) {
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

  //GET HISTORY
  Future<List<dynamic>> getMyHistory(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    final response = await http.get(
      Uri.parse('$baseUrl/history/'),
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

  //GET HISTORY
  Future<List<dynamic>> getHistorySummary(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    final response = await http.get(
      Uri.parse('$baseUrl/history/summary'),
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

  Future<Map<String, dynamic>> getProfile(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

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

  Future<String> getCity(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final response = await http.get(
      Uri.parse('$baseUrl/profile/city'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> postCommunity(
      BuildContext context, String title, String content, File? image) async {
    // Retrieve the userProvider using the context provided
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/posts/'),
    );

    // Add token to headers
    request.headers['Authorization'] = 'Bearer $token';

    // Add title and content fields
    request.fields['title'] = title;
    request.fields['content'] = content;

    // Add image if available
    if (image != null) {
      final fileStream = http.ByteStream(image.openRead());
      final length = await image.length();
      final multipartFile = http.MultipartFile(
        'image',
        fileStream,
        length,
        filename: image.path.split('/').last,
      );
      request.files.add(multipartFile);
    }

    final response = await http.Response.fromStream(await request.send());

    // Consider handling other successful status codes or using a range check
    if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception(
          'Failed to post comment with status code: ${response.statusCode}');
    }
  }
}

//create userin postu
// profille ilgili seyler
//