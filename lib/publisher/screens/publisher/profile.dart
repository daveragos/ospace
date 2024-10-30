import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ospace/home.dart';
import 'package:ospace/model/news.dart';
import 'package:ospace/model/publisher.dart';
import 'package:ospace/publisher/controllers/auth/auth.dart';
import 'package:ospace/publisher/controllers/post/post.dart';
import 'package:ospace/publisher/controllers/store/shared_storage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Publisher userInfo = Publisher(); // Initialize with default values
  String userName = '';
  int newsCount = 0; // Variable to store news count

  Future<void> getUserInfo() async {
    String? userData = await SharedStorage().getToken('auth_token');
    Map<String, dynamic> decodedUserData = json.decode(userData!);
    userName = decodedUserData['userName']!;
    Map<String, dynamic>? publisher =
        await AuthService().getPublisherByUserName(userName: userName);

    if (publisher != null) {
      setState(() {
        userInfo = Publisher.fromJson(publisher['data']);
      });
      await getNewsCount(); // Fetch news count after user info is set
    }
  }

  Future<void> getNewsCount() async {
    List<LocalNews> newsList = await NewsService().getNewsByPublisher(userName);
    setState(() {
      newsCount = newsList.length; // Update news count
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().logout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: userInfo.userName == null
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show loading indicator while fetching
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueGrey,
                    backgroundImage: NetworkImage(userInfo.profilePicture!
                        .replaceAll('localhost', '192.168.43.131')),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userInfo.userName!,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userInfo.email!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'News Released:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('$newsCount'), // Display news count
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Account Status:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            userInfo.status!,
                            style: TextStyle(
                              color: userInfo.status!.toLowerCase() ==
                                      'approved'
                                  ? Colors.green
                                  : userInfo.status!.toLowerCase() == 'pending'
                                      ? Colors.orange
                                      : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final TextEditingController usernameController =
        TextEditingController(text: userInfo.userName);
    final TextEditingController emailController =
        TextEditingController(text: userInfo.email);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  userInfo.userName = usernameController.text;
                  userInfo.email = emailController.text;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
