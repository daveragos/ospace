import 'package:ospace/model/current_weather.dart';
import 'package:ospace/model/daily_weather.dart';
import 'package:ospace/model/hourly_weather.dart';

class WeatherData {
  final double latitude;
  final double longitude;
  final double elevation;
  final String timezone;
  final CurrentWeather? current;
  final HourlyWeather? hourly;
  final DailyWeather? daily;

  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.timezone,
    this.current,
    this.hourly,
    this.daily,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      latitude: json['latitude'],
      longitude: json['longitude'],
      elevation: json['elevation'],
      timezone: json['timezone'],
      current: json['current'] != null ? CurrentWeather.fromJson(json['current']) : null,
      hourly: json['hourly'] != null ? HourlyWeather.fromJson(json['hourly']) : null,
      daily: json['daily'] != null ? DailyWeather.fromJson(json['daily']) : null,
    );
  }
}
