import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:weather_app_test_foodcourt/core/app_strings.dart';
import 'package:weather_app_test_foodcourt/core/network/impl.dart';
import 'package:weather_app_test_foodcourt/core/params/location.dart';
import 'package:weather_app_test_foodcourt/core/state/state.dart';
import 'package:weather_app_test_foodcourt/data/datasources/local/local.dart';
import 'package:weather_app_test_foodcourt/data/datasources/remote/remote.dart';
import 'package:weather_app_test_foodcourt/domain/repositories/repo.dart';

@LazySingleton(as: MyRepo)
class MyRepoImpl implements MyRepo {
  MyRepoImpl({
    required this.localDS,
    required this.remoteDS,
    required this.fmt,
  });

  final LocalDS localDS;
  final RemoteDS remoteDS;
  final ImplFormatter fmt;

  @override
  Future<AppState> forecastCity(LocationParam param) async {
    return await fmt.format(() async {
      // get the forecast for the particular city
      return await remoteDS.getForecast(param);
    });
  }

  @override
  Future<AppState> getCities() async {
    return fmt.format(() async {
      // decode the json string gotten from the local datasource/assets folder
      return jsonDecode(await localDS.fromJson(Strings.citiesFile));
    });
  }

  @override
  Future<AppState> initForecast() async {
    return await fmt.format(() async {
      var location = await localDS.deviceLocation();

      return await remoteDS.getForecast(
        LocationParam(
          latitude: location.latitude ?? 0,
          longitude: location.longitude ?? 0,
        ),
      );
    });
  }
}
