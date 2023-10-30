import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_test_foodcourt/core/app_strings.dart';
import 'package:weather_app_test_foodcourt/core/network/dio.dart';
import 'package:weather_app_test_foodcourt/core/network/impl.dart';
import 'package:weather_app_test_foodcourt/core/params/location.dart';
import 'package:weather_app_test_foodcourt/core/state/state.dart';
import 'package:weather_app_test_foodcourt/data/datasources/local/local.dart';
import 'package:weather_app_test_foodcourt/data/datasources/remote/remote.dart';
import 'package:weather_app_test_foodcourt/data/repositories/repo.dart';
import 'package:weather_app_test_foodcourt/domain/repositories/repo.dart';

class MockNetworkRequester extends Mock implements NetworkRequester {}

class MockFormatter extends Mock implements ImplFormatter {}

class MockRemote extends Mock implements RemoteDS {}

class MockLocal extends Mock implements LocalDS {}

void main() {
  late MockFormatter fmt;
  late MockLocal local;
  late MockRemote remote;
  late MyRepo repo;

  setUp(() {
    fmt = MockFormatter();
    local = MockLocal();
    remote = MockRemote();

    repo = MyRepoImpl(localDS: local, remoteDS: remote, fmt: fmt);
  });

  testWidgets('forecastCity repo ...', (tester) async {
    // arrange
    var locationParam = const LocationParam(
      latitude: 12.4,
      longitude: -2.3,
    );

    Map<String, dynamic> response = {
      "lat": 33.44,
      "lon": -94.04,
      "timezone": "America/Chicago",
      "timezone_offset": -18000,
      "current": {
        "dt": 1684929490,
        "sunrise": 1684926645,
        "sunset": 1684977332,
        "temp": 292.55,
        "feels_like": 292.87,
        "pressure": 1014,
        "humidity": 89,
        "dew_point": 290.69,
        "uvi": 0.16,
        "clouds": 53,
        "visibility": 10000,
        "wind_speed": 3.13,
        "wind_deg": 93,
        "wind_gust": 6.71,
        "weather": [
          {
            "id": 803,
            "main": "Clouds",
            "description": "broken clouds",
            "icon": "04d"
          }
        ]
      },
    };

    when(
      () => fmt.format(any()),
    ).thenAnswer((_) async => LoadedState(response));

    when(
      () => remote.getForecast(locationParam),
    ).thenAnswer((_) async => response);

    // act
    var res = await repo.forecastCity(locationParam);

    // assert
    expect(res, isA<LoadedState>());
    expect((res as LoadedState).data, isA<Map<String, dynamic>>());
    expect(res.data['lat'], isA<double>());
    expect(res.data['lon'], isA<double>());
  });

  testWidgets('getCities repo ...', (tester) async {
    // arrange

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

    when(
      () => fmt.format(any()),
    ).thenAnswer((_) async => LoadedState(result));

    when(
      () => local.fromJson(Strings.citiesFile),
    ).thenAnswer((_) async => result);

    // act
    var res = await repo.getCities();

    // assert
    expect(res, isA<LoadedState>());
  });

  testWidgets('initForecast repo ...', (tester) async {
    // arrange

    Map<String, dynamic> response = {
      "lat": 33.44,
      "lon": -94.04,
      "timezone": "America/Chicago",
      "timezone_offset": -18000,
      "current": {
        "dt": 1684929490,
        "sunrise": 1684926645,
        "sunset": 1684977332,
        "temp": 292.55,
        "feels_like": 292.87,
        "pressure": 1014,
        "humidity": 89,
        "dew_point": 290.69,
        "uvi": 0.16,
        "clouds": 53,
        "visibility": 10000,
        "wind_speed": 3.13,
        "wind_deg": 93,
        "wind_gust": 6.71,
        "weather": [
          {
            "id": 803,
            "main": "Clouds",
            "description": "broken clouds",
            "icon": "04d"
          }
        ]
      },
    };

    var location = LocationData.fromMap({
      'latitude': 3.2,
      'longitude': 5.4,
    });

    when(
      () => fmt.format(any()),
    ).thenAnswer((_) async => LoadedState(response));

    when(
      () => local.deviceLocation(),
    ).thenAnswer((_) async => location);

    // act
    var res = await repo.initForecast();

    // assert
    expect(res, isA<LoadedState>());
    expect((res as LoadedState).data, isA<Map<String, dynamic>>());
  });
}
