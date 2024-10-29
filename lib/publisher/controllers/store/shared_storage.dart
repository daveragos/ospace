import 'package:shared_preferences/shared_preferences.dart';

class SharedStorage {

  // Method to save the token to shared preferences
  Future<void> saveToken(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Method to retrieve the token from shared preferences
  Future<String?> getToken(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

 Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

}