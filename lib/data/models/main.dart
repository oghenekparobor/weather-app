import 'package:weather_app_test_foodcourt/domain/entities/main.dart';

class Main extends MainEntity {
  Main({
    required super.temp,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.pressure,
    required super.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'] ?? 0,
      feelsLike: json['feels_like'] ?? 0,
      tempMin: json['temp_min'] ?? 0,
      tempMax: json['temp_max'] ?? 0,
      pressure: json['pressure'] ?? 0,
      humidity: json['humidity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'humidity': humidity,
    };
  }
}
