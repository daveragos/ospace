
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



  //news info api caller
Future<List<String>> loadNewsArticles() async {
  List<String> urls = [];
  try {
    final response = await http.get(
      Uri.parse('https://hacker-news.firebaseio.com/v0/newstories.json'),
    );

    if (response.statusCode == 200) {
      data = json.decode(response.body);

      for (int link in data) {
        final itemResponse = await http.get(
          Uri.parse('https://hacker-news.firebaseio.com/v0/item/$link.json'),
        );

        if (itemResponse.statusCode == 200) {
          final info = json.decode(itemResponse.body);
          String? url = info['url'];
          if (url != null) {
            urls.add(url);
          }
        } else {
          throw Exception("Error loading item: ${itemResponse.statusCode}");
        }
      }
    } else {
      throw Exception("Error loading stories: ${response.statusCode}");
    }
  } catch (e) {
    // Log the error
    Logger().e('Error loading news articles: $e');
  }

  return urls;
}


}