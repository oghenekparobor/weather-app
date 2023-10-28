import 'package:equatable/equatable.dart';

class LocationParam extends Equatable {
  const LocationParam({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [longitude, latitude];
}
