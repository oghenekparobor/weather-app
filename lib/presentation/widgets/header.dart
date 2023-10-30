import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_test_foodcourt/core/extension/context.dart';
import 'package:weather_app_test_foodcourt/core/extension/double.dart';
import 'package:weather_app_test_foodcourt/presentation/notifier/my_vm.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Consumer<MyViewModel>(
            builder: (context, value, child) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${value.weathers?.sys.country ?? 'Country'}, ${value.weathers?.name ?? 'City'}',
                  textAlign: TextAlign.start,
                  style: context.textTheme.headlineLarge!.copyWith(
                    color: Colors.black,
                    fontSize: 35.sp,
                  ),
                ),
                5.verticalSpace,
                Text(
                  (value.weathers?.dt ?? 00000).readableTime,
                  textAlign: TextAlign.start,
                  style: context.textTheme.headlineSmall!.copyWith(
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            context.push('/cities');
          },
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 20.w,
                height: 3.h,
                color: Colors.grey,
              ),
              8.verticalSpace,
              Container(
                width: 50.w,
                height: 3.h,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
