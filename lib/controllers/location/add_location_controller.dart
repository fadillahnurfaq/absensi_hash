import 'package:absensi_hash/models/location/m_location.dart';
import 'package:absensi_hash/services/location/location_local_service.dart';
import 'package:absensi_hash/utils/helper/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../utils/styles.dart';

class AddLocationController extends GetxController {
  final LocationLocalService service;

  AddLocationController({
    required this.service,
  });

  Rx<PickedData?> selectedLocationRx = Rx(null);

  late final MapController mapController;
  Rx<List<Marker>> markersRx = Rx([]);

  AddLocationControllerDelegate? _delegate;

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

  void setDelegate(AddLocationControllerDelegate delegate) {
    _delegate = delegate;
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

  Future<void> save() async {
    _delegate?.onHideKeyboard();
    _delegate?.onShowLoading();
    final location = MLocation(
      id: AppHelper.generateRandomId(),
      address: selectedLocationRx.value!.address,
      latitude: selectedLocationRx.value!.latLong.latitude,
      longitude: selectedLocationRx.value!.latLong.longitude,
      createdAt: DateTime.now(),
    );
    final result = await service.create(location);
    _delegate?.onBack();
    result.fold((l) {
      _delegate?.onShowError(l);
    }, (r) {
      _delegate?.onSuccessSave(location);
    },);
  }
}

class AddLocationControllerDelegate {
  final void Function() onHideKeyboard;
  final void Function() onShowLoading;
  final void Function() onBack;
  final void Function(String message) onShowError;
  final void Function(MLocation location) onSuccessSave;

  const AddLocationControllerDelegate({
    required this.onHideKeyboard,
    required this.onShowLoading,
    required this.onBack,
    required this.onShowError,
    required this.onSuccessSave,
  });
}