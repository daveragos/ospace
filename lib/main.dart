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
      title: 'OmniSpace',
      theme: ThemeData(
        //white
        primarySwatch: Colors.grey,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
