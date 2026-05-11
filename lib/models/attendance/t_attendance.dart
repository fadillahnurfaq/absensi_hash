import 'package:hive_ce/hive.dart';

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

  const TAttendance({
    this.id = "",
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.address = "",
    this.checkIn = "",
    this.checkOut = "",
    this.createdAt,
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
    );
  }

  bool get isToday => createdAt != null && createdAt!.isAfter(DateTime.now().subtract(const Duration(days: 1)));
}