import 'package:equatable/equatable.dart';
import 'package:weather_app_test_foodcourt/data/models/cloud.dart';
import 'package:weather_app_test_foodcourt/data/models/main.dart';
import 'package:weather_app_test_foodcourt/data/models/sys.dart';
import 'package:weather_app_test_foodcourt/data/models/weather.dart';
import 'package:weather_app_test_foodcourt/data/models/wind.dart';

class CoreWeatherEntity extends Equatable {
  final List<Weather> weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int id;
  final String name;

  const CoreWeatherEntity({
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        weather,
        base,
        main,
        visibility,
        wind,
        clouds,
        dt,
        sys,
        id,
        name,
      ];
}
