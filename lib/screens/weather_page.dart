import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ospace/model/current_weather.dart';
import 'package:ospace/model/daily_weather.dart';
import 'package:ospace/model/hourly_weather.dart';
import 'package:ospace/model/weather_data.dart';
import 'package:ospace/service/api_helper.dart';
import 'package:ospace/service/weather_images.dart';
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
  final TextEditingController _locationController = TextEditingController();

  Future<void> getWeatherData(double latitude, double longitude) async {
    weatherData = await apiHelper.fetchWeatherData(latitude, longitude);

    if (weatherData != null) {
      setState(() {
        currentWeather = weatherData!.current;
        hourlyWeather = weatherData!.hourly;
        dailyWeather = weatherData!.daily;
      });
    }
  }

  Future<void> searchLocationWeather() async {
    final location = _locationController.text;
    final coordinates = await apiHelper.fetchCoordinates(location);
    if (coordinates != null) {
      await getWeatherData(coordinates.latitude, coordinates.longitude);
    } else {
      // Show an error message if no coordinates are found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location not found')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getWeatherData(9.0107934, 38.7612525); // Fetch initial weather data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    hintText: 'Enter location',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: searchLocationWeather,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                weatherData != null
                    ? Column(
                        children: [
                          DateAndLocation(
                            date: DateFormat('yMMMd').format(DateTime.now()),
                            location: 'Addis Ababa, Ethiopia',
                          ),
                          SizedBox(height: 20),
                          TempInfo(
                            tempC: currentWeather!.temperature.toString(),
                            currentTemperature: currentWeather!.temperature,
                            weatherIconUrl:
                                getWeatherIconFromCode(currentWeather!.weatherCode),
                          ),
                          SizedBox(height: 20),
                          TwentyFourHourForecast(hourlyForecasts: hourlyWeather!),
                          SizedBox(height: 20),
                          SevenDaysForecast(dailyForecasts: dailyWeather!),
                        ],
                      )
                    : Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

