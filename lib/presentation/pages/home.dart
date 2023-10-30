import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_test_foodcourt/core/extension/context.dart';
import 'package:weather_app_test_foodcourt/core/extension/double.dart';
import 'package:weather_app_test_foodcourt/core/extension/string.dart';
import 'package:weather_app_test_foodcourt/core/extension/widget.dart';
import 'package:weather_app_test_foodcourt/core/service-locator/injection_container.dart';
import 'package:weather_app_test_foodcourt/presentation/notifier/my_vm.dart';
import 'package:weather_app_test_foodcourt/presentation/widgets/city_slider.dart';
import 'package:weather_app_test_foodcourt/presentation/widgets/header.dart';
import 'package:weather_app_test_foodcourt/presentation/widgets/sunset.dart';
import 'package:weather_app_test_foodcourt/presentation/widgets/weather_prop.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      var vm = context.read<MyViewModel>();

      vm.checkIfHasPermission();
      vm.getPersistedCities();

      if (vm.hasPermission) vm.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              75.verticalSpace,
              const Header().padHorizontal,
              if (context.read<MyViewModel>().hasPermission) ...{
                Consumer<MyViewModel>(
                  builder: (_, value, __) => value.hasError
                      ? Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                30.verticalSpace,
                                Text(
                                  'An error has occured',
                                  style: context.textTheme.bodyMedium,
                                ),
                                16.verticalSpace,
                                TextButton(
                                  onPressed: () {
                                    if (value.activeCity == 0) {
                                      value.init();
                                    } else {
                                      value.forecast(
                                        value.cities[value.activeCity],
                                      );
                                    }
                                  },
                                  child: const Text('Try Again'),
                                ),
                              ],
                            ),
                          ),
                        )
                      : value.weathers == null
                          ? const Expanded(
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LottieBuilder.asset(
                                    (value.weathers!.weather[0].main)
                                        .weatherIcon,
                                    width: 100.w,
                                    height: 100.h,
                                  ),
                                  8.verticalSpace,
                                  Text(
                                    '${value.weathers!.main.temp.kelvinToCelsius}°',
                                    textAlign: TextAlign.start,
                                    style: context.textTheme.headlineLarge!
                                        .copyWith(
                                      color: Colors.black,
                                      fontSize: 60.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    value.weathers?.weather[0].description ??
                                        '',
                                    textAlign: TextAlign.start,
                                    style: context.textTheme.headlineSmall!
                                        .copyWith(
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                ),
              } else ...{
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        30.verticalSpace,
                        Text(
                          'Please grant Location permission',
                          style: context.textTheme.bodyMedium,
                        ),
                        16.verticalSpace,
                        TextButton(
                          onPressed: () {
                            sl<Location>().requestPermission();
                          },
                          child: const Text('Request permission'),
                        ),
                      ],
                    ),
                  ),
                ),
              },
              SizedBox(
                width: double.infinity,
                height: 320.h,
                child: Consumer<MyViewModel>(
                  builder: (_, value, __) => Stack(
                    children: [
                      Align(
                        child: SunriseSunset(
                          begin: (value.weathers?.sys.sunrise ?? 0).toTime,
                          end: (value.weathers?.sys.sunset ?? 0).toTime,
                          progress: value.computeProgressPercentage(
                            value.weathers?.sys.sunrise ?? 0,
                            value.weathers?.sys.sunrise ?? 0,
                            DateTime.now().millisecondsSinceEpoch,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            WeatherProp(
                              title: 'Pressure',
                              content:
                                  '${value.weathers?.main.pressure ?? 0}hPa',
                            ),
                            WeatherProp(
                              title: 'Visibility',
                              content:
                                  '${(value.weathers?.visibility ?? 0) / 1000}KM',
                            ),
                            WeatherProp(
                              title: 'Humidity',
                              content: '${value.weathers?.main.humidity ?? 0}%',
                            ),
                          ],
                        ).padHorizontal,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const CitySlider(),
        ],
      ),
    );
  }
}
