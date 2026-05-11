import 'package:absensi_hash/services/location/location_local_service.dart';
import 'package:get_it/get_it.dart';

import '../services/attendance/attendance_local_service.dart';


final GetIt getIt = GetIt.instance;
class Injector {
  Injector._();
  
  static void setUp() {
    getIt.registerLazySingleton<LocationLocalService>(() => const LocationLocalService());
    getIt.registerLazySingleton<AttendanceLocalService>(() => const AttendanceLocalService());
  }
}