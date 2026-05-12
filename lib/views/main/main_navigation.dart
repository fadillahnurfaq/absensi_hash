import 'package:absensi_hash/utils/styles.dart';
import 'package:absensi_hash/controllers/dashboard/dashboard_controller.dart';
import 'package:absensi_hash/views/attendance/attendance_view.dart';
import 'package:absensi_hash/views/main/location_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_view.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late final ValueNotifier<int> _indexVn;

  @override
  void initState() {
    super.initState();
    _indexVn = ValueNotifier(0);
  }

  @override
  void dispose() {
    _indexVn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _indexVn,
        builder: (context, index, child) {
          return IndexedStack(
            index: index,
            children: const [
              DashboardView(),
              LocationView()
            ]
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() {
        final resultAttendances = Get.find<DashboardController>().resultAttendancesRx.value;
        final attendances = resultAttendances.resultValue ?? [];
        final today = attendances.firstWhereOrNull((element) => element.isToday);
        final bool isEligibleToAbsence = (today == null || today.checkOut.isEmpty) && resultAttendances.isSuccess;
        if (!isEligibleToAbsence) return const SizedBox.shrink();
        return FloatingActionButton(
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
          onPressed: () => Get.to(AttendanceView(attendance: today)),
        );
      },),
      bottomNavigationBar: Container(
        width: double.infinity,
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
        child: BottomAppBar(
          color: AppColors.white,
          notchMargin: 5.0,
          shape: const CircularNotchedRectangle(),
          child: ValueListenableBuilder(
            valueListenable: _indexVn,
            builder: (context, index, child) {
              return BottomNavigationBar(
                backgroundColor: AppColors.white,
                selectedItemColor: AppColors.primary,
                elevation: 0.0,
                onTap: (value) => _indexVn.value = value,
                currentIndex: index,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home"
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.note),
                    label: "Location"
                  ),
                ]
              );
            }
          ),
        ),
      ),
    );
  }
}