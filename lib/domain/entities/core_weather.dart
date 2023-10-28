import 'package:equatable/equatable.dart';
import 'package:weather_app_test_foodcourt/data/models/curren_weather.dart';

class CoreWeatherEntity extends Equatable {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final CurrentWeather current;

  const CoreWeatherEntity({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
  });

  @override
  List<Object?> get props => [lat, lon, timezone, timezoneOffset, current];
}
