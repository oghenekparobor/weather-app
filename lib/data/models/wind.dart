import 'package:weather_app_test_foodcourt/domain/entities/wind.dart';

class Wind extends WindEntity {
  Wind({
    required super.speed,
    required super.deg,
    required super.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'],
      deg: json['deg'],
      gust: json['gust'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }
}
