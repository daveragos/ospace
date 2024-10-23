// ignore_for_file: public_member_api_docs, sort_constructors_first
class HourlyWeather {
  final List<String> time;
  final List<double> temperature;
  final List<int> relativeHumidity;
  final List<double> precipitation;
  final List<int> weatherCode;
  final List<double> surfacePressure;
  final List<int> cloudCover;
  final List<double> visibility;
  final List<double> uvIndex;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.relativeHumidity,
    required this.precipitation,
    required this.weatherCode,
    required this.surfacePressure,
    required this.cloudCover,
    required this.visibility,
    required this.uvIndex,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: List<String>.from(json['time']),
      temperature: List<double>.from(json['temperature_2m']),
      relativeHumidity:List<int>.from(json['relative_humidity_2m']),
      precipitation: List<double>.from(json['precipitation']),
weatherCode: List<int>.from(json['weather_code']),

      surfacePressure: List<double>.from(json['surface_pressure']),
      cloudCover: List<int>.from(json['cloud_cover']),
      visibility: List<double>.from(json['visibility']),
      uvIndex: List<double>.from(json['uv_index']),
    );
  }
}
