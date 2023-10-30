import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app_test_foodcourt/core/network/network_info.dart';
import 'package:weather_app_test_foodcourt/core/state/state.dart';

@lazySingleton
class ImplFormatter {
  ImplFormatter({
    required this.networkInfo,
  });

  final NetworkInfo networkInfo;

  Future<AppState> format(Function function, {bool isLocal = false}) async {
    if (await networkInfo.isConnected() || isLocal) {
      try {
        return LoadedState(await function.call());
      } on DioException catch (e) {
        if (e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.connectionTimeout) {
          return ErrorState('Connection timed out');
        }

        if (e.response == null || e.response!.data == null) {
          return ErrorState(e.response?.data['message'] ?? e.message);
        }

        if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
          return ErrorState(e.response?.data['message']);
        }

        return ErrorState(e.message ?? '');
      } catch (e) {
        return ErrorState(e.toString());
      }
    } else {
      return ErrorState('Please check your internet');
    }
  }
}
