import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:ospace/model/news.dart';
import 'package:ospace/publisher/controllers/store/shared_storage.dart';

class NewsService {
  final String baseUrl = 'http://192.168.43.131:3000/api';

  Future<LocalNews?> postNews(String title, String content, String coverImagePath) async {
    String? token = await SharedStorage().getToken('auth_token');

    if (token == null) {
      Logger().e('Token is missing');
      throw Exception('Authorization token is required');
    }

    try {
      // Convert the image path to a File
      File coverImageFile = File(coverImagePath);

      // Prepare the multipart request
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/create-news'))
        ..headers['Authorization'] = token
        ..fields['title'] = title
        ..fields['content'] = content
        ..files.add(await http.MultipartFile.fromPath('coverImage', coverImageFile.path));

      // Send the request
      var response = await request.send();

      // Convert response to a usable format
      final responseString = await http.Response.fromStream(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Logger().i('News posted successfully');
        return LocalNews.fromJson(jsonDecode(responseString.body));
      } else if (response.statusCode == 401) {
        Logger().e('Unauthorized request: Invalid token');
        throw Exception('Unauthorized access - please log in again');
      } else if (response.statusCode == 400) {
        Logger().e('Bad request: ${responseString.body}');
        throw Exception('Bad request - please check the data provided');
      } else if (response.statusCode == 500) {
        Logger().e('Server error: ${responseString.body}');
        throw Exception('Server error - please try again later');
      } else {
        Logger().e('Unexpected error: ${responseString.body}');
        throw Exception('Failed to post news');
      }
    } catch (e) {
      Logger().e('Network or unexpected error: $e');
      throw Exception('Failed to connect to the server. Please check your network connection and try again.');
    }
  }

  Future<List<LocalNews>> getNewsByPublisher(String userName) async {
  // String? token = await SharedStorage().getToken('auth_token');

  // if (token == null) {
  //   Logger().e('Token is missing');
  //   throw Exception('Authorization token is required');
  // }

  try {
    final response = await http.post(
      Uri.parse('$baseUrl/get-news-by-publisher-userName'),
      headers: {
        // 'Authorization': token,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'userName': userName}),
    );

    if (response.statusCode == 200) {
      Logger().i('News retrieved successfully');
      List newsList = jsonDecode(response.body)['data'];
      return newsList.map((json) => LocalNews.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      Logger().e('Unauthorized request: Invalid token');
      throw Exception('Unauthorized access - please log in again');
    } else {
      Logger().e('Failed to retrieve news: ${response.body}');
      throw Exception('Failed to retrieve news');
    }
  } catch (e) {
    Logger().e('Network or unexpected error: $e');
    throw Exception('Failed to connect to the server. Please check your network connection and try again.');
  }
}

}
