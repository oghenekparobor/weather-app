import 'package:injectable/injectable.dart';
import 'package:weather_app_test_foodcourt/core/env/env.dart';
import 'package:weather_app_test_foodcourt/core/logger/log.dart';
import 'package:weather_app_test_foodcourt/core/network/dio.dart';
import 'package:weather_app_test_foodcourt/core/params/location.dart';

abstract class RemoteDS {
  Future getForecast(LocationParam param);
}

@LazySingleton(as: RemoteDS)
class RemoteDSImpl extends RemoteDS {
  RemoteDSImpl({
    required this.requester,
  });

  final NetworkRequester requester;

  @override
  Future getForecast(LocationParam param) async {
    AppLogger.log(param);

    return await requester.get(
      '/data/2.5/weather?lat=${param.latitude}&lon=${param.longitude}&appid=${Env.apiKey}',
    );
  }
}
