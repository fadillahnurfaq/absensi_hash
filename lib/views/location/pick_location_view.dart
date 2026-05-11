import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../utils/styles.dart';

class PickLocationView extends StatelessWidget {
  const PickLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pick Location",
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: AppTextStyles.bold),
        ),
      ),
      body: FlutterLocationPicker(
        urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        initZoom: 11,
        minZoomLevel: 5,
        maxZoomLevel: 16,
        trackMyPosition: true,
        searchBarBackgroundColor: Colors.white,
        selectedLocationButtonTextStyle: const TextStyle(fontSize: 18),
        mapLanguage: 'en',
        selectLocationButtonLeadingIcon: const Icon(Icons.check),
        userAgent: 'MyApp/1.0.0 (contact@m_code.com)',
        zoomButtonsBackgroundColor: AppColors.primary,
        locationButtonBackgroundColor: AppColors.primary,
        selectLocationButtonStyle: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.primary),
        ),
        onPicked: (pickedData) {
          Get.back(result: pickedData);
        },
        showContributorBadgeForOSM: true,
      ),
    );
  }
}