import 'package:weather_app_test_foodcourt/domain/entities/city.dart';

class City extends CityEntity {
  const City({
    required super.city,
    required super.lat,
    required super.lng,
    required super.country,
    required super.iso2,
    required super.adminName,
    required super.capital,
    required super.population,
    required super.populationProper,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      city: json['city'] as String,
      lat: json['lat'] as String,
      lng: json['lng'] as String,
      country: json['country'] as String,
      iso2: json['iso2'] as String,
      adminName: json['admin_name'] as String,
      capital: json['capital'] as String,
      population: json['population'] as String,
      populationProper: json['population_proper'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'lat': lat,
      'lng': lng,
      'country': country,
      'iso2': iso2,
      'admin_name': adminName,
      'capital': capital,
      'population': population,
      'population_proper': populationProper,
    };
  }
}
