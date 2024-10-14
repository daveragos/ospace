
import 'dart:convert';
import 'dart:io';

import 'package:coingecko_api/coingecko_api.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:weather_pack/weather_pack.dart';
import 'package:http/http.dart' as http;

class ApiHelper {

  Logger logger = Logger();

  bool icon = false;
  List<dynamic> data = [];
  WeatherCurrent? currently;


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
    int precision = 2,
    Temp unitsMeasure = Temp.celsius,
  }) {
   final tempC = unitsMeasure.valueToString(temp, precision);
    return tempC;
  }

Future<void> getOnecallWeatherWays({String api = ''}) async {
  final wService = WeatherService(api);
  try {
    currently = await wService.currentWeatherByLocation(
      latitude: 52.374,
      longitude: 4.88969,
    );
    worksTempUnits(temp: currently?.temp ?? 270);
    getWeatherIcon(currently?.weatherIcon ?? '13d');
  } on OwmApiException catch (e) {
    Logger().e('OpenWeatherMap API Error: ${e.message}');
  } on SocketException catch (e) {
    Logger().e('Network Error: Failed to connect. Check your internet connection.');
  } catch (e) {
    Logger().e('Unexpected Error: $e');
  }
}


  //coingecko api caller
  Future<void> coinGeckoCaller () async {
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
    final response = await http.get(Uri.parse('https://hacker-news.firebaseio.com/v0/newstories.json'));
    return List<int>.from(json.decode(response.body));
  }
  final Set<String> blacklist = {'https://x.com', 'twitter.com', 'bloomberg.com', 'github.com'};

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
      final response = await http.get(Uri.parse('https://hacker-news.firebaseio.com/v0/item/$storyId.json'));
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
        Logger().e('Failed to fetch story ID $storyId: ${response.reasonPhrase}');
      }
    }
    return urls;
  }

}