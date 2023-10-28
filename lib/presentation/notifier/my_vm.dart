import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app_test_foodcourt/core/extension/app_state.dart';
import 'package:weather_app_test_foodcourt/core/params/no_param.dart';
import 'package:weather_app_test_foodcourt/core/state/state.dart';
import 'package:weather_app_test_foodcourt/core/storage/secure.dart';
import 'package:weather_app_test_foodcourt/data/models/city.dart';
import 'package:weather_app_test_foodcourt/data/models/core_weather.dart';
import 'package:weather_app_test_foodcourt/domain/usecases/usecases.dart';

@injectable
class MyViewModel extends ChangeNotifier {
  MyViewModel({
    required this.citiesUsecase,
    required this.forecastCityUsecase,
    required this.initForecaseUsecase,
    required this.storage,
  });

  final ForecastCityUsecase forecastCityUsecase;
  final CitiesUsecase citiesUsecase;
  final InitForecaseUsecase initForecaseUsecase;
  final SecureStorage storage;

  List<CoreWeather> weathers = [];

  // get the weather information of current location
  Future<void> init() async {
    initForecaseUsecase.call(params: const NoParams()).then((value) {
      if (!value.isError) {
        weathers.add(CoreWeather.fromJson((value as LoadedState).data));
      }

      notifyListeners();
    });
  }

  // get information of selected city
  Future<void> forecast(City city) async {
    forecastCityUsecase.call(params: city).then((value) {
      if (!value.isError) {
        weathers.add(CoreWeather.fromJson((value as LoadedState).data));
      }

      notifyListeners();
    });
  }

  // all cities from assets/ng.json
  List<City> allCities = [];

  // fetch the cities from the repo via usecase
  Future<void> getCities() async {
    citiesUsecase.call(params: const NoParams()).then((value) {
      if (!value.isError) {
        cities.add(City.fromJson((value as LoadedState).data));
      }

      notifyListeners();
    });
  }

  List<City> cities = [];

  Future<void> getPersistedCities() async {
    var result = storage.getFrom('LOCATION_PERSISTED');

    if (result.isNotEmpty) {
      for (var city in (jsonDecode(result) as List)) {
        cities.add(City.fromJson(city));
      }

      notifyListeners();
    }
  }

  Future<void> addRemoveCities(City city) async {
    var result = storage.getFrom('LOCATION_PERSISTED');

    if (result.isNotEmpty) {
      var cities = (jsonDecode(result) as List);
      if (cities.any((e) => e['city'] == city)) {
        cities.removeWhere((e) => e['city'] == city);
      } else {
        cities.add(city.toJson());
      }

      storage.setTo('LOCATION_PERSISTED', jsonEncode(cities));

      notifyListeners();
    }
  }
}
