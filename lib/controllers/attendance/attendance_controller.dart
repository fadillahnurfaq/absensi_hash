import 'package:absensi_hash/models/attendance/t_attendance.dart';
import 'package:absensi_hash/services/attendance/attendance_local_service.dart';
import 'package:absensi_hash/utils/extensions/datetime_extension.dart';
import 'package:absensi_hash/utils/helper/location_helper.dart';
import 'package:absensi_hash/utils/hive/hive_boxes.dart';
import 'package:absensi_hash/utils/hive/hive_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../../models/location/m_location.dart';
import '../../utils/helper/app_helper.dart';
import '../../utils/styles.dart';

class AttendanceController extends GetxController {
  final AttendanceLocalService service;

  AttendanceController({required this.service});

  AttendanceControllerDelegate? _delegate;

  late final DateTime now;

  Rx<Placemark?> placemarkRx = Rx(null);

  Rx<LocationData?> locationRx = Rx(null);
  
  late final MapController mapController;

  Rx<List<Marker>> markersRx = Rx([]);

  RxBool isLoadingRx = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    mapController = MapController();
    getCurrentLocation();
    now = DateTime.now();
  }

  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }

  void setDelegate(AttendanceControllerDelegate delegate) {
    _delegate = delegate;
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoadingRx.value = true;
      bool allowPermission = await LocationHelper.requestPermissionLocation();
      if (!allowPermission) return;
      final currentLocation = await LocationHelper.getCurrentLocation();
      if (currentLocation?.latitude == null || currentLocation?.longitude == null) {
        _delegate?.onShowError("Gagal mendapatkan lokasi Anda.");
        return;
      }
      locationRx.value = currentLocation;
      locationRx.refresh();

      mapController.move(LatLng(currentLocation!.latitude!, currentLocation.longitude!), 15.0);

      _setAddress();
    } finally {
      isLoadingRx.value = false;
    }
  }

  Future<void> _setAddress() async {
    final location = locationRx.value;
    final placemarks = await placemarkFromCoordinates(location!.latitude!, location.longitude!);

    placemarkRx.value = placemarks.firstOrNull;
    placemarkRx.refresh();
    final locationBox = await HiveService.getBox<MLocation>(HiveBoxes.location);
    final locations = locationBox.values.toList();
    markersRx.value = [
      Marker(
        point: LatLng(
          location.latitude!,
          location.longitude!,
        ),
        child: const Icon(
          Icons.location_on,
          color: AppColors.primary,
          size: 30.0,
        ),
      ),
      ...locations.map((location) => Marker(
        point: LatLng(
          location.latitude,
          location.longitude,
        ),
        child: const Icon(
          Icons.apartment,
          color: AppColors.primary,
          size: 30.0,
        ),
      ))
    ];
    markersRx.refresh();
  }

  bool get isEligibleToSave => 
    locationRx.value?.latitude != null 
    && locationRx.value?.longitude != null
    && placemarkRx.value != null;

  Future<MLocation?> _validateAttendanceLocation() async {
    final currentLatitude = locationRx.value?.latitude;
    final currentLongitude = locationRx.value?.longitude;

    if (currentLatitude == null || currentLongitude == null) {
      return null;
    }

    final locationBox = await HiveService.getBox<MLocation>(HiveBoxes.location);

    return locationBox.values.toList().firstWhereOrNull(
      (location) => location.isInRadius(
        latitude: currentLatitude,
        longitude: currentLongitude,
      ),
    );
  }

  Future<void> save({required final TAttendance? attendance}) async {
    _delegate?.onHideKeyboard();
    _delegate?.onShowLoading();
    final matchedLocation = await _validateAttendanceLocation();

    if (matchedLocation == null) {
      _delegate?.onBack();
      _delegate?.onShowError(
        "Anda berada di luar radius lokasi absensi",
      );
      return;
    }

    final parameter = TAttendance(
      id: attendance?.id ?? AppHelper.generateRandomId(),
      latitude: locationRx.value!.latitude!,
      longitude: locationRx.value!.longitude!,
      address: placemarkRx.value?.name ?? "",
      checkIn: attendance?.checkIn ?? now.formatDate(pattern: "HH:mm"),
      checkOut: (attendance?.checkIn.isNotEmpty ?? false) && (attendance?.checkOut.isEmpty ?? true) 
        ? now.formatDate(pattern: "HH:mm")
        : "",
      createdAt: attendance?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now()
    );
    final result = await service.createOrEdit(parameter);
    _delegate?.onBack();
    result.fold((l) {
      _delegate?.onShowError(l);
    }, (r) {
      _delegate?.onSuccessSave(parameter);
    },);
  }
}

class AttendanceControllerDelegate {
  final void Function() onHideKeyboard;
  final void Function() onShowLoading;
  final void Function() onBack;
  final void Function(String message) onShowError;
  final void Function(TAttendance attendance) onSuccessSave;

  const AttendanceControllerDelegate({
    required this.onHideKeyboard,
    required this.onShowLoading,
    required this.onBack,
    required this.onShowError,
    required this.onSuccessSave,
  });
}