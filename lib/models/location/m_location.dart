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