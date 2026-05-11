import 'package:absensi_hash/views/location/add_location_view.dart';
import 'package:absensi_hash/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/styles.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

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
                    onPressed: () => Get.to(AddLocationView()),
                    label: "Add Location",
                  )
                ],
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                    sliver: SliverList.separated(
                      itemCount: 4,
                      separatorBuilder: (context, index) => const SizedBox(height: 16.0),
                      itemBuilder: (context, index) {
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
                                  "Address : Jl. Jenderal Sudirman No. 1, Jakarta Selatan, DKI Jakarta",
                                  style: AppTextStyles.body,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}