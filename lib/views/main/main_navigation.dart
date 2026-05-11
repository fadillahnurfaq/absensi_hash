import 'package:absensi_hash/utils/styles.dart';
import 'package:absensi_hash/views/main/location_view.dart';
import 'package:flutter/material.dart';
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
    );
  }
}