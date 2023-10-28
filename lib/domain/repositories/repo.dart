import 'package:weather_app_test_foodcourt/core/params/location.dart';
import 'package:weather_app_test_foodcourt/core/state/state.dart';

abstract class MyRepo {
  Future<AppState> initForecast();
  Future<AppState> forecastCity(LocationParam param);
  Future<AppState> getCities();
}
