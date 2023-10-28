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
import 'package:location/location.dart' as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../../data/datasources/local/local.dart' as _i9;
import '../../data/datasources/remote/remote.dart' as _i7;
import '../../data/repositories/repo.dart' as _i14;
import '../../domain/repositories/repo.dart' as _i13;
import '../../domain/usecases/cities.dart' as _i15;
import '../../domain/usecases/forecast_city.dart' as _i16;
import '../../domain/usecases/init.dart' as _i17;
import '../../domain/usecases/usecases.dart' as _i19;
import '../../presentation/notifier/my_vm.dart' as _i18;
import '../network/dio.dart' as _i6;
import '../network/impl.dart' as _i12;
import '../network/network_info.dart' as _i11;
import '../permission/request.dart' as _i3;
import '../storage/secure.dart' as _i10;
import 'register_module.dart' as _i20;

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
  gh.lazySingleton<_i5.Location>(() => registerModule.location);
  gh.lazySingleton<_i6.NetworkRequester>(
      () => _i6.NetworkRequester(dio: gh<_i4.Dio>()));
  gh.lazySingleton<_i7.RemoteDS>(
      () => _i7.RemoteDSImpl(requester: gh<_i6.NetworkRequester>()));
  await gh.factoryAsync<_i8.SharedPreferences>(
    () => registerModule.preferences,
    preResolve: true,
  );
  gh.lazySingleton<_i9.LocalDS>(
      () => _i9.LocalDSImpl(location: gh<_i5.Location>()));
  gh.lazySingleton<_i10.SecureStorage>(
      () => _i10.SecureStorageImpl(preferences: gh<_i8.SharedPreferences>()));
  gh.lazySingleton<_i11.NetworkInfo>(
      () => _i11.NetworkInfoImpl(storage: gh<_i10.SecureStorage>()));
  gh.lazySingleton<_i12.ImplFormatter>(
      () => _i12.ImplFormatter(networkInfo: gh<_i11.NetworkInfo>()));
  gh.lazySingleton<_i13.MyRepo>(() => _i14.MyRepoImpl(
        localDS: gh<_i9.LocalDS>(),
        remoteDS: gh<_i7.RemoteDS>(),
        fmt: gh<_i12.ImplFormatter>(),
      ));
  gh.lazySingleton<_i15.CitiesUsecase>(
      () => _i15.CitiesUsecase(repo: gh<_i13.MyRepo>()));
  gh.lazySingleton<_i16.ForecastCityUsecase>(
      () => _i16.ForecastCityUsecase(repo: gh<_i13.MyRepo>()));
  gh.lazySingleton<_i17.InitForecaseUsecase>(
      () => _i17.InitForecaseUsecase(repo: gh<_i13.MyRepo>()));
  gh.factory<_i18.MyViewModel>(() => _i18.MyViewModel(
        citiesUsecase: gh<_i19.CitiesUsecase>(),
        forecastCityUsecase: gh<_i19.ForecastCityUsecase>(),
        initForecaseUsecase: gh<_i19.InitForecaseUsecase>(),
        storage: gh<_i10.SecureStorage>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i20.RegisterModule {}
