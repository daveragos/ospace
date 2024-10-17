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
      relativeHumidity: List<int>.from(json['relative_humidity_2m']),
      precipitation: List<double>.from(json['precipitation']),
      weatherCode: List<int>.from(json['weather_code']),
      surfacePressure: List<double>.from(json['surface_pressure']),
      cloudCover: List<int>.from(json['cloud_cover']),
      visibility: List<double>.from(json['visibility']),
      uvIndex: List<double>.from(json['uv_index']),
    );
  }
}

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
