import 'package:flutter/material.dart';
import 'package:weather_app_test_foodcourt/core/routes/route.dart';
import 'package:weather_app_test_foodcourt/core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Weather App',
      theme: theme(context),
      routerConfig: MyRouter.router,
    );
  }
}
