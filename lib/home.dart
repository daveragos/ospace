
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ospace/screens/crypto_page.dart';
import 'package:ospace/screens/weather_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
    // const NewsPage(),
    const WeatherPage(),
    const CryptoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.teal,
        key: _bottomNavigationKey,
        buttonBackgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 300),
        index: selectedIndex,
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
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: _pages,
        ),
      ),
    );
  }
}
