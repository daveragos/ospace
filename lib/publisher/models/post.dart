class Post {
  Post({
    required this.title,
    required this.content,
    required this.coverImage,
  });

  final String title;
  final String content;
  final String coverImage;

  @override
  String toString() {
    return 'Post{title: $title, content: $content, coverImage: $coverImage}';
  }

}