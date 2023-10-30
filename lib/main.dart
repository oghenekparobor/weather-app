import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_test_foodcourt/core/routes/route.dart';
import 'package:weather_app_test_foodcourt/core/service-locator/injection_container.dart';
import 'package:weather_app_test_foodcourt/core/theme/theme.dart';
import 'package:weather_app_test_foodcourt/presentation/notifier/my_vm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await configureDependencies();
  // request location use
  await sl<Location>().requestPermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => ChangeNotifierProvider(
        create: (context) => sl<MyViewModel>(),
        builder: (context, _) => NotificationListener(
          child: MaterialApp.router(
            title: 'Weather App',
            theme: theme(context),
            debugShowCheckedModeBanner: false,
            routerConfig: MyRouter.router,
          ),
        ),
      ),
    );
  }
}
