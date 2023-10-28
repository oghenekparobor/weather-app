import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

abstract class LocalDS {
  Future<String> fromJson(String path);
  Future<LocationData> deviceLocation();
}

@LazySingleton(as: LocalDS)
class LocalDSImpl extends LocalDS {
  LocalDSImpl({
    required this.location,
  });

  final Location location;

  @override
  Future<String> fromJson(String path) async {
    return await rootBundle.loadString(path);
  }

  @override
  Future<LocationData> deviceLocation() async {
    return await location.getLocation();
  }
}
