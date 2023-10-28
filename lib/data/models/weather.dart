import 'package:weather_app_test_foodcourt/domain/entities/weather.dart';

class Weather extends WeatherEntity {
  const Weather({
    required super.id,
    required super.main,
    required super.description,
    required super.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}
