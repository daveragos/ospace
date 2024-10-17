import 'package:flutter/material.dart';

class KAppBar extends StatelessWidget {
  const KAppBar({
    super.key,
    required this.tempC,
  });

  final String tempC;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.menu),
        SizedBox(width: 20),
        Text('T O D A Y', style: TextStyle(fontSize: 20)),
        Row(
          children: [
            Text('BTC', style: TextStyle(fontSize: 20)),
            SizedBox(width: 20),
            Column(
              children: [
                Text(tempC, style: TextStyle(fontSize: 15)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
