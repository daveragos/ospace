import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:ospace/model/news.dart';
import 'package:ospace/publisher/controllers/store/shared_storage.dart';

class News {

   final String baseUrl = 'http://192.168.43.131:3000/api';

Future <LocalNews> postNews(String title, String content, String coverImage) async {
    String? token = await SharedStorage().getToken('auth_token');

  final response = await http.post(
    Uri.parse('${baseUrl}/create-news'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': token!,
      },
    body: jsonEncode({
      'title': title,
      'content': content,
      'coverImage': coverImage,
    }),
  );
  if (response.statusCode == 200) {
    return LocalNews.fromJson(jsonDecode(response.body));
  } else {
    Logger().e('Failed to post news ${response.body} which is ${response.headersSplitValues['Authorization']}');
    throw Exception('Failed to post news');
  }
}


}