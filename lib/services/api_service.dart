import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = 'https://plant-app-f6e01.uc.r.appspot.com/';

  // GET POSTS
  Future<dynamic> getAllPosts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/community/'));
      if (response.statusCode == 200) {
        return json.decode(response.body)['data'];
      } else {
        print('Failed to load data: ${response.statusCode} ${response.body}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error encountered: $e');
    }
  }

  // POST isteği
  static Future<dynamic> post(String endpoint,
      {Map<String, dynamic>? body}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }
}
