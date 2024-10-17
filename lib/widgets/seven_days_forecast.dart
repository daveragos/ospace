import 'package:flutter/material.dart';
import 'package:ospace/model/weather.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SevenDaysForecast extends StatelessWidget {
  final DailyWeather dailyForecasts; // List to hold daily forecasts

  const SevenDaysForecast({
    super.key,
    required this.dailyForecasts, // Accept the daily forecasts as a parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              PhosphorIcon(PhosphorIconsRegular.calendar),
              const SizedBox(width: 4.0),
              Text(
                '7-Day Forecast',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text('more details ▶'),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dailyForecasts.time.length,
          itemBuilder: (context, index) {
            final day = dailyForecasts;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(day.time[index]), // Date for the day
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 36.0,
                          width: 36.0,
                          child: Image.network(
                            'https://openweathermap.org/img/wn/10d@2x.png', // URL for the weather icon
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'day.', // Description of the weather
                        ),
                      ],
                    ),
                    FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${day.temperatureMin[index]}°C - ${day.temperatureMax[index]}°C', // Min and Max temperatures
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
