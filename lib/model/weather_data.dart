import 'package:ospace/model/current_weather.dart';
import 'package:ospace/model/daily_weather.dart';
import 'package:ospace/model/hourly_weather.dart';
class WeatherData {
  final double? latitude;
  final double? longitude;
  final double? elevation;
  final String timezone;
  final CurrentWeather? current;
  final HourlyWeather? hourly;
  final DailyWeather? daily;

  WeatherData({
    this.latitude,
    this.longitude,
    this.elevation,
    required this.timezone,
    this.current,
    this.hourly,
    this.daily,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      latitude: json['latitude']?.toDouble(),  // Use .toDouble() and nullable double
      longitude: json['longitude']?.toDouble(),
      elevation: json['elevation']?.toDouble(),
      timezone: json['timezone'] ?? '',  // Provide default for String if null
      current: json['current'] != null ? CurrentWeather.fromJson(json['current']) : null,
      hourly: json['hourly'] != null ? HourlyWeather.fromJson(json['hourly']) : null,
      daily: json['daily'] != null ? DailyWeather.fromJson(json['daily']) : null,
    );
  }
}
