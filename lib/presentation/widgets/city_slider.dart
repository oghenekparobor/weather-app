import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_test_foodcourt/core/extension/context.dart';
import 'package:weather_app_test_foodcourt/data/models/city.dart';
import 'package:weather_app_test_foodcourt/presentation/notifier/my_vm.dart';

class CitySlider extends StatelessWidget {
  const CitySlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<MyViewModel>();

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 300.w,
        height: 300.h,
        alignment: Alignment.centerLeft,
        child: StreamBuilder<List<City>>(
          stream: vm.persistedCities,
          builder: (context, snapshot) => (snapshot.data == null)
              ? const SizedBox()
              : PageView(
                  scrollDirection: Axis.vertical,
                  padEnds: true,
                  controller: PageController(
                    viewportFraction: .32,
                    initialPage: vm.activeCity,
                  ),
                  onPageChanged: (v) {
                    vm.activeCity = v;

                    if (v == 0) {
                      vm.init();
                    } else {
                      vm.forecast((snapshot.data)![(vm.activeCity - 1)]);
                    }
                  },
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Transform.rotate(
                        angle: 90 * 3.14 / 180,
                        child: Text(
                          'My Location',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: vm.activeCity == 0
                                ? Colors.orange
                                : Colors.black26,
                            fontWeight: vm.activeCity == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: vm.activeCity == 0 ? 16.sp : 13.sp,
                          ),
                        ),
                      ),
                    ),
                    for (var i = 0; i < (snapshot.data!).length; i++)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Transform.rotate(
                          angle: 90 * 3.14 / 180,
                          child: Text(
                            vm.cities[i].city,
                            style: context.textTheme.bodySmall!.copyWith(
                              color: vm.activeCity == (i + 1)
                                  ? Colors.orange
                                  : Colors.black26,
                              fontWeight: vm.activeCity == (i + 1)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize:
                                  vm.activeCity == (i + 1) ? 16.sp : 13.sp,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
