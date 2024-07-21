import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://dagu-backend.onrender.com';

  Future<void> register(String username, String firstName, String lastName,
      String password, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
        'email': email,
      }),
    );
    if (response.statusCode == 200) {
      print('Registration successful');
    } else {
      print('Failed to register: ${response.statusCode}');
      throw Exception('Failed to register');
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/token/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> getUserDetails(String token, int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/news/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('User details response status: ${response.statusCode}');
      print('User details response body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        print('User not found: ${response.statusCode}');
        throw Exception('User not found');
      } else {
        print('Failed to get user details: ${response.statusCode}');
        throw Exception('Failed to get user details');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<void> setUserPreferences(
      String token, int userId, List<String> preferences) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/news/users/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'topics_selected': preferences
            .map((topic) => {
                  'id':
                      0, // Backend might not need this, or could be used for reference
                  'topic': topic
                })
            .toList()
      }),
    );

    if (response.statusCode == 200) {
      print('Preferences updated successfully');
    } else {
      print('Failed to update preferences: ${response.statusCode}');
      throw Exception('Failed to update preferences');
    }
  }
}
