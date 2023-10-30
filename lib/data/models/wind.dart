import 'package:weather_app_test_foodcourt/domain/entities/wind.dart';

class Wind extends WindEntity {
  Wind({
    required super.speed,
    required super.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'] ?? 0,
      deg: json['deg'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': deg,
    };
  }
}
