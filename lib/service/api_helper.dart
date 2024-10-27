import 'dart:convert';

import 'package:coingecko_api/coingecko_api.dart';
import 'package:logger/logger.dart';
import 'package:ospace/model/weather_data.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  Logger logger = Logger();

  bool icon = false;
  List<dynamic> data = [];

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


  final String baseUrl = 'https://api.coingecko.com/api/v3';




  final Set<String> blacklist = {
    'https://x.com',
    'twitter.com',
    'bloomberg.com',
    'github.com'
  };



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


  final http.Client httpClient;

  ApiHelper({http.Client? client}) : httpClient = client ?? http.Client();

  Future<List<dynamic>> fetchCryptoPrices() async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=15&page=1&sparkline=false'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cryptocurrency data');
    }
  }

  Future<WeatherData?> fetchWeatherData() async {
    final response = await httpClient.get(Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=9.0107934&longitude=38.7612525&daily=uv_index_max,weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum,sunset,sunrise&current=temperature_2m,relative_humidity_2m,precipitation,is_day,weather_code&hourly=temperature_2m,weather_code,precipitation,uv_index,visibility,precipitation_probability,cloud_cover,relative_humidity_2m,surface_pressure'));

    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<int>> fetchNewsStoryIds() async {
    final response = await httpClient.get(
        Uri.parse('https://hacker-news.firebaseio.com/v0/newstories.json'));

    if (response.statusCode == 200) {
      return List<int>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load story IDs');
    }
  }

  bool isValidUrl(String url) {
    final Set<String> blacklist = {
      'https://x.com',
      'twitter.com',
      'bloomberg.com',
      'github.com',
    };
    return !blacklist.any((disallowedUrl) => url.contains(disallowedUrl));
  }

}
