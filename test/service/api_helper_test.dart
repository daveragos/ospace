import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ospace/service/api_helper.dart';
import 'dart:convert';

void main() {
  group('ApiHelper Tests', () {
    test('fetchCryptoPrices returns data successfully', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode([{"id": "bitcoin", "current_price": 50000}]),
          200,
        );
      });

      final apiHelper = ApiHelper(client: mockClient);  // Inject the mock client
      final result = await apiHelper.fetchCryptoPrices();

      expect(result.isNotEmpty, true);
      expect(result[0]['id'], 'bitcoin');
    });

    test('fetchCryptoPrices throws an exception if the http call fails', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      final apiHelper = ApiHelper(client: mockClient);

      expect(
        () async => await apiHelper.fetchCryptoPrices(),
        throwsException,
      );
    });

test('fetchWeatherData returns WeatherData successfully', () async {
  final mockClient = MockClient((request) async {
    return http.Response(
      jsonEncode(
        {
          "latitude": 52.52,
          "longitude": 13.405,
          "elevation": 34.0,
          "timezone": "GMT",
          "current": {  // Include the current weather data
            "time": "2024-10-23T00:00",
            "temperature_2m": 20.5,  // This should match your expected temperature
            "relative_humidity": 75,
            "is_day": 1,
            "precipitation": 0.0,
            "weather_code": 0
          },
          "hourly": {
            "time": [
              "2024-10-23T00:00",
              "2024-10-23T01:00",
              "2024-10-23T02:00",
              // ...more hourly data
            ],
            "temperature_2m": [
              20.5,
              19.3,
              18.9,
              // ...more hourly temperatures
            ],
            "precipitation": [
              0.0,
              0.0,
              0.0,
              // ...more hourly precipitation data
            ],
            "cloudcover": [
              20,
              25,
              30,
              // ...more cloud cover data
            ],
            "pressure_msl": [
              1012,
              1013,
              1014,
              // ...more pressure data
            ]
          }
        },
      ),
      200,
    );
  });

  final apiHelper = ApiHelper(client: mockClient);
  final result = await apiHelper.fetchWeatherData();

  expect(result?.latitude, 52.52);
  expect(result?.current?.temperature, 20.5);  // Ensure this matches the mock response
});

    test('fetchWeatherData throws an exception if the http call fails', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Failed to load weather data', 404);
      });

      final apiHelper = ApiHelper(client: mockClient);

      expect(
        () async => await apiHelper.fetchWeatherData(),
        throwsException,
      );
    });

    test('fetchNewsStoryIds returns list of story IDs', () async {
      final mockClient = MockClient((request) async {
        return http.Response(jsonEncode([1, 2, 3]), 200);
      });

      final apiHelper = ApiHelper(client: mockClient);
      final result = await apiHelper.fetchNewsStoryIds();

      expect(result.length, 3);
      expect(result, [1, 2, 3]);
    });

    test('fetchNewsStoryIds throws an exception if the http call fails', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Failed to load news story IDs', 404);
      });

      final apiHelper = ApiHelper(client: mockClient);

      expect(
        () async => await apiHelper.fetchNewsStoryIds(),
        throwsException,
      );
    });
  });

  group('URL Validation', () {
    final apiHelper = ApiHelper();

    test('should reject blacklisted URLs', () {
      expect(apiHelper.isValidUrl('https://x.com/some-path'), false);
      expect(apiHelper.isValidUrl('https://bloomberg.com/news'), false);
    });

    test('should accept valid URLs', () {
      expect(apiHelper.isValidUrl('https://example.com'), true);
      expect(apiHelper.isValidUrl('https://flutter.dev'), true);
    });
  });
}
