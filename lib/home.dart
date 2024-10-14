
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ospace/Screens/crypto_page.dart';
import 'package:ospace/Screens/news_page.dart';
import 'package:ospace/Screens/weather_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  int selectedIndex = 1;

  Widget getSelectedWidget({required int index}) {
    switch (index) {
      case 0:
        return const WeatherPage();
      case 1:
        return const NewsPage();
      case 2:
        return const CryptoPage();
      default:
        return const NewsPage();
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
          PhosphorIcon(PhosphorIcons.currencyBtc(PhosphorIconsStyle.duotone), size: 30),
          PhosphorIcon(PhosphorIcons.newspaper(PhosphorIconsStyle.duotone), size: 30),
          PhosphorIcon(PhosphorIcons.cloudSun(PhosphorIconsStyle.duotone), size: 30),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body:  SafeArea(child: Container(child: getSelectedWidget(index: selectedIndex))),
    );
  }
}
