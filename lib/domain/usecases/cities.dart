import 'package:injectable/injectable.dart';
import 'package:weather_app_test_foodcourt/core/params/no_param.dart';
import 'package:weather_app_test_foodcourt/core/state/state.dart';
import 'package:weather_app_test_foodcourt/core/usecase/usecase.dart';
import 'package:weather_app_test_foodcourt/domain/repositories/repo.dart';

@lazySingleton
class CitiesUsecase extends UseCase<AppState, NoParams> {
  CitiesUsecase({
    required this.repo,
  });

  final MyRepo repo;

  @override
  Future<AppState> call({required NoParams params}) async {
    return await repo.getCities();
  }
}
