import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_test_foodcourt/core/env/env.dart';
import 'package:weather_app_test_foodcourt/core/network/dio.dart';
import 'package:weather_app_test_foodcourt/core/params/location.dart';
import 'package:weather_app_test_foodcourt/data/datasources/remote/remote.dart';

class MockNetworkRequester extends Mock implements NetworkRequester {}

void main() {
  late NetworkRequester mockRequester;
  late RemoteDSImpl remoteDS;

  setUp(() {
    mockRequester = MockNetworkRequester();
    remoteDS = RemoteDSImpl(requester: mockRequester);
  });

  test('getForecast sends correct request', () async {
    // arrange
    const LocationParam locationParam = LocationParam(
      latitude: 37.7749,
      longitude: -122.4194,
    );

    String expectedUrl =
        '/data/2.5/weather?lat=37.7749&lon=-122.4194&appid=${Env.apiKey}';

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
      "minutely": [
        {"dt": 1684929540, "precipitation": 0},
      ],
      "hourly": [
        {
          "dt": 1684926000,
          "temp": 292.01,
          "feels_like": 292.33,
          "pressure": 1014,
          "humidity": 91,
          "dew_point": 290.51,
          "uvi": 0,
          "clouds": 54,
          "visibility": 10000,
          "wind_speed": 2.58,
          "wind_deg": 86,
          "wind_gust": 5.88,
          "weather": [
            {
              "id": 803,
              "main": "Clouds",
              "description": "broken clouds",
              "icon": "04n"
            }
          ],
          "pop": 0.15
        },
      ],
      "daily": [
        {
          "dt": 1684951200,
          "sunrise": 1684926645,
          "sunset": 1684977332,
          "moonrise": 1684941060,
          "moonset": 1684905480,
          "moon_phase": 0.16,
          "summary": "Expect a day of partly cloudy with rain",
          "temp": {
            "day": 299.03,
            "min": 290.69,
            "max": 300.35,
            "night": 291.45,
            "eve": 297.51,
            "morn": 292.55
          },
          "feels_like": {
            "day": 299.21,
            "night": 291.37,
            "eve": 297.86,
            "morn": 292.87
          },
          "pressure": 1016,
          "humidity": 59,
          "dew_point": 290.48,
          "wind_speed": 3.98,
          "wind_deg": 76,
          "wind_gust": 8.92,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "clouds": 92,
          "pop": 0.47,
          "rain": 0.15,
          "uvi": 9.23
        },
      ],
      "alerts": []
    };

    // Stub the requester's get method
    when(() => mockRequester.get(expectedUrl)).thenAnswer(
      (_) async => response,
    );

    // act
    var res = await remoteDS.getForecast(locationParam);

    // assert
    expect(res, response);
    expect(res, isA<Map<String, dynamic>>());

    verify(() => mockRequester.get(expectedUrl)).called(1);
  });
}
