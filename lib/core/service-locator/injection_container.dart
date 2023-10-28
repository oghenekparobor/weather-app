import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app_test_foodcourt/core/service-locator/injection_container.config.dart';

GetIt sl = GetIt.instance;
@InjectableInit(
  asExtension: false,
  preferRelativeImports: true,
)
Future<void> configureDependencies() async => init(sl);
