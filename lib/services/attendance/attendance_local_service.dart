import 'package:absensi_hash/models/attendance/t_attendance.dart';
import 'package:absensi_hash/utils/hive/hive_boxes.dart';
import 'package:absensi_hash/utils/hive/hive_services.dart';
import 'package:dartz/dartz.dart';

class AttendanceLocalService {
  const AttendanceLocalService();
  Future<Either<String, void>> createOrEdit(TAttendance attendance) async {
    try {
      final box = await HiveService.getBox<TAttendance>(HiveBoxes.attendance);
      await box.put(attendance.id, attendance.asNewObject());
      return const Right(null);
    } catch (e) {
      return const Left("Something went wrong. Please contact system administrator.");
    }
  }

  Future<Either<String, List<TAttendance>>> getList() async {
    try {
      final box = await HiveService.getBox<TAttendance>(HiveBoxes.attendance);
      final list = box.values.map((e) => e).toList();
      list.sort((a, b) {
        final aDate = a.createdAt;
        final bDate = b.createdAt;

        if (aDate == null && bDate == null) return 0;

        if (aDate == null) return 1;

        if (bDate == null) return -1;

        return bDate.compareTo(aDate);
      });
      return Right(list);
    } catch (e) {
      return const Left("Something went wrong. Please contact system administrator.");
    }
  }
}