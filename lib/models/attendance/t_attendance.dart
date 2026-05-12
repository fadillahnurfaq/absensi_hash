import 'package:hive_ce/hive.dart';

part 't_attendance.g.dart';

@HiveType(typeId: 1)
class TAttendance {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final double latitude;

  @HiveField(2)
  final double longitude;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String checkIn;

  @HiveField(5)
  final String checkOut;

  @HiveField(6)
  final DateTime? createdAt;

  @HiveField(7)
  final DateTime? updatedAt;

  @HiveField(8)
  final String locationId;

  const TAttendance({
    this.id = "",
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.address = "",
    this.checkIn = "",
    this.checkOut = "",
    this.createdAt,
    this.updatedAt,
    this.locationId = "",
  });

  TAttendance asNewObject() {
    return TAttendance(
      id: id,
      latitude: latitude,
      longitude: longitude,
      address: address,
      checkIn: checkIn,
      checkOut: checkOut,
      createdAt: createdAt,
      updatedAt: updatedAt,
      locationId: locationId,
    );
  }

  bool get isToday => createdAt != null && createdAt!.isAfter(DateTime.now().subtract(const Duration(days: 1)));
}