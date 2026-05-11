import 'package:absensi_hash/models/location/m_location.dart';
import 'package:absensi_hash/models/result.dart';
import 'package:absensi_hash/services/location/location_local_service.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final LocationLocalService service;

  LocationController({
    required this.service
  });

  Rx<Result<List<MLocation>>> resultLocationsRx = Rx(const Result.initial());
  
  @override
  void onInit() {
    super.onInit();
    getLocations();
  }

  Future<void> getLocations({bool isRefresh = false}) async {
    if (!isRefresh) {
      resultLocationsRx.value = const Result.loading();
      resultLocationsRx.refresh();
    }
    final result = await service.getList();
    resultLocationsRx.value = result.fold((l) => Result.failed(l), (r) => Result.success(r));
    resultLocationsRx.refresh();
  }

  void addLocation(MLocation location) {
    final List<MLocation> locations = List.from(resultLocationsRx.value.resultValue ?? []);
    locations.insert(0, location);
    resultLocationsRx.value = Result.success(locations);
    resultLocationsRx.refresh();
  }
}