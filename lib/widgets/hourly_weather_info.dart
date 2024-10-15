
import 'package:flutter/material.dart';
import 'package:ospace/model/hourly_weather.dart';

class HourlyWeatherWidget extends StatelessWidget {
  final int index;
  final HourlyWeather data;
  const HourlyWeatherWidget({
    super.key,
    required this.index,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 124.0,
      child: Column(
        children: [
          Text(
            '23°',

            ),

          Stack(
            children: [
              Divider(
                thickness: 2.0,
                color: Colors.grey,
              ),
              if (index == 0)
                Positioned(
                  top: 2.0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 42.0,
            width: 42.0,
            child: Image.network(
              'https://cdn-icons-png.flaticon.com/512/116/116251.png',
              fit: BoxFit.cover,
            ),
          ),
          FittedBox(
            child: Text(
              '12°C',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            'Now 23:12',
          )
        ],
      ),
    );
  }
}
