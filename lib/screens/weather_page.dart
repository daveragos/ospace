import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
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
  final FloatingSearchBarController _searchBarController = FloatingSearchBarController();
  String displayedLocation = 'Addis Ababa, Ethiopia'; // Default location
  List<String> searchSuggestions = [];

  // Request location permissions
  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permission denied')),
        );
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are permanently denied. Please enable them in the app settings.')),
      );
      return;
    }
  }

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

  Future<void> getCurrentLocationWeather() async {
    await _requestLocationPermission();
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      await getWeatherData(position.latitude, position.longitude);

      // Reverse geocode to get the address name
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        setState(() {
          displayedLocation = '${placemarks.first.locality}, ${placemarks.first.country}';
        });
      } else {
        setState(() {
          displayedLocation = 'Unknown Location';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not get location: $e')),
      );
    }
  }

  Future<void> searchLocationWeather(String location) async {
    final coordinates = await apiHelper.fetchCoordinates(location);
    if (coordinates != null) {
      await getWeatherData(coordinates.latitude, coordinates.longitude);
      setState(() {
        displayedLocation = location;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location not found')),
      );
    }
  }

  Future<void> fetchSearchSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() => searchSuggestions = []);
      return;
    }

    final url = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search?name=$query&count=5&language=en&format=json',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        searchSuggestions = (data['results'] ?? [])
            .map<String>((result) => '${result['name']}, ${result['country']}')
            .toList();
      });
    } else {
      setState(() {
        searchSuggestions = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 80), // Space for FloatingSearchBar
                    weatherData != null
                        ? Column(
                            children: [
                              DateAndLocation(
                                date: DateFormat('yMMMd').format(DateTime.now()),
                                location: displayedLocation,
                              ),
                              SizedBox(height: 20),
                              TempInfo(
                                tempC: currentWeather!.temperature.toString(),
                                currentTemperature: currentWeather!.temperature,
                                weatherIconUrl: getWeatherIconFromCode(currentWeather!.weatherCode),
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
            FloatingSearchBar(
              controller: _searchBarController,
              hint: 'Search for a location...',
              openAxisAlignment: 0.0,
              scrollPadding: const EdgeInsets.only(top: 16, bottom: 20),
              transitionDuration: const Duration(milliseconds: 500),
              transitionCurve: Curves.easeInOut,
              physics: const BouncingScrollPhysics(),
              onQueryChanged: fetchSearchSuggestions,
              onSubmitted: (query) {
                _searchBarController.close();
                searchLocationWeather(query);
              },
              builder: (context, transition) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                    color: Colors.white,
                    elevation: 4.0,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: searchSuggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = searchSuggestions[index];
                        return ListTile(
                          title: Text(suggestion),
                          onTap: () {
                            _searchBarController.close();
                            searchLocationWeather(suggestion);
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
