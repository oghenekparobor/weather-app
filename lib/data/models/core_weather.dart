import 'package:weather_app_test_foodcourt/data/models/cloud.dart';
import 'package:weather_app_test_foodcourt/data/models/main.dart';
import 'package:weather_app_test_foodcourt/data/models/sys.dart';
import 'package:weather_app_test_foodcourt/data/models/weather.dart';
import 'package:weather_app_test_foodcourt/data/models/wind.dart';
import 'package:weather_app_test_foodcourt/domain/entities/core_weather.dart';

class CoreWeather extends CoreWeatherEntity {
  const CoreWeather({
    required super.weather,
    required super.base,
    required super.main,
    required super.visibility,
    required super.wind,
    required super.clouds,
    required super.dt,
    required super.sys,
    required super.id,
    required super.name,
  });

  factory CoreWeather.fromJson(Map<String, dynamic> json) {
    return CoreWeather(
      weather: (json['weather'] as List<dynamic>)
          .map((weather) => Weather.fromJson(weather))
          .toList(),
      base: json['base'],
      main: Main.fromJson(json['main']),
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weather': weather.map((w) => w.toJson()).toList(),
      'base': base,
      'main': main.toJson(),
      'visibility': visibility,
      'wind': wind.toJson(),
      'clouds': clouds.toJson(),
      'dt': dt,
      'sys': sys.toJson(),
      'id': id,
      'name': name,
    };
  }
}
