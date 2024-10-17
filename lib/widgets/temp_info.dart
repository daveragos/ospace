import 'package:flutter/material.dart';

class TempInfo extends StatelessWidget {
  const TempInfo({
    super.key,
    required this.tempC,
    required this.currentTemperature,
    required this.weatherIconUrl,
  });

  final String tempC;
  final double currentTemperature; // Current temperature
  final String weatherIconUrl; // URL for the weather icon

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$tempC °C',
              style: TextStyle(fontSize: 66),
            ),
            // Replace 'Weather Description' with an appropriate description if available
            Text(
              'Weather: $currentTemperature °C', // Add current temperature
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        SizedBox(
          width: 148,
          height: 148,
          child: Image.network(
            weatherIconUrl.isNotEmpty
                ? weatherIconUrl
                : 'https://cdn-icons-png.flaticon.com/512/116/116251.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
