import 'package:flutter/material.dart';
import 'package:ospace/model/news.dart';
import 'package:ospace/publisher/controllers/post/post.dart';
import 'package:ospace/publisher/screens/post/add_post.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<LocalNews> newsList = [];
  List<LocalNews> filteredNewsList = [];
  bool isLoading = true;
  String selectedStatus = 'ALL'; // Default selected status

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      final fetchedNews = await NewsService().getNewsByPublisher("dave_ragos");
      setState(() {
        newsList = fetchedNews;
        filteredNewsList = fetchedNews; // Initially, all news are displayed
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // Handle the error (e.g., show a SnackBar with the error message)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching news: $error')),
      );
    }
  }

  void filterNews(String status) {
    setState(() {
      selectedStatus = status;

      if (status == 'ALL') {
        filteredNewsList = newsList; // Show all news
      } else {
        filteredNewsList = newsList
            .where((news) => news.status == status) // Filter based on status
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          // Add a dropdown for filtering
          DropdownButton<String>(
            value: selectedStatus,
            icon: const Icon(Icons.filter_list),
            items: <String>['ALL', 'APPROVED', 'PENDING', 'SUSPENDED']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                filterNews(newValue);
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPost(),
            ),
          );
          await fetchNews();
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : filteredNewsList.isEmpty
              ? const Center(child: Text('No posts available'))
              : ListView.builder(
                  itemCount: filteredNewsList.length,
                  itemBuilder: (context, index) {
                    final news = filteredNewsList[index];
                    return ListTile(
                      leading: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          news.coverImage!,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.error), // Fallback icon
                            );
                          },
                        ),
                      ),
                      title: Text(news.title!),
                      subtitle: Text('Image: ${news.coverImage}'),
                      onTap: () {
                        print(news.coverImage);
                      },
                    );
                  },
                ),
    );
  }
}
