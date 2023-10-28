import 'package:injectable/injectable.dart';
import 'package:weather_app_test_foodcourt/core/params/location.dart';
import 'package:weather_app_test_foodcourt/core/state/state.dart';
import 'package:weather_app_test_foodcourt/core/usecase/usecase.dart';
import 'package:weather_app_test_foodcourt/data/models/city.dart';
import 'package:weather_app_test_foodcourt/domain/repositories/repo.dart';

@lazySingleton
class ForecastCityUsecase extends UseCase<AppState, City> {
  ForecastCityUsecase({
    required this.repo,
  });

  final MyRepo repo;

  @override
  Future<AppState> call({required City params}) async {
    return await repo.forecastCity(LocationParam(
      latitude: double.parse(params.lat),
      longitude: double.parse(params.lng),
    ));
  }
}
