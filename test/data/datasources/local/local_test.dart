import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_test_foodcourt/data/datasources/local/local.dart';

class MockLocation extends Mock implements Location {}

class MockRootBundle extends Mock implements AssetBundle {}

void main() {
  late MockLocation location;
  late MockRootBundle rootBundle;
  late LocalDSImpl local;

  setUp(() {
    location = MockLocation();
    rootBundle = MockRootBundle();
    local = LocalDSImpl(location: location);
  });
  testWidgets('fromJson', (tester) async {
    // arrange
    const String path = 'assets/ng.json';
    String result = jsonEncode([
      {
        "city": "Lagos",
        "lat": "6.4550",
        "lng": "3.3841",
        "country": "Nigeria",
        "iso2": "NG",
        "admin_name": "Lagos",
        "capital": "minor",
        "population": "16637000",
        "population_proper": "16637000"
      }
    ]);

    when(() => rootBundle.loadString(path)).thenAnswer((_) async => result);

    // act
    var res = await local.fromJson(path);

    // assert
    expect(res, isA<String>());
  });

  testWidgets('deviceLocation', (tester) async {
    // arrange
    LocationData expectedLocationData = LocationData.fromMap({
      "latitude": 37.7749,
      "longitude": -122.4194,
    });

    when(
      () => location.getLocation(),
    ).thenAnswer((_) async => expectedLocationData);

    // act
    var res = await local.deviceLocation();

    // assert
    expect(res, isA<LocationData>());
    expect(res.latitude, isA<double?>());
    expect(res.longitude, isA<double?>());
  });
}
