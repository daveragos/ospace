import 'dart:convert';
import 'dart:io';

import 'package:coingecko_api/coingecko_api.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ospace/model/weather.dart';
import 'package:weather_pack/weather_pack.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  Logger logger = Logger();

  bool icon = false;
  List<dynamic> data = [];
  // WeatherCurrent? currently;

  //weather icon getter based on the temp
  Image getWeatherIcon(String weatherIcon) {
    final weatherImage = Image.asset(
      width: 50,
      height: 50,
      ImagePathWeather.getPathWeatherIcon(weatherIcon),
      filterQuality: FilterQuality.high, // optional
      package: ImagePathWeather.packageName,
    );
    return weatherImage;
  }

  // temp unit converter to celcius
  String worksTempUnits({
    double temp = 270.78,
    Temp unitsMeasure = Temp.celsius,
  }) {
    final tempC = unitsMeasure.valueToString(temp);
    return tempC;
  }

  Future<WeatherOneCall?> oneCallWeatherWays(
      {String api = '3721410d028c8efa237d9196d80a6061'}) async {
    final wService = WeatherService(api);
    try {
      WeatherOneCall currently = await wService.oneCallWeatherByLocation(
        latitude: 52.374,
        longitude: 4.88969,
      );
      return currently;
    } on OwmApiException catch (e) {
      Logger().e('OpenWeatherMap API Error: ${e.message}');
    } on SocketException {
      Logger().e(
          'Network Error: Failed to connect. Check your internet connection.');
    } catch (e) {
      Logger().e('Unexpected Error: $e');
    }
    return null;
  }

  // Future<WeatherCurrent?> getOnecallWeatherWays(
  //     {String api = '3721410d028c8efa237d9196d80a6061'}) async {
  //   final wService = WeatherService(api);
  //   try {
  //     WeatherCurrent currently = await wService.currentWeatherByLocation(
  //       latitude: 9.0107934,
  //       longitude: 38.7612525,
  //     );
  //     return currently;
  //   } on OwmApiException catch (e) {
  //     Logger().e('OpenWeatherMap API Error: ${e.message}');
  //   } on SocketException {
  //     Logger().e(
  //         'Network Error: Failed to connect. Check your internet connection.');
  //   } catch (e) {
  //     Logger().e('Unexpected Error: $e');
  //   }
  //   return null;
  // }

  //coingecko api caller
  Future<void> coinGeckoCaller() async {
    final api = CoinGeckoApi();

    final result = await api.coins.getCoinOHLC(
      id: 'bitcoin',
      vsCurrency: 'usd',
      days: 7,
    );
    logger.d(result.runtimeType);
  }

// Fetch story IDs only once
  Future<List<int>> fetchNewsStoryIds() async {
    final response = await http.get(
        Uri.parse('https://hacker-news.firebaseio.com/v0/newstories.json'));
    return List<int>.from(json.decode(response.body));
  }

  final Set<String> blacklist = {
    'https://x.com',
    'twitter.com',
    'bloomberg.com',
    'github.com'
  };

  // Method to validate URL
  bool isValidUrl(String url) {
    if (blacklist.any((disallowedUrl) => url.contains(disallowedUrl))) {
      return false;
    }

    return true;
  }

  // Fetch the details of each story by ID
  Future<List<String>> loadNewsArticlesByIds(List<int> storyIds) async {
    List<String> urls = [];
    for (int storyId in storyIds) {
      final response = await http.get(Uri.parse(
          'https://hacker-news.firebaseio.com/v0/item/$storyId.json'));
      if (response.statusCode == 200) {
        final info = json.decode(response.body);
        String? url = info['url'];
        // Validate URL before adding to the list
        if (url != null && isValidUrl(url)) {
          urls.add(url);
          Logger().t(url);
        } else {
          // Optionally log the invalid URL case
          Logger().e('Invalid or disallowed URL for story ID $storyId: $url');
        }
      } else {
        Logger()
            .e('Failed to fetch story ID $storyId: ${response.reasonPhrase}');
      }
    }
    return urls;
  }




Future<WeatherData?> fetchWeatherData() async {
  final response = await http.get(Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=13.4967&longitude=39.4753&current=temperature_2m,relative_humidity_2m,is_day,precipitation,weather_code&hourly=temperature_2m,relative_humidity_2m,precipitation_probability,precipitation,rain,weather_code,surface_pressure,cloud_cover,visibility,uv_index&daily=weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset,uv_index_max&timezone=Africa%2FCairo&past_days=7'));

  if (response.statusCode == 200) {
    Logger().d(response.body);
    return WeatherData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load weather data');
  }
}


}
