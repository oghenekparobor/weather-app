import 'package:go_router/go_router.dart';
import 'package:weather_app_test_foodcourt/presentation/pages/city.dart';
import 'package:weather_app_test_foodcourt/presentation/pages/home.dart';

class MyRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/cities',
        builder: (context, state) => const CitiesPage(),
      ),
    ],
  );
}
