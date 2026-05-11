import 'package:absensi_hash/models/attendance/t_attendance.dart';
import 'package:absensi_hash/models/result.dart';
import 'package:absensi_hash/services/attendance/attendance_local_service.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  final AttendanceLocalService service;

  AttendanceController({
    required this.service,
  });

  Rx<Result<List<TAttendance>>> resultAttendancesRx = Rx(const Result.initial());

  @override
  void onInit() {
    super.onInit();
    getAttendances();
  }

  Future<void> getAttendances({bool isRefresh = false}) async {
    if (!isRefresh) {
      resultAttendancesRx.value = const Result.loading();
      resultAttendancesRx.refresh();
    }
    final result = await service.getList();
    resultAttendancesRx.value = result.fold((l) => Result.failed(l), (r) => Result.success(r));
    resultAttendancesRx.refresh();
  }
}