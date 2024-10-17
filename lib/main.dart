import 'package:flutter/material.dart';
import 'package:ospace/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      title: 'Ospace',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.teal[50],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
