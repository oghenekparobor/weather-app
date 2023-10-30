import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:weather_app_test_foodcourt/core/extension/app_state.dart';
import 'package:weather_app_test_foodcourt/core/logger/log.dart';
import 'package:weather_app_test_foodcourt/core/params/no_param.dart';
import 'package:weather_app_test_foodcourt/core/service-locator/injection_container.dart';
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

  CoreWeather? weathers;

  bool hasError = false;
  bool hasPermission = true;

  Future<void> checkIfHasPermission() async {
    hasPermission =
        ((await sl<Location>().hasPermission()) == PermissionStatus.granted);
  }

  // get the weather information of current location
  Future<void> init() async {
    weathers = null;
    hasError = false;

    initForecaseUsecase.call(params: const NoParams()).then((value) {
      if (!value.isError) {
        weathers = CoreWeather.fromJson((value as LoadedState).data);
      } else {
        hasError = true;
      }

      notifyListeners();
    });
  }

  // get information of selected city
  Future<void> forecast(City city) async {
    weathers = null;
    hasError = false;

    forecastCityUsecase.call(params: city).then((value) {
      if (!value.isError) {
        weathers = CoreWeather.fromJson((value as LoadedState).data);
      } else {
        hasError = true;
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
        for (var city in (value as LoadedState).data as List) {
          allCities.add(City.fromJson(city));
        }
      }

      notifyListeners();
    });
  }

  final StreamController<List<City>> _persistedCities =
      StreamController<List<City>>.broadcast();

  Stream<List<City>> get persistedCities => _persistedCities.stream;

  void refreshStream() {
    _persistedCities.add(cities);
  }

  List<City> cities = [];

  Future<void> getPersistedCities() async {
    var result = storage.getFrom('LOCATION_PERSISTED');

    if (result.isNotEmpty) {
      cities = (jsonDecode(result) as List)
          .map((city) => City.fromJson(city))
          .toList();
    }

    refreshStream();
    notifyListeners();
  }

  Future<void> addRemoveCities(City city) async {
    // rest pageview to my location
    activeCity = 0;

    var result = storage.getFrom('LOCATION_PERSISTED');

    if (result.isNotEmpty) {
      List<dynamic> cityList = jsonDecode(result) as List<dynamic>;

      if (cityList.isNotEmpty) {
        if (cityList.any((e) => e['city'] == city.city)) {
          cityList.removeWhere((e) => e['city'] == city.city);
        } else {
          cityList.add(city.toJson());
        }

        storage.setTo('LOCATION_PERSISTED', jsonEncode(cityList));
      } else {
        cityList = [city.toJson()];

        storage.setTo('LOCATION_PERSISTED', jsonEncode(cityList));
      }
    } else {
      var cityList = [city.toJson()];

      storage.setTo('LOCATION_PERSISTED', jsonEncode(cityList));
    }

    await getPersistedCities();
  }

  bool isCityStored(String cityName) {
    var result = storage.getFrom('LOCATION_PERSISTED');

    if (result.isNotEmpty) {
      List<dynamic> cityList = jsonDecode(result) as List<dynamic>;
      return cityList.any((e) => e['city'] == cityName);
    }

    return false;
  }

  int _activeCity = 0;

  int get activeCity => _activeCity;

  set activeCity(int i) {
    _activeCity = i;

    notifyListeners();
  }

  double computeProgressPercentage(int sunrise, int sunset, int currentTime) {
    if (currentTime <= sunrise) {
      return 0.0; // The sun has not risen yet
    } else if (currentTime >= sunset) {
      return 100.0; // The sun has set
    } else {
      double totalDaylight = (sunset - sunrise) as double;
      double elapsedTime = (currentTime - sunrise) as double;
      return (elapsedTime / totalDaylight) * 100;
    }
  }
}
