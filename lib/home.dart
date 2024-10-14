
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ospace/Screens/crypto_page.dart';
import 'package:ospace/Screens/news_page.dart';
import 'package:ospace/Screens/weather_page.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int selectedIndex = 0;

  // List<Widget> Screens = [
  //   NewsPage(),
  //   WeatherPage(),
  //   CryptoPage(),
  // ];

  void updateIndex(int idx){
    setState(() {
      selectedIndex = idx;
    });
  }

  Widget getSelectedWidget({required int index}) {
    switch (index) {
      case 0:
        return const NewsPage();
      case 2:
        return const WeatherPage();
      default:
        return const CryptoPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.teal,
        key: _bottomNavigationKey,
        buttonBackgroundColor: Colors.transparent,
        animationDuration:  Duration(milliseconds: 300),
        index: 1,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body:  Container(child: getSelectedWidget(index: selectedIndex)),
    );
  }
}
