import 'package:weather_app_test_foodcourt/domain/entities/sys.dart';

class Sys extends SysEntity {
  Sys({
    required super.country,
    required super.sunrise,
    required super.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      country: json['country'] ?? 'NG',
      sunrise: json['sunrise'] ?? 0,
      sunset: json['sunset'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}
