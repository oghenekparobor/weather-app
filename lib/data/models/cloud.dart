import 'package:weather_app_test_foodcourt/domain/entities/cloud.dart';

class Clouds extends CloudsEntity {
  Clouds({required super.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'all': all,
    };
  }
}
