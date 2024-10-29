import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'http://192.168.43.131:3000';

  // Method to save the token to shared preferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Method to retrieve the token from shared preferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Signup function to create a new publisher
  Future<Map<String, dynamic>?> signUp({
    required String userName,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String profilePicturePath,
  }) async {
    final Uri url = Uri.parse('$baseUrl/auth/signUp');
    final request = http.MultipartRequest('POST', url);

    // Validate fields before adding to the request
    if (userName.isEmpty || firstName.isEmpty || lastName.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      print("One or more fields are empty or invalid.");
      return null;
    }

    // Add fields with trimmed values to ensure no whitespace issues
    request.fields['userName'] = userName.trim();
    request.fields['firstName'] = firstName.trim();
    request.fields['lastName'] = lastName.trim();
    request.fields['email'] = email.trim();
    request.fields['phone'] = phone.trim();
    request.fields['password'] = password;

    // Attach the profile picture file if it exists
    try {
      final file = File(profilePicturePath);
      if (await file.exists()) {
        request.files.add(await http.MultipartFile.fromPath('profilePicture', profilePicturePath));
      } else {
        print("Profile picture file does not exist at the given path.");
        return null;
      }
    } catch (e) {
      print("Error adding profile picture file: $e");
      return null;
    }

    // Send the request and handle response
    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        final data = json.decode(responseBody);
        // Save the token after successful signup
        await _saveToken(data['token']);  // Assuming the token is returned in the response
        return data;
      } else {
        print('Sent data: ${request.fields}');
        print('Error ${response.statusCode}: $responseBody');
        return null;
      }
    } catch (e) {
      print("Request error: $e");
      return null;
    }
  }

  // Login function
  Future<Map<String, dynamic>?> login({
    required String username,
    required String password,
  }) async {
    final Uri url = Uri.parse('$baseUrl/auth/signIn');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userName': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Save the token after successful login
      await _saveToken(data.toString());  // Assuming the token is returned in the response
      return data;
    } else {
      print('Login failed: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

  // Method to logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');  // Remove the token on logout
  }
}
