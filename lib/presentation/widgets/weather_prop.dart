import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_test_foodcourt/core/extension/context.dart';

class WeatherProp extends StatelessWidget {
  const WeatherProp({
    super.key,
    required this.content,
    required this.title,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: context.textTheme.headlineSmall!.copyWith(
              fontSize: 16.sp,
            ),
          ),
          Text(
            content,
            textAlign: TextAlign.start,
            style: context.textTheme.headlineSmall!.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          50.verticalSpace,
        ],
      ),
    );
  }
}
