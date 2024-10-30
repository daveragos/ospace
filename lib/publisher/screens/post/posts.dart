import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ospace/model/news.dart';
import 'package:ospace/publisher/controllers/post/post.dart';
import 'package:ospace/publisher/controllers/store/shared_storage.dart';
import 'package:ospace/publisher/screens/post/add_post.dart';
import 'package:ospace/publisher/screens/post/edit_post.dart'; // Import your edit post page
import 'package:ospace/publisher/screens/post/news_detail.dart'; // Import the NewsDetailPage

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
  List<String> convertedImages = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      String? userInfo = await SharedStorage().getToken('auth_token');
      Map<String, dynamic> mappedUser = json.decode(userInfo!);
      String? username = mappedUser['userName'];
      final fetchedNews = await NewsService().getNewsByPublisher(username!);
      setState(() {
        newsList = fetchedNews;
        filteredNewsList = fetchedNews; // Initially, all news are displayed
        convertedImages = fetchedNews
            .map((news) =>
                news.coverImage!.replaceFirst('localhost', '192.168.43.131'))
            .toList();
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

  Color getStatusColor(String status) {
    switch (status) {
      case 'APPROVED':
        return Colors.green; // Green for approved
      case 'PENDING':
        return Colors.amber; // Amber for pending
      case 'SUSPENDED':
        return Colors.red; // Red for suspended
      default:
        return Colors.grey; // Grey for default
    }
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
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        leading: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(convertedImages[index]),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: getStatusColor(news.status!),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                news.status!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPost(news: news),
                                  ),
                                ).then((value) {
                                  if (value == true) {
                                    // Refresh the list after editing
                                    fetchNews();
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(news.title!)),
                          ],
                        ),
                        subtitle: Text('${news.reports!.length} reports'),
                        onTap: () {
                          print(news.content);
                        },
                      ),
                    );
                  }),
    );
  }
}
