import 'dart:math';

import 'package:hive_ce/hive.dart';

part 'm_location.g.dart';

@HiveType(typeId: 0)
class MLocation {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String address;

  @HiveField(2)
  final double latitude;

  @HiveField(3)
  final double longitude;

  @HiveField(4)
  final DateTime? createdAt;

  MLocation({
    this.id = "",
    this.address = "",
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.createdAt,
  });


  MLocation asNewObject() {
    return MLocation(
      id: id,
      address: address,
      latitude: latitude,
      longitude: longitude,
      createdAt: createdAt,
    );
  }
}

extension MLocationExtension on MLocation {
  bool isInRadius({
    required double latitude,
    required double longitude,
    double radiusInMeter = 50,
  }) {
    final distance = _calculateDistance(
      startLatitude: latitude,
      startLongitude: longitude,
      endLatitude: this.latitude,
      endLongitude: this.longitude,
    );

    return distance <= radiusInMeter;
  }

  double _calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    const earthRadius = 6371000;

    final dLat = _toRadians(endLatitude - startLatitude);
    final dLon = _toRadians(endLongitude - startLongitude);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(startLatitude)) *
            cos(_toRadians(endLatitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }
}