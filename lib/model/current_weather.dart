class CurrentWeather {
  final String time;
  final double temperature;
  final int relativeHumidity;
  final int isDay;
  final double precipitation;
  final int weatherCode;

  CurrentWeather({
    required this.time,
    required this.temperature,
    required this.relativeHumidity,
    required this.isDay,
    required this.precipitation,
    required this.weatherCode,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      time: json['time'],
      temperature: json['temperature_2m'],
      relativeHumidity: json['relative_humidity_2m'],
      isDay: json['is_day'],
      precipitation: json['precipitation'],
      weatherCode: json['weather_code'],
    );
  }
}
