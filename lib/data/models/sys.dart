import 'package:weather_app_test_foodcourt/domain/entities/sys.dart';

class Sys extends SysEntity {
  Sys({
    required super.country,
    required super.sunrise,
    required super.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
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
