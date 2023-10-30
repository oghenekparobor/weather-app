import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_test_foodcourt/core/extension/context.dart';
import 'package:weather_app_test_foodcourt/presentation/widgets/arc.dart';

class SunriseSunset extends StatelessWidget {
  const SunriseSunset({
    super.key,
    this.size = 300,
    this.progress = 45,
    this.activeColor = Colors.orange,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.begin = '0:00 am',
    this.end = '0:00 pm',
  });

  final double size;
  final double progress;
  final Color activeColor;
  final Color backgroundColor;
  final String begin;
  final String end;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (size + 20).w,
      height: (size + 20).h,
      child: Stack(
        children: [
          Align(
            child: ClipPath(
              clipper: ArcClipper(),
              child: Container(
                height: size.w,
                width: size.h,
                alignment: Alignment.center,
                color: backgroundColor,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: size.h,
                        width: (progress / 100) * size,
                        alignment: Alignment.center,
                        color: activeColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipPath(
                        clipper: ArcClipper(),
                        child: Container(
                          height: size.h,
                          width: size.w,
                          alignment: Alignment.center,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 140.h,
            left: 0.w,
            child: Text(
              begin,
              style: context.textTheme.bodySmall,
            ),
          ),
          Positioned(
            bottom: 140.h,
            right: 0.w,
            child: Text(
              end,
              style: context.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
