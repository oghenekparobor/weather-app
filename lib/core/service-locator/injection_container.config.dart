// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../network/dio.dart' as _i5;
import '../network/impl.dart' as _i9;
import '../network/network_info.dart' as _i8;
import '../permission/request.dart' as _i3;
import '../storage/secure.dart' as _i7;
import 'register_module.dart' as _i10;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AppPermission>(() => _i3.AppPermission());
  gh.lazySingleton<_i4.Dio>(() => registerModule.dio);
  gh.lazySingleton<_i5.NetworkRequester>(
      () => _i5.NetworkRequester(dio: gh<_i4.Dio>()));
  await gh.factoryAsync<_i6.SharedPreferences>(
    () => registerModule.preferences,
    preResolve: true,
  );
  gh.lazySingleton<_i7.SecureStorage>(
      () => _i7.SecureStorageImpl(preferences: gh<_i6.SharedPreferences>()));
  gh.lazySingleton<_i8.NetworkInfo>(
      () => _i8.NetworkInfoImpl(storage: gh<_i7.SecureStorage>()));
  gh.lazySingleton<_i9.ImplFormatter>(
      () => _i9.ImplFormatter(networkInfo: gh<_i8.NetworkInfo>()));
  return getIt;
}

class _$RegisterModule extends _i10.RegisterModule {}
