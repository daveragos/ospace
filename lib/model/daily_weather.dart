class DailyWeather {
  final List<String> time;
  final List<int> weatherCode;
  final List<double> temperatureMax;
  final List<double> temperatureMin;
  final List<String> sunrise;
  final List<String> sunset;
  final List<double> uvIndexMax;

  DailyWeather({
    required this.time,
    required this.weatherCode,
    required this.temperatureMax,
    required this.temperatureMin,
    required this.sunrise,
    required this.sunset,
    required this.uvIndexMax,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      time: List<String>.from(json['time']),
      weatherCode: List<int>.from(json['weather_code']),
      temperatureMax: List<double>.from(json['temperature_2m_max']),
      temperatureMin: List<double>.from(json['temperature_2m_min']),
      sunrise: List<String>.from(json['sunrise']),
      sunset: List<String>.from(json['sunset']),
      uvIndexMax: List<double>.from(json['uv_index_max']),
    );
  }
}
