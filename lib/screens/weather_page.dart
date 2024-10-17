import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:ospace/model/weather.dart';
import 'package:ospace/service/api_helper.dart';
import 'package:ospace/widgets/hourly_weather_info.dart';
import 'package:ospace/widgets/k_app_bar.dart';
import 'package:ospace/widgets/date_and_location.dart';
import 'package:ospace/widgets/seven_days_forecast.dart';
import 'package:ospace/widgets/temp_info.dart';
import 'package:ospace/widgets/twenty_four_hour_forecast.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final ApiHelper apiHelper = ApiHelper();
  WeatherData? weatherData;
  CurrentWeather? currentWeather;
  HourlyWeather? hourlyWeather;
  DailyWeather? dailyWeather;

  Future<void> getWeatherData() async {
    weatherData = await apiHelper.fetchWeatherData();

    if (weatherData != null) {
      currentWeather = weatherData!.current;
      hourlyWeather = weatherData!.hourly;
      dailyWeather = weatherData!.daily;
    }
  }

  @override
  void initState() {
    super.initState();
    getWeatherData(); // Fetch weather data on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: weatherData != null
                ? Column(

                    children: [
                      KAppBar(tempC: currentWeather!.temperature.toString()),
                      SizedBox(height: 40),
                      DateAndLocation(
                        date: DateFormat('yMMMd').format(DateTime.now()),
                        location: 'Addis Ababa, Ethiopia',
                      ),
                      SizedBox(height: 20),
                      TempInfo(
                        tempC: currentWeather!.temperature.toString(),
                        currentTemperature: currentWeather!.temperature,
                        weatherIconUrl: 'https://openweathermap.org/img/wn/10d@2x.png',
                      ),
                      TwentyFourHourForecast(hourlyForecasts: hourlyWeather!),
                      SevenDaysForecast(dailyForecasts: dailyWeather!),

                    ],
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}