import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = 'https://plant-app-f6e01.uc.r.appspot.com/';

  // GET ALL POSTS
  Future<Map<String, dynamic>> getAllPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/community/'));
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
  Future<Map<String, dynamic>> likePost(int id) async {
    final response = await http.post(Uri.parse('$baseUrl/community/$id/likes'));
    if (response.statusCode == 200) {
      var decodedJson = json.decode(utf8.decode(response.bodyBytes));
      return decodedJson['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
