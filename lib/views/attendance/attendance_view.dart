import 'package:absensi_hash/controllers/dashboard/dashboard_controller.dart';
import 'package:absensi_hash/models/attendance/t_attendance.dart';
import 'package:absensi_hash/utils/extensions/string_extensions.dart';
import 'package:absensi_hash/utils/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../controllers/attendance/attendance_controller.dart';
import '../../services/attendance/attendance_local_service.dart';
import '../../utils/extensions/context_extensions.dart';
import '../../utils/helper/dialog_helper.dart';
import '../../utils/styles.dart';
import '../../widgets/button.dart';
import '../../widgets/widgets.dart';

class AttendanceView extends StatefulWidget {
  final TAttendance? attendance;

  const AttendanceView({super.key, required this.attendance});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  late final AttendanceController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(AttendanceController(service: getIt<AttendanceLocalService>()));
    _setDelegate();
  }
  
  @override
  void dispose() {
    Get.delete<AttendanceController>();
    super.dispose();
  }

  void _setDelegate() {
    _controller.setDelegate(
      AttendanceControllerDelegate(
        onHideKeyboard: context.hideKeyboard,
        onShowLoading: DialogHelper.showLoading,
        onBack: Get.back,
        onShowError: (message) => DialogHelper.showSnacbar(message: message),
        onSuccessSave: (location) {
          Get.back();
          Get.find<DashboardController>().getAttendances(isRefresh: true);
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.attendance?.checkOut.isNotEmpty ?? false ? "Check Out" : "Check In",
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: AppTextStyles.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.0,
          children: [
            SizedBox(
              height: 250.0,
              width: double.infinity,
              child: Obx(() {
                final location = _controller.locationRx.value;
                final markers = _controller.markersRx.value;
                return AppMaps(
                  mapController: _controller.mapController,
                  location: location?.latitude != null && location?.longitude != null
                    ? LatLng(location!.latitude!, location.longitude!)
                    : null,
                  children: [
                    if (markers.isNotEmpty)...[
                      MarkerLayer(markers: markers)
                    ]
                  ],
                );
              },),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(() {
                final placemark = _controller.placemarkRx.value;
                final bool isLoading = _controller.isLoadingRx.value && placemark == null;
                if (isLoading) {
                  return const SkeletonLoadingWidget(height: 20.0);
                }
                String address = "${placemark?.street.getText()}, ${placemark?.locality.getText()}, ${placemark?.postalCode.getText()}, ${placemark?.country.getText()}";
                return InfoRow(
                  title: "Address",
                  value: address,
                );
              },),
            )
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: context.bottomPadding + 8.0,
            ),
            decoration: const BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.gray200,
                  spreadRadius: 7,
                  blurRadius: 8,
                  offset: Offset(1, 4),
                ),
              ],
            ),
            child: Obx(() {
              return AppButton.filled(
                width: double.infinity,
                onPressed: () => _controller.save(attendance: widget.attendance),
                disabled: !_controller.isEligibleToSave,
                label: "Save",
              );
            },),
          )
        ],
      ),
    );
  }
}