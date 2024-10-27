import 'package:flutter_quill/quill_delta.dart';

class Post {
  Post({
    required this.title,
    required this.content,
    required this.coverImage,
  });

  final String title;
  final Delta content;
  final String coverImage;

  @override
  String toString() {
    return 'Post{title: $title, content: $content, coverImage: $coverImage}';
  }

}