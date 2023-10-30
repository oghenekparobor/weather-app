import 'package:weather_app_test_foodcourt/core/app_strings.dart';

extension StringExt on String {
  String get jpg => 'assets/images/$this.jpg';
  String get png => 'assets/images/$this.png';
  String get icon => 'assets/icons/$this.svg';
  String get json => 'assets/$this.json';
  String get lottie => 'assets/lottiefile/$this.json';

  // get the first letter of every word
  String get initials => isNotEmpty
      ? trim().split(RegExp(' +')).map((String s) => s[0]).join()
      : '';

  String get weatherIcon {
    if (toLowerCase().contains('clouds')) {
      return Strings.cloudy;
    } else if (toLowerCase().contains('rain')) {
      return Strings.rain;
    } else if (toLowerCase().contains('sun')) {
      return Strings.sunny;
    } else if (toLowerCase().contains('snow')) {
      return Strings.snowy;
    } else if (toLowerCase().contains('wind')) {
      return Strings.windy;
    } else if (toLowerCase().contains('storm')) {
      return Strings.thunderStorm;
    } else {
      return Strings.partlyCloudy;
    }
  }
}
