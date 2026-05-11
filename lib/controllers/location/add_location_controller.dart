import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../utils/styles.dart';

class AddLocationController extends GetxController {
  Rx<PickedData?> selectedLocationRx = Rx(null);

  late final MapController mapController;
  Rx<List<Marker>> markersRx = Rx([]);

  @override
  void onInit() {
    super.onInit();
    mapController = MapController();
  }

  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }

  void setSelectedLocation(PickedData location) {
    selectedLocationRx.value = location;
    selectedLocationRx.refresh();
    _setMarkers();
    mapController.move(LatLng(location.latLong.latitude, location.latLong.longitude), 15.0);
  }

  void _setMarkers() {
    markersRx.value = [
      Marker(
        point: LatLng(
          selectedLocationRx.value!.latLong.latitude,
          selectedLocationRx.value!.latLong.longitude,
        ),
        child: const Icon(
          Icons.location_on,
          color: AppColors.primary,
          size: 30.0,
        ),
      ),
    ];
    markersRx.refresh();
  }
}