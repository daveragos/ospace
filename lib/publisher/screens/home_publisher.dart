import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ospace/publisher/screens/add_post.dart';
import 'package:ospace/publisher/screens/edit_post.dart';
import 'package:ospace/publisher/screens/posts.dart';
import 'package:ospace/publisher/screens/profile.dart';
import 'package:ospace/publisher/screens/settings.dart';

class HomePublisher extends StatefulWidget {
  const HomePublisher({super.key});

  @override
  State<HomePublisher> createState() => _HomePublisherState();
}

class _HomePublisherState extends State<HomePublisher> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    const Profile(),
    const Posts(),
    const AddPost(),
    const EditPost(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.teal,
        key: GlobalKey(),
        buttonBackgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 300),
        index: selectedIndex,
        items: <Widget>[
          Icon(Icons.person, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.add, size: 30),
          Icon(Icons.edit, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}