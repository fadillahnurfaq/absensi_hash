import 'package:absensi_hash/utils/extensions/datetime_extension.dart';
import 'package:absensi_hash/utils/extensions/string_extensions.dart';
import 'package:absensi_hash/utils/styles.dart';
import 'package:absensi_hash/views/attendance/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/attendance/attendance_local_service.dart';
import '../../utils/injector.dart';
import '../../widgets/widgets.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late final AttendanceController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(AttendanceController(service: getIt<AttendanceLocalService>()));
  }

  @override
  void dispose() {
    Get.delete<AttendanceController>();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: Obx(() {
                return ResultImplementer(
                  requestState: _controller.resultAttendancesRx.value,
                  isSliver: true,
                  successWidget: (result) {
                    final today = result.firstWhereOrNull((element) => element.isToday);
                    return SliverMarker(
                      sliver: SliverMainAxisGroup(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Today Attendance",
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    fontWeight: AppTextStyles.bold,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                IntrinsicHeight(
                                  child: Row(
                                    spacing: 6.0,
                                    children: [
                                      Expanded(
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            border: Border.all(
                                              color: AppColors.black
                                            )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              spacing: 6.0,
                                              children: [
                                                Text(
                                                  "Check In",
                                                  style: AppTextStyles.body,
                                                ),
                                                Text(
                                                  today?.checkIn ?? "--:--",
                                                  style: AppTextStyles.bodyLarge.copyWith(
                                                    fontWeight: AppTextStyles.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            border: Border.all(
                                              color: AppColors.black
                                            )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              spacing: 6.0,
                                              children: [
                                                Text(
                                                  "Check Out",
                                                  style: AppTextStyles.body,
                                                ),
                                                Text(
                                                  today?.checkOut ?? "--:--",
                                                  style: AppTextStyles.bodyLarge.copyWith(
                                                    fontWeight: AppTextStyles.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
                          SliverMainAxisGroup(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Text(
                                  "Attendance History",
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    fontWeight: AppTextStyles.bold,
                                  ),
                                ),
                              ),
                              const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
                              if (result.isEmpty)...[
                                const SliverToBoxAdapter(
                                  child: AppEmptyWidget(),
                                )
                              ] else ...[
                                SliverList.separated(
                                  itemCount: result.length,
                                  separatorBuilder: (context, index) => const SizedBox(height: 16.0),
                                  itemBuilder: (context, index) {
                                    final attendance = result[index];
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
                                            Row(
                                              spacing: 16.0,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Check In",
                                                        style: AppTextStyles.body,
                                                      ),
                                                      Text(
                                                        attendance.checkIn.getText(defaultValue: "--:--"),
                                                        style: AppTextStyles.bodyLarge.copyWith(
                                                          fontWeight: AppTextStyles.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Check Out",
                                                        style: AppTextStyles.body,
                                                      ),
                                                      Text(
                                                        attendance.checkOut.getText(defaultValue: "--:--"),
                                                        style: AppTextStyles.bodyLarge.copyWith(
                                                          fontWeight: AppTextStyles.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InfoRow(
                                              title: "Date",
                                              value: attendance.createdAt.formatDate(pattern: "dd MMMM yyyy", onNull: "--"),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ]
                              
                            ]
                          )
                        ],
                      ),
                    );
                  },
                );
              },)
            ),
          ],
        ),
      ),
    );
  }
}