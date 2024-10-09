import 'package:book_log/views/account.dart';
import 'package:book_log/views/shelf.dart';
import 'package:book_log/views/explore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:book_log/controllers/book_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  int _selectedIndex = 0;

  final List<Widget> _children = [
    const Shelf(),
    const Explore(),
    const Account(),
  ];

  final List<Widget> _items = [
    const Icon(Icons.library_books),
    const Icon(Icons.explore),
    const Icon(Icons.person),
  ];


  Widget getBody() {
    return _children[_selectedIndex];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Log'),
      ),
      body:  Center(
        child: getBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BookController().getBooks();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60,

 items: _items,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.transparent,
        color: Colors.orangeAccent[100]!,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}