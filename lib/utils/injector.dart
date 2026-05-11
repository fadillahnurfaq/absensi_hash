import 'package:absensi_hash/services/location/location_local_service.dart';
import 'package:get_it/get_it.dart';


final GetIt getIt = GetIt.instance;
class Injector {
  Injector._();
  
  static void setUp() {
    getIt.registerLazySingleton<LocationLocalService>(() => const LocationLocalService());
  }
}