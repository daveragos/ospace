import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ospace/service/weather_images.dart';
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
    // Get the current time
    final now = DateTime.now();

    // Filter hourly forecasts to include only those within the next 24 hours
    final upcomingForecasts = hourlyForecasts.time
        .where((forecastTime) {
          final forecastDateTime = DateTime.parse(forecastTime);
          // Check if the forecast is within the next 24 hours
          return forecastDateTime.isAfter(now) &&
              forecastDateTime.isBefore(now.add(Duration(hours: 24)));
        })
        .toList();

    // Convert the filtered forecast times to DateTime objects for formatting
    List<DateTime> formattedForecasts =
        upcomingForecasts.map((time) => DateTime.parse(time)).toList();

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
              itemCount: formattedForecasts.length,
              itemBuilder: (context, index) {
                final forecastTime = formattedForecasts[index];
                final timeFormatted = DateFormat.Hm().format(forecastTime);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: [
                      Text(
                        timeFormatted,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Image.asset(getWeatherIconFromCode(hourlyForecasts.weatherCode[index])
),
                        ),
                      ),
                      SizedBox(height: 4),
                      // Display temperature
                      Text(
                        '${hourlyForecasts.temperature[index]}°C',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
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
