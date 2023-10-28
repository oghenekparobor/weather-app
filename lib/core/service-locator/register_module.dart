import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(
          connectTimeout: const Duration(milliseconds: 1),
          receiveTimeout: const Duration(milliseconds: 1),
        ),
      );

  @preResolve
  Future<SharedPreferences> get preferences => SharedPreferences.getInstance();

  @lazySingleton
  Location get location => Location();
}
