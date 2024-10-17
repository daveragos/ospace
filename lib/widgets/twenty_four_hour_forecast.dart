import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ospace/model/weather.dart'; // Adjust the import based on your file structure

class TwentyFourHourForecast extends StatelessWidget {
  final HourlyWeather hourlyForecasts;

  const TwentyFourHourForecast({
    super.key,
    required this.hourlyForecasts,
  });

  @override
  Widget build(BuildContext context) {
    // Get the current hour
    final now = DateTime.now();
    final currentHour = DateFormat("yyyy-MM-dd'T'HH:mm").format(now);

    // Filter hourly forecasts to only include forecasts from the current hour onward
    final upcomingForecasts = hourlyForecasts.time.where((forecast) {
      return forecast.compareTo(currentHour) >= 0;
    }).toList();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade300,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                PhosphorIcon(PhosphorIcons.clock(), size: 30),
                SizedBox(width: 10),
                Text('24 Hour Forecast', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          SizedBox(
            height: 128.0,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              scrollDirection: Axis.horizontal,
              itemCount: upcomingForecasts.length,
              itemBuilder: (context, index) {
                final times = upcomingForecasts;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: [
                      Text(times[index], style: TextStyle(fontSize: 14)),
                      SizedBox(height: 8),
                      Text('${hourlyForecasts.temperature[index]}°C', style: TextStyle(fontSize: 16)), // Display temperature
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
