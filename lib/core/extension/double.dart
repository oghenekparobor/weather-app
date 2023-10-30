import 'package:intl/intl.dart';

extension DoubleExt on double {
  String get kelvinToCelsius => (this - 273.15).toStringAsFixed(2);
}

extension IntExt on int {
  String get readableTime {
    var date = DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: true);
    var formatter = DateFormat('EEEE, HH a');

    return formatter.format(date);
  }

  String get toTime {
    var date = DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: true);
    var formatter = DateFormat('HH:MM a');

    return formatter.format(date);
  }
}
