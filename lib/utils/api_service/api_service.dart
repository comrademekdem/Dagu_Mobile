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
    // Handle response as needed
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
      return jsonDecode(response.body);
    } else {
      print('Failed to login: ${response.statusCode}');
      throw Exception('Failed to login');
    }
  }
}
