import 'package:flutter/material.dart';

class DateAndLocation extends StatelessWidget {
  const DateAndLocation({
    super.key,
    required this.date,
    required this.location,
  });

  final String date;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(date, style: TextStyle(fontSize: 20)),
        SizedBox(width: 20),
        Text(location, style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold)),
      ],
    );
  }
}