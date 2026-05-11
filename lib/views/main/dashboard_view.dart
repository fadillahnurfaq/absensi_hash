import 'package:absensi_hash/utils/styles.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
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
                                          "16:00",
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
                                          "16:00",
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
                      SliverList.separated(
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
                                              "16:00",
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
                                              "16:00",
                                              style: AppTextStyles.bodyLarge.copyWith(
                                                fontWeight: AppTextStyles.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Date : ${DateTime.now()}",
                                    style: AppTextStyles.body,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ]
                  )
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}