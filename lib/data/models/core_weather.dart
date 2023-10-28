import 'package:weather_app_test_foodcourt/data/models/curren_weather.dart';
import 'package:weather_app_test_foodcourt/domain/entities/core_weather.dart';

class CoreWeather extends CoreWeatherEntity {
  const CoreWeather({
    required super.lat,
    required super.lon,
    required super.timezone,
    required super.timezoneOffset,
    required super.current,
  });

  factory CoreWeather.fromJson(Map<String, dynamic> json) {
    return CoreWeather(
      lat: json['lat'],
      lon: json['lon'],
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
      current: CurrentWeather.fromJson(json['current']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
      'timezone': timezone,
      'timezone_offset': timezoneOffset,
      'current': current.toJson(),
    };
  }
}
