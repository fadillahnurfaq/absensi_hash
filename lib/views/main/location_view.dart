import 'package:absensi_hash/controllers/location/location_controller.dart';
import 'package:absensi_hash/utils/injector.dart';
import 'package:absensi_hash/views/location/add_location_view.dart';
import 'package:absensi_hash/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/location/location_local_service.dart';
import '../../utils/styles.dart';
import '../../widgets/widgets.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  late final LocationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(LocationController(service: getIt<LocationLocalService>()));
  }

  @override
  void dispose() {
    Get.delete<LocationController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.0,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Location",
                      style: AppTextStyles.bodyLarge.copyWith(fontWeight: AppTextStyles.bold),
                    )
                  ),
                  AppButton.filled(
                    height: 24.0,
                    onPressed: () => Get.to(const AddLocationView()),
                    label: "Add Location",
                  )
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () => _controller.getLocations(isRefresh: true),
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                      sliver: Obx(() {
                        return ResultImplementer(
                          requestState: _controller.resultLocationsRx.value,
                          isSliver: true,
                          successWidget: (result) {
                            return SliverMarker(
                              sliver: SliverList.separated(
                                itemCount: result.length,
                                separatorBuilder: (context, index) => const SizedBox(height: 16.0),
                                itemBuilder: (context, index) {
                                  final location = result[index];
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: AppColors.black,
                                      )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        spacing: 8.0,
                                        children: [
                                          Text(
                                            "Address : ${location.address}",
                                            style: AppTextStyles.body,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}