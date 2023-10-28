import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  final String city;
  final String lat;
  final String lng;
  final String country;
  final String iso2;
  final String adminName;
  final String capital;
  final String population;
  final String populationProper;

  const CityEntity({
    required this.city,
    required this.lat,
    required this.lng,
    required this.country,
    required this.iso2,
    required this.adminName,
    required this.capital,
    required this.population,
    required this.populationProper,
  });

  @override
  List<Object?> get props {
    return [
      city,
      lat,
      lng,
      country,
      iso2,
      adminName,
      capital,
      population,
      populationProper,
    ];
  }
}
