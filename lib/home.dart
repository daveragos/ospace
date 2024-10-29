// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ospace/publisher/controllers/auth/auth.dart';
import 'package:ospace/publisher/controllers/store/shared_storage.dart';
import 'package:ospace/publisher/home_publisher.dart';
import 'package:ospace/publisher/screens/auth/signin.dart';
import 'package:ospace/publisher/screens/post/pending_page.dart';
import 'package:ospace/publisher/screens/publisher/settings.dart';
import 'package:ospace/screens/crypto_page.dart';
import 'package:ospace/screens/news_page.dart';
import 'package:ospace/screens/weather_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  int selectedIndex = 1;

  final List<Widget> _pages = [
    const CryptoPage(),
    const NewsPage(),
    const WeatherPage(),
    // const CryptoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text('News'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: KActionsWidget(
              tempC: '27',
            ),
          ),
        ],
      ),
      drawer: const KDrawerWidget(),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.teal,
        key: _bottomNavigationKey,
        buttonBackgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 300),
        index: selectedIndex,
        items: <Widget>[
          PhosphorIcon(PhosphorIcons.currencyBtc(PhosphorIconsStyle.duotone),
              size: 30),
          PhosphorIcon(PhosphorIcons.newspaper(PhosphorIconsStyle.duotone),
              size: 30),
          PhosphorIcon(PhosphorIcons.cloudSun(PhosphorIconsStyle.duotone),
              size: 30),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: _pages,
        ),
      ),
    );
  }
}

class KDrawerWidget extends StatefulWidget {
  const KDrawerWidget({super.key});

  @override
  State<KDrawerWidget> createState() => _KDrawerWidgetState();
}

class _KDrawerWidgetState extends State<KDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Center(
                child: Text('OmniSpace',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold))),
          ),
          ListTile(
              title: const Text('Publish', style: TextStyle(fontSize: 20)),
              leading: Icon(Icons.speaker_notes),
              onTap: () async {
  // Perform login and status checks
  bool loggedIn = await SharedStorage().containsKey('auth_token');
  if (loggedIn) {
    String? userData = await SharedStorage().getToken('auth_token');
    Map<String, dynamic> decodedUserData = json.decode(userData!);
    String username = decodedUserData['userName']!;
    Map<String, dynamic>? publisher = await AuthService().getPublisherByUserName(userName: username);
    String status = publisher!['data']['status']!;

    // Close the drawer and navigate based on the user's status
    if (status == 'PENDING' || status == 'SUSPENDED') {
      Navigator.pop(context); // Ensure drawer is closed before navigating
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PublisherStatusScreen(
            status: status,
            userName: username,
          ),
        ),
      );
    } else {
      Navigator.pop(context); // Ensure drawer is closed before navigating
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePublisher()),
      );
    }
  } else {
    if (!mounted) return;
    Navigator.pop(context); // Ensure drawer is closed before navigating
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
),
          ListTile(
            title: const Text('News', style: TextStyle(fontSize: 20)),
            leading: const Icon(Icons.newspaper),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewsPage()));
            },
          ),
          ListTile(
            title: const Text('Weather', style: TextStyle(fontSize: 20)),
            leading: Icon(PhosphorIcons.cloudSun(PhosphorIconsStyle.duotone)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WeatherPage()));
            },
          ),
          ListTile(
            title: const Text('Crypto', style: TextStyle(fontSize: 20)),
            leading:
                Icon(PhosphorIcons.currencyBtc(PhosphorIconsStyle.duotone)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CryptoPage()));
            },
          ),
          ListTile(
            title: const Text('Settings', style: TextStyle(fontSize: 20)),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()));
            },
          ),
          ListTile(
            title: const Text('Logout', style: TextStyle(fontSize: 20)),
            leading: Icon(Icons.logout),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          ),
        ],
      ),
    );
  }
}
