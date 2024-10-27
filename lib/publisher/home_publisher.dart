import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ospace/publisher/screens/post/add_post.dart';
import 'package:ospace/publisher/screens/post/edit_post.dart';
import 'package:ospace/publisher/screens/post/posts.dart';
import 'package:ospace/publisher/screens/publisher/profile.dart';
import 'package:ospace/publisher/screens/publisher/settings.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';


void main() {
  runApp(
    // MyApp(),
    DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    home: const HomePublisher());
  }
}

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
    // const AddPost(),
    // const EditPost(),
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
          Icon(PhosphorIcons.graph(), size: 30),
          Icon(Icons.list, size: 30),
          // Icon(Icons.add, size: 30),
          // Icon(Icons.edit, size: 30),
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