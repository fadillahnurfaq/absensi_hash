import 'package:absensi_hash/controllers/location/add_location_controller.dart';
import 'package:absensi_hash/controllers/location/location_controller.dart';
import 'package:absensi_hash/utils/extensions/context_extensions.dart';
import 'package:absensi_hash/utils/helper/dialog_helper.dart';
import 'package:absensi_hash/utils/injector.dart';
import 'package:absensi_hash/views/location/pick_location_view.dart';
import 'package:absensi_hash/widgets/button.dart';
import 'package:absensi_hash/widgets/info_row.dart';
import 'package:absensi_hash/widgets/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../services/location/location_local_service.dart';
import '../../utils/styles.dart';

class AddLocationView extends StatefulWidget {
  const AddLocationView({super.key});

  @override
  State<AddLocationView> createState() => _AddLocationViewState();
}

class _AddLocationViewState extends State<AddLocationView> {
  late final AddLocationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(AddLocationController(service: getIt<LocationLocalService>()));
    _setDelegate();
  }

  @override
  void dispose() {
    Get.delete<AddLocationController>();
    super.dispose();
  }

  void _setDelegate() {
    _controller.setDelegate(
      AddLocationControllerDelegate(
        onHideKeyboard: context.hideKeyboard,
        onShowLoading: DialogHelper.showLoading,
        onBack: Get.back,
        onShowError: (message) => DialogHelper.showSnacbar(message: message),
        onSuccessSave: (location) {
          Get.back();
          Get.find<LocationController>().addLocation(location);
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Location",
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: AppTextStyles.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            SizedBox(
              height: 250.0,
              width: double.infinity,
              child: Stack(
                children: [
                  Obx(() {
                    final location = _controller.selectedLocationRx.value;
                    final markers = _controller.markersRx.value;
                    return AppMaps(
                      mapController: _controller.mapController,
                      location: location != null 
                        ? LatLng(location.latLong.latitude, location.latLong.longitude)
                        : null,
                      children: [
                        if (markers.isNotEmpty)...[
                          MarkerLayer(markers: markers)
                        ]
                      ],
                    );
                  }),
                  Positioned(
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                    child: AppButton.filled(
                      onPressed: () async {
                        final result = await Get.to(const PickLocationView());
                        if (result is PickedData) {
                          _controller.setSelectedLocation(result);
                        }
                      },
                      label: "Pick Location",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Obx(() {
              final location = _controller.selectedLocationRx.value;
              return InfoRow(
                title: "Address",
                value: location != null ? location.address : "",
              );
            },)
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
              final location = _controller.selectedLocationRx.value;
              return AppButton.filled(
                width: double.infinity,
                onPressed: _controller.save,
                disabled: location == null,
                label: "Save",
              );
            },),
          )
        ],
      ),
    );
  }
}
