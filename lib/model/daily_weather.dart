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
      //https://api.open-meteo.com/v1/forecast?latitude=9.0107934&longitude=38.7612525&
      //daily=uv_index_max,weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum,sunset,sunrise&
      //current=temperature_2m,relative_humidity_2m,precipitation,is_day,weather_code&
      //hourly=temperature_2m,weather_code,precipitation,uv_index,visibility,precipitation_probability,cloud_cover,relative_humidity_2m,surface_pressure
      //daily:weather_code,tempreture_2m_max,temperature_2m_min,sunrise,sunset,uv_index_max
    );
  }
}
